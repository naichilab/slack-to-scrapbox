# https://api.slack.com/types/file

class SlackFile
  def initialize(json)
    @json = json
  end

  def id
    json["id"]
  end

  def name
    json["name"]
  end

  def mimetype
    json["mimetype"]
  end

  def filetype
    json["filetype"]
  end

  def url_private
    json["url_private"]
  end

  def pretty_type
    json["pretty_type"]
  end

  def name
    json["name"]
  end

  def to_s
    "#{name}"
  end

  def json2
    @json
  end

  private

  def json
    @json
  end

end

#
# {"id"=>"FLA878SC8",
#  "created"=>1562770675,
#  "timestamp"=>1562770675,
#  "name"=>"スクリーンショット 2019-07-10 23.57.41.png",
#  "title"=>"スクリーンショット 2019-07-10 23.57.41.png",
#  "mimetype"=>"image/png",
#  "filetype"=>"png",
#  "pretty_type"=>"PNG",
#  "user"=>"UE0G20RSP",
#  "editable"=>false,
#  "size"=>92827,
#  "mode"=>"hosted",
#  "is_external"=>false,
#  "external_type"=>"",
#  "is_public"=>true,
#  "public_url_shared"=>false,
#  "display_as_bot"=>false,
#  "username"=>"",
#  "url_private"=>
#      "https://files.slack.com/files-pri/TE21DJBFY-FLA878SC8/____________________________2019-07-10_23.57.41.png",
#  "url_private_download"=>
#      "https://files.slack.com/files-pri/TE21DJBFY-FLA878SC8/download/____________________________2019-07-10_23.57.41.png",
#  "thumb_64"=>
#      "https://files.slack.com/files-tmb/TE21DJBFY-FLA878SC8-9d9faffdd5/____________________________2019-07-10_23.57.41_64.png",
#  "thumb_80"=>
#      "https://files.slack.com/files-tmb/TE21DJBFY-FLA878SC8-9d9faffdd5/____________________________2019-07-10_23.57.41_80.png",
#  "thumb_360"=>
#      "https://files.slack.com/files-tmb/TE21DJBFY-FLA878SC8-9d9faffdd5/____________________________2019-07-10_23.57.41_360.png",
#  "thumb_360_w"=>360,
#  "thumb_360_h"=>199,
#  "thumb_480"=>
#      "https://files.slack.com/files-tmb/TE21DJBFY-FLA878SC8-9d9faffdd5/____________________________2019-07-10_23.57.41_480.png",
#  "thumb_480_w"=>480,
#  "thumb_480_h"=>266,
#  "thumb_160"=>
#      "https://files.slack.com/files-tmb/TE21DJBFY-FLA878SC8-9d9faffdd5/____________________________2019-07-10_23.57.41_160.png",
#  "thumb_720"=>
#      "https://files.slack.com/files-tmb/TE21DJBFY-FLA878SC8-9d9faffdd5/____________________________2019-07-10_23.57.41_720.png",
#  "thumb_720_w"=>720,
#  "thumb_720_h"=>398,
#  "thumb_800"=>
#      "https://files.slack.com/files-tmb/TE21DJBFY-FLA878SC8-9d9faffdd5/____________________________2019-07-10_23.57.41_800.png",
#  "thumb_800_w"=>800,
#  "thumb_800_h"=>443,
#  "image_exif_rotation"=>1,
#  "original_w"=>842,
#  "original_h"=>466,
#  "permalink"=>
#      "https://unity-game-dev-guild.slack.com/files/UE0G20RSP/FLA878SC8/____________________________2019-07-10_23.57.41.png",
#  "permalink_public"=>"https://slack-files.com/TE21DJBFY-FLA878SC8-98b7dca39d",
#  "is_starred"=>false,
#  "has_rich_preview"=>false}