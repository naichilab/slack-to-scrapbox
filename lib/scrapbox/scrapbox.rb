require 'gyazo'


class Scrapbox
  def initialize(users, slack_history, base_indent = 0)
    @users = users
    @slack_history = slack_history
    @indent = base_indent
  end

  def convert
    return nil if @slack_history.subtype == "channel_join"
    return nil if @slack_history.subtype == "channel_purpose"

    lines = []

    # ユーザー名
    @indent += 1
    add_username_lines lines

    # 発言
    @indent += 1
    add_text_lines lines

    # 添付ファイル
    add_file_lines lines

    lines
  end

  private

  def indent_text
    " " * @indent
  end

  def add_username_lines(lines)
    scrapbox_user_name = get_scrapbox_user
    lines << "#{indent_text}#{scrapbox_user_name}"
  end

  def add_text_lines(lines)

    is_in_code = false

    @slack_history.text.each_line do |line|
      line.chomp! #改行文字を消す

      code_begin_line = (!is_in_code) && (line.include? '```')
      code_end_line = (is_in_code) && (line.include? '```')
      if code_begin_line
        is_in_code = true
        line.gsub!(/```/, 'code:code')
        lines << "#{indent_text}#{line}"
        @indent += 1
      elsif code_end_line
        @indent -= 1
        is_in_code = false
        line.gsub!(/```/, '')
        if line != ""
          lines << "#{indent_text}#{line}"
        end
      else
        line.gsub!(/&gt;/, '>')
        line.gsub!(/\*(.*?)\*/) {"[* #{$1}]"}
        line.gsub!(/_(.*?)_/) {"[/ #{$1}]"}
        line.gsub!(/~(.*?)~/) {"[- #{$1}]"}
        lines << "#{indent_text}#{line}"
      end

      is_first_line = false
    end

    lines
  end

  def add_file_lines(lines)

    # 画像ファイルのダウンロード
    @slack_history.files.each do |f|
      url = f.url_private

      if %w(PNG JPEG GIF).include? f.pretty_type

        # 画像ファイルをダウンロード
        conn = Faraday.new(:url => url) do |faraday|
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
          faraday.headers['Authorization'] = "Bearer #{ENV['SLACK_BOT_USER_OAUTH_ACCESS_TOKEN']}"
        end
        response = conn.get

        if response.status == 200
          FileUtils.mkdir_p("tmp") unless FileTest.exist?("tmp")
          filepath = "tmp/#{f.id}.#{f.filetype}"
          File.open(filepath, 'wb') {|fp| fp.write(response.body)}
        end

        # Gyazoへアップロード
        gyazo = Gyazo::Client.new access_token: ENV["GYAZO_ACCESS_TOKEN"]
        res = gyazo.upload imagefile: filepath
        gyazo_image_url = res[:url]

        lines << "#{indent_text}[#{gyazo_image_url}]"

      elsif f.mimetype == "text/plain"

        # ファイルをダウンロード
        conn = Faraday.new(:url => url) do |faraday|
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
          faraday.headers['Authorization'] = "Bearer #{ENV['SLACK_BOT_USER_OAUTH_ACCESS_TOKEN']}"
        end
        response = conn.get


        lines << "#{indent_text}code:code"
        @indent += 1
        response.body.each_line do |line|
          line.chomp! #改行文字を消す
          lines << "#{indent_text}#{line}"
        end
        @indent -= 1

      elsif ["MPEG 4ビデオ", "Zip", "MP3", "GZip", "PDF"].include? f.pretty_type
        lines << "#{indent_text}添付ファイル : #{f.name}"
      else
        lines << "#{indent_text}添付ファイル : #{f.name}"
        pp "=" * 100
        pp "unknown filetype. #{f.name}"
        pp f.json
      end

    end

  end

  def get_scrapbox_user

    slack_user_id = @slack_history.user
    env_key = "SCR_USER_#{@slack_history.user}"
    scrapbox_user_id = ENV[env_key]
    if scrapbox_user_id != nil && scrapbox_user_id != ""
      user_name = "[#{scrapbox_user_id}.icon]"
    else
      pp "unknown scarapbox user : #{env_key}"
    end

    unless user_name
      user = @users.find {|u| u.id == slack_user_id}
      if user
        user_name = " #{user.real_name}"
      else
        user_name = "unknown"
      end
    end

    user_name
  end

end