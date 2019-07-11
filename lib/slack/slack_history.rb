class SlackHistory
  def initialize(json)
    @json = json
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

  def file
    file = nil
    file = json["files"].first["name"] if json["files"]
  end

  def to_s
    "#{@type} #{@user} #{@ts} #{@text}"
  end

  private

  def json
    @json
  end

end
