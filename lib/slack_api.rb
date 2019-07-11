require 'faraday'

class SlackApi

  def initialize
    @token = ENV['SLACK_BOT_USER_OAUTH_ACCESS_TOKEN']
    @conn = Faraday.new(:url => 'https://slack.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      # faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def get(uri, params_hash)
    res = @conn.get do |req|
      req.url uri
      req.params[:token] = @token
      params_hash.each do |key, value|
        req.params[key] = value
      end
    end
    json = JSON.load(res.body)
    pp "get #{uri} ok:#{json['ok']}"
    json
  end

end