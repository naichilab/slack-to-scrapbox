class SlackHistory
  attr_reader :json, :type, :subtype, :text, :user, :ts, :file

  def initialize(json, type, subtype, text, user, ts, file)
    @json = json
    @type = type
    @subtype = subtype
    @text = text
    @user = user
    @ts = ts
    @file = file
  end

  def to_s
    "#{@type} #{@user} #{@ts} #{@text}"
  end

end
