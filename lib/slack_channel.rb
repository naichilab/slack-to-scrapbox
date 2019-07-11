require_relative 'slack_api'

class SlackChannel
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def to_s
    "#{@id} #{@name} s"
  end

  def self.all
    api = SlackApi.new

    next_cursor = nil
    res = []

    loop do
      params_hash = {}
      params_hash['cursor'] = next_cursor if next_cursor
      json = api.get('/api/conversations.list', params_hash)

      json["channels"].each do |c|
        res << SlackChannel.new(c["id"], c["name"])
      end

      next_cursor = json['response_metadata']['next_cursor']

      break if next_cursor.nil?
      break if next_cursor == ""
    end

    return res
  end

  def self.find_by_id (id)
    all_channels = self.all
    all_channels.each do |c|
      if c.id == id
        return c
      end
    end
    return nil
  end

  def self.find_by_name_like (name)
    all_channels = self.all
    all_channels.each do |c|
      if c.name.include? name
        return c
      end
    end
    return nil
  end


end
