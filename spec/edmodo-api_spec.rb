# -*- encoding: utf-8 -*-

require File.join(File.dirname(__FILE__), "/spec_helper")

describe Edmodo::API::Client do
  
  before do
    @api_key = "1234567890abcdefghijklmn"
    @invalid_api_key = "invalid_key"
  end

  describe 'Initialization' do

    it 'should accept an api key in the constructor' do
      Edmodo::API::Client.new(@api_key).api_key.should == @api_key
    end

    it "should be initialized with sandbox mode by default" do
      Edmodo::API::Client.new(@api_key).mode.should == :sandbox
    end

    it "should be initialized with production mode if passed to the initialize method" do
      Edmodo::API::Client.new(@api_key, mode: :production).mode.should == :production
    end

    it "should be initialized with sandbox mode if passed to the initialize method" do
      Edmodo::API::Client.new(@api_key, mode: :sandbox).mode.should == :sandbox
    end

    it "should throw an exception if an unkown mode is passed to the initialize method" do
      expect { Edmodo::API::Client.new(@api_key, mode: :mymode) }.to raise_error(EdmodoApiError)
    end

    it "should throw an exception if no api key is passed to the initialize method" do
      expect { Edmodo::API::Client.new(nil) }.to raise_error(EdmodoApiError)
    end

  end

  describe 'Config' do
    it 'should have a version on the config' do
      Edmodo::API::Config.version.should_not be_empty
    end

    it 'should have a production endopoint' do
      Edmodo::API::Config.endpoints[:production].should_not be_empty
    end

    it 'should have a sandbox endpoint' do
      Edmodo::API::Config.endpoints[:sandbox].should_not be_empty
    end
  end

  describe 'Invalid Requests' do
    it 'should throw an error when a request doesnt return a 200 status code' do
      client = Edmodo::API::Client.new(@invalid_api_key)
      
      expect { client.launch_requests("5c18c7") }.to raise_error(EdmodoApiError)
    end
  end

  describe 'GET Requests in Production' do
    it 'should get the correct hash back from the launchRequest request when environment is production' do
      client = Edmodo::API::Client.new(@api_key, :mode => :production)

      response = client.launch_requests("5c18c7")

      response.should == {"user_type"=>"TEACHER", "user_token"=>"b020c42d1", "first_name"=>"Bob", "last_name"=>"Smith", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png", "groups"=>[{"group_id"=>379557, "is_owner"=>1}, {"group_id"=>379562, "is_owner"=>1}]}
    end
  end

  describe 'GET Requests' do
    before do
      @client = Edmodo::API::Client.new(@api_key)
    end

    it 'should get the correct hash back from the launchRequest request' do
      
      response = @client.launch_requests("5c18c7")

      response.should == {"user_type"=>"TEACHER", "user_token"=>"b020c42d1", "first_name"=>"Bob", "last_name"=>"Smith", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png", "groups"=>[{"group_id"=>379557, "is_owner"=>1}, {"group_id"=>379562, "is_owner"=>1}]}
    end

    it 'should get the correct hash back from the users request' do
      
      users_ids = ["b020c42d1","jd3i1c0pl"]
      response = @client.users(users_ids)

      response.should == [{"user_type"=>"TEACHER", "user_token"=>"b020c42d1", "first_name"=>"Bob", "last_name"=>"Smith", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png"}, {"user_type"=>"STUDENT", "user_token"=>"jd3i1c0pl", "first_name"=>"Jane", "last_name"=>"Student", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png"}]
    end

    it 'should get the correct hash back from the groups request' do
      
      groups_id = [379557,379562]
      response = @client.groups(groups_id)

      response.should == [{"group_id"=>379557, "title"=>"Algebra", "member_count"=>20, "owners"=>["b020c42d1", "693d5c765"], "start_level"=>"9th", "end_level"=>"9th"}, {"group_id"=>379562, "title"=>"Geometry", "member_count"=>28, "owners"=>["b020c42d1"], "start_level"=>"3rd", "end_level"=>"3rd"}]
    end

    it 'should get the correct hash back from the groupsForUser request' do
      
      response = @client.groups_for_user("b020c42d1")

      response.should == [{"group_id"=>379557, "title"=>"Algebra", "member_count"=>20, "owners"=>["b020c42d1", "693d5c765"], "start_level"=>"9th", "end_level"=>"9th"}, {"group_id"=>379562, "title"=>"Geometry", "member_count"=>28, "owners"=>["b020c42d1"], "start_level"=>"3rd", "end_level"=>"3rd"}]
    end

    it 'should get the correct hash back from the members request' do
      
      response = @client.members(379557)

      response.should == [{"user_type"=>"TEACHER", "user_token"=>"b020c42d1", "first_name"=>"Bob", "last_name"=>"Smith", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png"}, {"user_type"=>"TEACHER", "user_token"=>"693d5c765", "first_name"=>"Tom", "last_name"=>"Jefferson", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png"}, {"user_type"=>"STUDENT", "user_token"=>"jd3i1c0pl", "first_name"=>"Jane", "last_name"=>"Student", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png"}]
    end

    it 'should get the correct hash back from the classmates request' do
      
      response = @client.classmates("jd3i1c0pl")

      response.should == [{"user_type"=>"STUDENT", "user_token"=>"83a8e614d", "first_name"=>"Allison", "last_name"=>"Student", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png", "shared_groups"=>[379557, 379558]}, {"user_type"=>"STUDENT", "user_token"=>"7968c39b7", "first_name"=>"Mike", "last_name"=>"Student", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png", "shared_groups"=>[379558]}]
    end

    it 'should get the correct hash back from the teachers request' do
      
      response = @client.teachers("jd3i1c0pl")

      response.should == [{"user_type"=>"TEACHER", "user_token"=>"b020c42d1", "first_name"=>"Bob", "last_name"=>"Smith", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png", "title"=>"MR", "shared_groups"=>[379557]}, {"user_type"=>"TEACHER", "user_token"=>"693d5c765", "first_name"=>"Tom", "last_name"=>"Jefferson", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png", "title"=>"MR", "shared_groups"=>[379557, 379558]}]
    end

    it 'should get the correct hash back from the teachermates request' do
      
      response = @client.teachermates("jd3i1c0pl")

      response.should == [{"user_type"=>"TEACHER", "user_token"=>"b020c42d1", "first_name"=>"Bob", "last_name"=>"Smith", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png", "title"=>"MR", "shared_groups"=>[379557]}, {"user_type"=>"TEACHER", "user_token"=>"693d5c765", "first_name"=>"Tom", "last_name"=>"Jefferson", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png", "title"=>"MR", "shared_groups"=>[379557, 379558]}]
    end

    it 'should get the correct hash back from the teacherConnections request' do
      
      response = @client.teacher_connections("jd3i1c0pl")

      response.should == [{"user_type"=>"TEACHER", "user_token"=>"693d5c765", "first_name"=>"Tom", "last_name"=>"Jefferson", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png", "title"=>"MR"}]
    end

    it 'should get the correct hash back from the assignmentsComingDue request' do
      
      response = @client.assignments_coming_due("jd3i1c0pl")

      response.should == [{"assignment_id"=>4738052, "assignment_title"=>"Chapter 6 Homework", "description"=>"Do lots of practice problems ", "due_date"=>"2011-10-11", "recipients"=>[{"user_token"=>"9ff85e278"}, {"group_id"=>379557}], "creator"=>{"user_type"=>"TEACHER", "title"=>"MR", "first_name"=>"Bob", "last_name"=>"Smith", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png", "user_token"=>"b020c42d1"}}]
    end

    it 'should get the correct hash back from the gradesSetByAppForUser request' do
      
      response = @client.grades_set_by_app_for_user("jd3i1c0pl")

      response.should == [{"grade_id"=>3695, "title"=>"Super Project", "group_id"=>379557, "score"=>"8", "total"=>"10"}]
    end

    it 'should get the correct hash back from the gradesSetByAppForGroup request' do
      
      response = @client.grades_set_by_app_for_group(379557)

      response.should == [{"grade_id"=>3695, "title"=>"Super Project", "group_id"=>379557, "average_score"=>7, "total"=>"10", "graded_count"=>15}]
    end

    it 'should get the correct hash back from the badgesAwarded request' do
      
      response = @client.badges_awarded("jd3i1c0pl")

      response.should == [{"badge_id"=>6580, "image_url"=>"http://edmodobadges.s3.amazonaws.com/1234.jpg", "title"=>"Good Job", "description"=>"You did a good job!", "times_awarded"=>1}]
    end

    it 'should get the correct hash back from the eventsByApp request' do
      
      response = @client.events_by_app("b020c42d1")

      response.should == [{"event_id"=>621119, "description"=>"Pizza party tomorrow", "start_date"=>"2011-12-07", "end_date"=>"2011-12-07", "recipients"=>[{"user_token"=>"b020c42d1"}, {"group_id"=>379557}]}]
    end

    it 'should get the correct hash back from the parents request' do
      
      response = @client.parents("jd3i1c0pl")

      response.should == [{"user_type"=>"PARENT", "user_token"=>"5e9c0e0f5", "first_name"=>"Mary", "last_name"=>"Smith", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png", "relation"=>"MOM"}]
    end

    it 'should get the correct hash back from the children request' do
      
      response = @client.children("5e9c0e0f5")

      response.should == [{"user_type"=>"STUDENT", "user_token"=>"jd3i1c0pl", "first_name"=>"Jane", "last_name"=>"Student", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png"}]
    end

    it 'should get the correct hash back from the profiles request' do
      
      response = @client.profiles("b020c42d1")

      response.should == [{"user_token"=>"b020c42d1", "school"=>{"edmodo_school_id"=>123456, "nces_school_id"=>"ABC987654", "name"=>"Edmodo High", "address"=>"60 E. 3rd Avenue, #390", "city"=>"San Mateo", "state"=>"CA", "zip_code"=>"94401", "country_code"=>"US"}}]
    end

  end

  describe 'POST Requests' do
    before do
      @client = Edmodo::API::Client.new(@api_key)
    end

    it 'should get the correct response back from the userPost request' do
      users = ["b020c42d1", "693d5c765"]

      groups = 379557

      response = @client.user_post("b020c42d1", "This is my test message", users, groups, [{:type => "link", :title => "A link", :url => "http://www.edmodo.com"}, {:type => "embed", :title => "An embed with an optional thumbnail url", :thumb_url => "http://images.edmodo.com/images/logos/edmodo_134x43.png"}])

      response.should == {"status" => "success"}
    end

    it 'should get the correct response back from the turnInAssignment request' do
      
      response = @client.turn_in_assignment("83a8e614d", 4738052, "Here is my assignment submission", [{:type => "link", :title => "A link", :url => "http://www.edmodo.com"}])

      response.should == {"status" => "success"}
    end

    it 'should get the correct hash response from the registerBadge request' do
      response = @client.register_badge("Good Job", "You did a good job", "http://www.edmodo.com/badge_image.png")
      
      response.should == {"badge_id" => 6580}
    end

    it 'should get the correct hash response from the updateBadge request' do
      response = @client.update_badge(6580, "Very Good Job", "You did a very good job", "http://www.edmodo.com/new_badge_image.png")
      
      response.should == {"status" => "success"}
    end

    it 'should get the correct hash response from the awardBadge request' do
      response = @client.award_badge("jd3i1c0pl", 6580)
      
      response.should == {"success"=>1, "times_awarded"=>1}
    end

    it 'should get the correct hash response from the revokeBadge request' do
      response = @client.revoke_badge("jd3i1c0pl", 6580)
      
      response.should == {"success"=>1, "times_awarded"=>0}
    end

    it 'should get the correct hash response from the newGrade request' do
      response = @client.new_grade(379557, "Super Project", 10)
      
      response.should == {"grade_id"=>3694}
    end

    it 'should get the correct hash response from the setGrade request' do
      response = @client.set_grade("jd3i1c0pl", 3694, 3)
      
      response.should == {"user_token"=>"83a8e614d", "score"=>"3", "total" => "10"}
    end

    it 'should get the correct hash response from the newEvent request' do

      users = "b020c42d1"

      groups = 379557

      response = @client.new_event("b020c42d1", "Pizza party tomorrow", Date.today, Date.today, users, groups)
      
      response.should == {"event_id" => 621119}
    end

    it 'should get the correct hash response from the addToLibrary request' do

      resource = {:type => "link", :title => "A link", :url => "http://www.edmodo.com", :thumb_url => "http://images.edmodo.com/images/logos/edmodo_134x43.png" }
      response = @client.add_to_library("b020c42d1", true, resource)
      
      response.should == {"library_item_id" => "456"}
    end

    it 'should get the correct hash response from the setNotification request' do

      response = @client.set_notification("b020c42d1", 1)
      
      response.should == {"updated_notification_count" => "3"}
    end

  end

end