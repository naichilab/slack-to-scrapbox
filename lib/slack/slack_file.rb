class SlackFile
  def initialize(json)
    @json = json

    pp "=" * 100
    pp json
  end

  def name
    json["name"]
  end

  def to_s
    "#{name}"
  end

  private

  def json
    @json
  end

end
