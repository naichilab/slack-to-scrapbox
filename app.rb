require 'pp'
require 'dotenv/load'
require 'faraday'
require 'json'

Dir[File.expand_path("../lib/slack/", __FILE__) << '/*.rb'].each {|f| require f}
Dir[File.expand_path("../lib/scrapbox/", __FILE__) << '/*.rb'].each {|f| require f}


channel = SlackChannel.find_by_name_like("kakoton")

users = SlackUserRepository::all

# .env書き出し
# users.each do |k, v|
#   puts "SCR_USER_#{k}=\"\" # #{v.name} (#{v.real_name})"
# end

# pp SlackChannel.find_by_id("CL2D9RQ15")
histories = SlackHistoryRepository::all(channel.id)

lines = []
histories.each_with_index do |h, idx|
  if idx % 100 == 0
    pp "history #{idx}"
  end

  scrapbox_lines = Scrapbox.new(users, h).convert
  lines << scrapbox_lines
end

lines.flatten!
lines.compact!
lines.reject(&:empty?)

FileUtils.mkdir_p("tmp") unless FileTest.exist?("tmp")
File.open("tmp/conversation.txt", "w") do |f|
  f.puts lines.map {|line| line.force_encoding('UTF-8')}.join("\n")
end

#
# def get_channels(conn, token, cursor = nil)
#
#   res = conn.get do |req|
#     req.url '/api/conversations.list'
#     req.params[:cursor] = cursor if cursor
#     req.params[:token] = token
#   end
#
#   res_json = JSON.load(res.body)
#
#   res_json["channels"].each do |c|
#     pp "#{c["id"]} #{c["name"]} #{c["name_normalized"]}"
#   end
#
# end
#
#
# def get_all_channels(conn, token)
#
#
#
# end
#
# #
#


# response = conn.get , {token: token}
# pp res.body # response.body

#
# conn.get '/nigiri', { :name => 'Maguro' }   # GET http://sushi.com/nigiri?name=Maguro
#
# conn.get do |req|                           # GET http://sushi.com/search?page=2&limit=100
#   req.url '/search', :page => 2
#   req.params['limit'] = 100
# end

# ## POST ##
#
# conn.post '/nigiri', { :name => 'Maguro' }  # POST "name=maguro" to http://sushi.com/nigiri
#
# # post payload as JSON instead of "www-form-urlencoded" encoding:
# conn.post do |req|
#   req.url '/nigiri'
#   req.headers['Content-Type'] = 'application/json'
#   req.body = '{ "name": "Unagi" }'
# end
