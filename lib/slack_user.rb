require_relative 'slack_api'

class SlackUser
  attr_reader :id, :name, :real_name

  def initialize(id, name, real_name)
    @id = id
    @name = name
    @real_name = real_name
  end

  def to_s
    "#{@id} #{@name} #{real_name}"
  end

  def self.all
    api = SlackApi.new

    next_cursor = nil
    res = {}

    loop do
      params_hash = {}
      params_hash['cursor'] = next_cursor if next_cursor
      json = api.get('/api/users.list', params_hash)

      json["members"].each do |u|
        id = u["id"]
        res[id] = SlackUser.new(id, u["name"], u["real_name"])
      end

      next_cursor = json['response_metadata']['next_cursor']

      break if next_cursor.nil?
      break if next_cursor == ""
    end

    return res
  end

end
