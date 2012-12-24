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
      api_key = "1234567890abcdefghijklmn"
      @client = Edmodo::API::Client.new(api_key)
    end

    it 'should get the correct hash response from the registerBadge request' do
      response = @client.register_badge("Good Job", "You did a good job", "http://www.edmodo.com/badge_image.png")
      
      response.should == {"badge_id" => 6580}
    end

  end

end