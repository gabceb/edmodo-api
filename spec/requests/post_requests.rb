# -- POST REQUESTS ---

# userPost request uri
recipients = "[{'user_token':'b020c42d1'},{'user_token':'693d5c765'},{'group_id':379557}]"
attachments = "[{'type':'link','title':'A link','url':'http://www.edmodo.com'},{'type':'embed','title':'An embed with an optional thumbnail url','thumb_url':'http://images.edmodo.com/images/logos/edmodo_134x43.png'}]"

uri = URI.encode "#{Edmodo::API::Config.endpoints[:sandbox]}/userPost?api_key=#{@api_key}&user_token=b020c42d1&content=This%20is%20my%20test%20message&recipients=#{recipients}&attachments=#{attachments}"

FakeWeb.register_uri(:post, uri, :body => '{"status":"success"}')

# turnInAssignment request uri
attachments = "[{'type':'link','title':'A link','url':'http://www.edmodo.com'}]"

uri = URI.encode "#{Edmodo::API::Config.endpoints[:sandbox]}/turnInAssignment?api_key=#{@api_key}&user_token=b020c42d1&assignment_id=4738052&content=Here%20is%20my%20assignment%20submission&attachments=#{attachments}"

FakeWeb.register_uri(:post, uri, :body => '{"status":"success"}')

# RegisterBadge request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/registerBadge?api_key=#{@api_key}&badge_title=Good%20Job&description=You%20did%20a%20good%20job&image_url=http%3A%2F%2Fwww.edmodo.com%2Fbadge_image.png"

FakeWeb.register_uri(:post, uri, :body => '{"badge_id":6580}')

# UpdateBadge request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/updateBadge?api_key=#{@api_key}&badge_id=6580&badge_title=Very%20Good%20Job&description=You%20did%20a%20very%20good%20job&image_url=http%3A%2F%2Fwww.edmodo.com%2Fnew_badge_image.png"

FakeWeb.register_uri(:post, uri, :body => '{"status":"success"}')

# awardBadge request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/awardBadge?api_key=#{@api_key}&user_token=jd3i1c0pl&badge_id=6580"

FakeWeb.register_uri(:post, uri, :body => '{"success":1, "times_awarded":1}')

# revokeBadge request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/revokeBadge?api_key=#{@api_key}&user_token=jd3i1c0pl&badge_id=6580"

FakeWeb.register_uri(:post, uri, :body => '{"success":1, "times_awarded":0}')

# newGrade request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/newGrade?api_key=#{@api_key}&group_id=379557&title=Super%20Project&total=10"

FakeWeb.register_uri(:post, uri, :body => '{"grade_id":3694}')

# setGrade request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/setGrade?api_key=#{@api_key}&grade_id=3694&user_token=jd3i1c0pl&score=3"

FakeWeb.register_uri(:post, uri, :body => '{"user_token":"83a8e614d", "score":"3", "total":"10"}')

# newEvent request uri
receipients = URI.encode '[{"user_token":"b020c42d1"},{"group_id":379557}]'

uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/newEvent?api_key=#{@api_key}&user_token=b020c42d1&description=Pizza+party+tomorrow&start_date=2011-12-07&end_date=2011-12-07&recipients=#{receipients}"

FakeWeb.register_uri(:post, uri, :body => '{"event_id":621119}')

# addToLibrary request uri
resource = URI.encode '{"type":"link","title":"A link","url":"http://www.edmodo.com","thumb_url":"http://images.edmodo.com/images/logos/edmodo_134x43.png"}'

uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/addToLibrary?api_key=#{@api_key}&user_token=b020c42d1&publisher_owned=1&resource=#{resource}"

FakeWeb.register_uri(:post, uri, :body => '{"library_item_id":"456"}')

# setNotification request uri
uri = "#{Edmodo::API::Config.endpoints[:sandbox]}/setNotification?api_key=#{@api_key}&user_token=b020c42d1&notification_count=1"

FakeWeb.register_uri(:post, uri, :body => '{"updated_notification_count":"3"}')