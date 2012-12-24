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

# Groups request uri
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

# GroupsForUser request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/groupsForUser.json?api_key=#{@api_key}&user_token=b020c42d1"

FakeWeb.register_uri(:get, uri,
					 :body => '[
								   {
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

# Members request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/members.json?api_key=#{@api_key}&group_id=379557"

FakeWeb.register_uri(:get, uri,
					 :body => '[{
							      "user_type":"TEACHER",
							      "user_token":"b020c42d1",
							      "first_name":"Bob",
							      "last_name":"Smith",
							      "avatar_url":"http://edmodoimages.s3.amazonaws.com/default_avatar.png",
							      "thumb_url":"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png"
							   },
							   {
							      "user_type":"TEACHER",
							      "user_token":"693d5c765",
							      "first_name":"Tom",
							      "last_name":"Jefferson",
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

# Classmates request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/classmates.json?api_key=#{@api_key}&user_token=jd3i1c0pl"

FakeWeb.register_uri(:get, uri,
					 :body => '[{
							      "user_type":"STUDENT",
							      "user_token":"83a8e614d",
							      "first_name":"Allison",
							      "last_name":"Student",
							      "avatar_url":"http://edmodoimages.s3.amazonaws.com/default_avatar.png",
							      "thumb_url":"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png",
							      "shared_groups":[
							         379557,
							         379558
							      ]
							   },
							   {
							      "user_type":"STUDENT",
							      "user_token":"7968c39b7",
							      "first_name":"Mike",
							      "last_name":"Student",
							      "avatar_url":"http://edmodoimages.s3.amazonaws.com/default_avatar.png",
							      "thumb_url":"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png",
							      "shared_groups":[
							         379558
							      ]
							   }
							]')

# Teachers request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/teachers.json?api_key=#{@api_key}&user_token=jd3i1c0pl"

FakeWeb.register_uri(:get, uri,
					 :body => '[{
							      "user_type":"TEACHER",
							      "user_token":"b020c42d1",
							      "first_name":"Bob",
							      "last_name":"Smith",
							      "avatar_url":"http://edmodoimages.s3.amazonaws.com/default_avatar.png",
							      "thumb_url":"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png",
							      "title":"MR",
							      "shared_groups":[
							         379557
							      ]
							   },
							   {
							      "user_type":"TEACHER",
							      "user_token":"693d5c765",
							      "first_name":"Tom",
							      "last_name":"Jefferson",
							      "avatar_url":"http://edmodoimages.s3.amazonaws.com/default_avatar.png",
							      "thumb_url":"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png",
							      "title":"MR",
							      "shared_groups":[
							         379557,
							         379558
							      ]
							   }
							]')

# Teachermatess request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/teachermates.json?api_key=#{@api_key}&user_token=jd3i1c0pl"

FakeWeb.register_uri(:get, uri,
					 :body => '[{
							      "user_type":"TEACHER",
							      "user_token":"b020c42d1",
							      "first_name":"Bob",
							      "last_name":"Smith",
							      "avatar_url":"http://edmodoimages.s3.amazonaws.com/default_avatar.png",
							      "thumb_url":"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png",
							      "title":"MR",
							      "shared_groups":[
							         379557
							      ]
							   },
							   {
							      "user_type":"TEACHER",
							      "user_token":"693d5c765",
							      "first_name":"Tom",
							      "last_name":"Jefferson",
							      "avatar_url":"http://edmodoimages.s3.amazonaws.com/default_avatar.png",
							      "thumb_url":"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png",
							      "title":"MR",
							      "shared_groups":[
							         379557,
							         379558
							      ]
							   }
							]')

# Teacher Connections request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/teacherConnections.json?api_key=#{@api_key}&user_token=jd3i1c0pl"

FakeWeb.register_uri(:get, uri,
					 :body => '[{
							      "user_type":"TEACHER",
							      "user_token":"693d5c765",
							      "first_name":"Tom",
							      "last_name":"Jefferson",
							      "avatar_url":"http://edmodoimages.s3.amazonaws.com/default_avatar.png",
							      "thumb_url":"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png",
							      "title":"MR"
							   }
							]')

# AssignmentsComingDue request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/assignmentsComingDue.json?api_key=#{@api_key}&user_token=jd3i1c0pl"

FakeWeb.register_uri(:get, uri,
					 :body => '[{
							      "assignment_id":4738052,
							      "assignment_title":"Chapter 6 Homework",
							      "description":"Do lots of practice problems ",
							      "due_date":"2011-10-11",
							      "recipients":[
							         {
							            "user_token":"9ff85e278"
							         },
							         {
							            "group_id":379557
							         }
							      ],
							      "creator":{
							         "user_type":"TEACHER",
							         "title":"MR",
							         "first_name":"Bob",
							         "last_name":"Smith",
							         "avatar_url":"http://edmodoimages.s3.amazonaws.com/default_avatar.png",
							         "thumb_url":"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png",
							         "user_token":"b020c42d1"
							      }
							   }
							  ]')

# gradesSetByAppForUser request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/gradesSetByAppForUser.json?api_key=#{@api_key}&user_token=jd3i1c0pl"

FakeWeb.register_uri(:get, uri,
					 :body => '[{
							      "grade_id":3695,
							      "title":"Super Project",
							      "group_id":379557,
							      "score":"8",
							      "total":"10"
							   }
							]')

# gradesSetByAppForGroup request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/gradesSetByAppForGroup.json?api_key=#{@api_key}&group_id=379557"

FakeWeb.register_uri(:get, uri,
					 :body => '[{
							      "grade_id":3695,
							      "title":"Super Project",
							      "group_id":379557,
							      "average_score":7,
							      "total":"10",
							      "graded_count":15
							   }
							]')

# badgesAwarded request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/badgesAwarded.json?api_key=#{@api_key}&user_token=jd3i1c0pl"

FakeWeb.register_uri(:get, uri,
					 :body => '[{
							      "badge_id":6580,
							      "image_url":"http://edmodobadges.s3.amazonaws.com/1234.jpg",
							      "title":"Good Job",
							      "description":"You did a good job!",
							      "times_awarded":1
							   }
							]')

# eventsByApp request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/eventsByApp.json?api_key=#{@api_key}&user_token=b020c42d1"

FakeWeb.register_uri(:get, uri,
					 :body => '[{
							      "event_id":621119,
							      "description":"Pizza party tomorrow",
							      "start_date":"2011-12-07",
							      "end_date":"2011-12-07",
							      "recipients":[
							         {
							            "user_token":"b020c42d1"
							         },
							         {
							            "group_id":379557
							         }
							      ]
							   }
							]')

# parents request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/parents.json?api_key=#{@api_key}&user_token=jd3i1c0pl"

FakeWeb.register_uri(:get, uri,
					 :body => '[{
							      "user_type":"PARENT",
							      "user_token":"5e9c0e0f5",
							      "first_name":"Mary",
							      "last_name":"Smith",
							      "avatar_url":"http://edmodoimages.s3.amazonaws.com/default_avatar.png",
							      "thumb_url":"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png",
							      "relation":"MOM"
							   }
							]')

# children request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/children.json?api_key=#{@api_key}&user_token=5e9c0e0f5"

FakeWeb.register_uri(:get, uri,
					 :body => '[{
							      "user_type":"STUDENT",
							      "user_token":"jd3i1c0pl",
							      "first_name":"Jane",
							      "last_name":"Student",
							      "avatar_url":"http://edmodoimages.s3.amazonaws.com/default_avatar.png",
							      "thumb_url":"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png"
							   }
							]')

# RegisterBadge request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/registerBadge?api_key=#{@api_key}&badge_title=Good%20Job&description=You%20did%20a%20good%20job&image_url=http%3A%2F%2Fwww.edmodo.com%2Fbadge_image.png"

FakeWeb.register_uri(:post, uri, :body => '{"badge_id":6580}')

