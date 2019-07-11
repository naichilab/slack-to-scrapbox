class SlackUser

  def initialize(json)
    @json = json
  end

  def id
    json["id"]
  end

  def name
    json["name"]
  end

  def real_name
    json["real_name"]
  end

  def to_s
    "#{id} #{name} #{real_name}"
  end

  private

  def json
    @json
  end

end
