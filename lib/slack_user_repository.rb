class SlackUserRepository

  def self.all
    api = SlackApi.new

    next_cursor = nil
    res = []

    loop do
      params_hash = {}
      params_hash['cursor'] = next_cursor if next_cursor
      json = api.get('/api/users.list', params_hash)

      json["members"].each do |member|
        res << SlackUser.new(member)
      end

      next_cursor = json['response_metadata']['next_cursor']

      break if next_cursor.nil?
      break if next_cursor == ""
    end

    return res
  end

end
