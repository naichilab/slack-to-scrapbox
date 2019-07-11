class SlackHistory
  def initialize(json)
    @json = json
    @files = []


    if json["files"]
      json["files"].each do |f|
        @files << SlackFile.new(f)
      end
    end
  end

  def type
    json["type"]
  end

  def subtype
    json["subtype"]
  end

  def text
    json["text"]
  end

  def user
    json["user"]
  end

  def ts
    json[ts]
  end

  def files
    @files
  end

  def to_s
    "#{@type} #{@user} #{@ts} #{@text}"
  end

  def json
    @json
  end

end
