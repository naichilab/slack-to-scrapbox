require_relative 'slack_api'

class SlackHistoryRepository

  def self.all(channel_id)
    api = SlackApi.new

    latest = nil
    res = []

    loop do
      params_hash = {}
      params_hash['latest'] = latest if latest
      params_hash['inclusive'] = "false" if latest
      params_hash['channel'] = channel_id
      json = api.get('/api/channels.history', params_hash)

      json["messages"].each do |msg|
        file = nil
        file = msg["files"].first["name"] if msg["files"]
        res << SlackHistory.new(msg, msg["type"], msg["subtype"], msg["text"], msg["user"], msg["ts"], file)
        latest = msg["ts"]
      end

      has_more = json['has_more']
      pp "has_more #{has_more} latest #{latest}"
      break unless has_more
    end
    return res.reverse
  end

end
