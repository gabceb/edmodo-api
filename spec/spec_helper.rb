# -*- encoding: utf-8 -*-

$: << File.join(File.dirname(__FILE__), "/../lib")
require 'edmodo-api'
require 'fakeweb'

@api_key = "1234567890abcdefghijklmn"
@invalid_api_key = "invalid_key"

FakeWeb.allow_net_connect = false

# Unauthorized request
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/launchRequests.json?api_key=#{@invalid_api_key}&launch_key=5c18c7"

FakeWeb.register_uri(:get, uri, :body => '{"error":{"code":3000,"message":"Unauthorized API request"}}', :status => ["401", "Authorization Required"])

# launchRequest request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/launchRequests.json?api_key=#{@api_key}&launch_key=5c18c7"

FakeWeb.register_uri(:get, uri,
					 :body => '	{
								    "user_type":"TEACHER",
								    "user_token":"b020c42d1",
								    "first_name":"Bob",
								    "last_name":"Smith",
								    "avatar_url":"http://edmodoimages.s3.amazonaws.com/default_avatar.png",
								    "thumb_url":"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png",
								    "groups":[
								        {
								            "group_id":379557,
								            "is_owner":1
								        },
								        {
								            "group_id":379562,
								            "is_owner":1
								        }
								    ]
								}')

# Users request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/users.json?api_key=#{@api_key}&user_tokens=%5B%22b020c42d1%22%2C%22jd3i1c0pl%22%5D"

FakeWeb.register_uri(:get, uri,
					 :body => '	[
								   {
								      "user_type":"TEACHER",
								      "user_token":"b020c42d1",
								      "first_name":"Bob",
								      "last_name":"Smith",
								      "avatar_url":"http://edmodoimages.s3.amazonaws.com/default_avatar.png",
								      "thumb_url":"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png"
								   },
								   {
								      "user_type":"STUDENT",
								      "user_token":"jd3i1c0pl",
								      "first_name":"Jane",
								      "last_name":"Student",
								      "avatar_url":"http://edmodoimages.s3.amazonaws.com/default_avatar.png",
								      "thumb_url":"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png"
								   }
								]')

# Profiles request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/profiles.json?api_key=#{@api_key}&user_tokens=%5B%22b020c42d1%22%5D"

FakeWeb.register_uri(:get, uri,
					 :body => '[
								   {
								      "user_token":"b020c42d1",
								      "school":{
								         "edmodo_school_id":123456,
								         "nces_school_id":"ABC987654",
								         "name":"Edmodo High",
								         "address":"60 E. 3rd Avenue, #390",
								         "city":"San Mateo",
								         "state":"CA",
								         "zip_code":"94401",
								         "country_code":"US"
								      }
								   }
								]')

uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/groups.json?api_key=#{@api_key}&group_ids=%5B379557%2C379562%5D"

FakeWeb.register_uri(:get, uri,
					 :body => '[{
							      "group_id":379557,
							      "title":"Algebra",
							      "member_count":20,
							      "owners":[
							         "b020c42d1",
							         "693d5c765"
							      ],
							      "start_level":"9th",
							      "end_level":"9th"
							   },
							   {
							      "group_id":379562,
							      "title":"Geometry",
							      "member_count":28,
							      "owners":[
							         "b020c42d1"
							      ],
							      "start_level":"3rd",
							      "end_level":"3rd"
							   }
							]')

# RegisterBadge request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/registerBadge?api_key=#{@api_key}&badge_title=Good%20Job&description=You%20did%20a%20good%20job&image_url=http%3A%2F%2Fwww.edmodo.com%2Fbadge_image.png"

FakeWeb.register_uri(:post, uri, :body => '{"badge_id":6580}')

