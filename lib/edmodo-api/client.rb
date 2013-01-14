# -*- encoding: utf-8 -*-

require 'httparty'
require 'json'

EdmodoApiError = Class.new(StandardError)

module Edmodo
  module API
    class Client

      include Edmodo::API::Request
      include HTTParty

      attr_reader :api_key
      attr_reader :mode
    
      # Initializes a new instance of the Edmodo API client
      # Options:
      #
      # => mode: Sets the mode to production or sandbox
      #
      def initialize(api_key, options = {})

        options = defaults.merge(options)

        @format = options[:format]
        @mode = options[:mode]
        @api_key = (api_key || ENV['EDMODO_API_KEY'] || "").strip

        raise_init_errors

        # Adding the api key as a default parameter to all requests
        self.class.default_params :api_key => @api_key

        @endpoint = Edmodo::API::Config.endpoints[@mode]

      end

      # -- GET Requests --

      # Returns user data for the user that requested the application launch.
      # Params:
      #
      # => launch_key: launch_key that was passed to the application's server.
      def launch_requests launch_key
        request :get, resource_uri("launchRequests", @format), {:launch_key => launch_key}
      end

      # Returns user data for a given user token or array of user tokens.
      # Params:
      #
      # => user_tokens: array of user tokens
      def users user_tokens
        user_tokens = Array(user_tokens)

        request :get, resource_uri("users", @format), {:user_tokens => user_tokens.to_json}
      end

      # Returns group data for a given array of group ids.
      # Params:
      #
      # => group_ids: array of group ids
      def groups group_ids
        group_ids = Array(group_ids)

        request :get, resource_uri("groups", @format), {:group_ids => group_ids.to_json}
      end

      # Returns the data for groups a user belongs to given a user token.
      # Params:
      #
      # => user_token: User token
      def groups_for_user user_token
        request :get, resource_uri("groupsForUser", @format), {:user_token => user_token}
      end

      # Returns an array of user data for members of a group, specified by group id.
      # Params:
      #
      # => group_id: integer Group ID
      def members group_id
        request :get, resource_uri("members", @format), {:group_id => group_id}
      end

      # Returns an array of user data for all students that belong to at least one group with the student specified by user token.
      # Params:
      #
      # => user_token: User token of the student
      def classmates user_token
        request :get, resource_uri("classmates", @format), {:user_token => user_token}
      end

      # Returns an array of user data for all teachers for a student specified by user token.
      # Params:
      #
      # => user_token: User token of the student
      def teachers user_token
        request :get, resource_uri("teachers", @format), {:user_token => user_token}
      end

      # Returns an array of user data for all teachers that are connected to the teacher specified by user token.
      # Params:
      #
      # => user_token: User token of the teacher
      def teachermates user_token
        request :get, resource_uri("teachermates", @format), {:user_token => user_token}
      end

      # Returns an array of assignments coming due (in the next 60 days) for the user specified by the token.
      # Params:
      #
      # => user_token: User token of the user
      def teacher_connections user_token
        request :get, resource_uri("teacherConnections", @format), {:user_token => user_token}
      end

      # This call can be used in conjunction with turnInAssignment to allow a user to submit content from the app for a particular assignment in Edmodo.
      # Params:
      #
      # => user_token: User token of the user
      def assignments_coming_due user_token
        request :get, resource_uri("assignmentsComingDue", @format), {:user_token => user_token}
      end
      
      # Returns an array of grades set by the app for the given user token.
      # Params:
      #
      # => user_token: User token of the user to get grades for
      def grades_set_by_app_for_user user_token
        request :get, resource_uri("gradesSetByAppForUser", @format), {:user_token => user_token}
      end

      # Returns an array of grades set by the app for the given group.
      # Params:
      #
      # => group_id: The group to get grades for.
      def grades_set_by_app_for_group group_id
        request :get, resource_uri("gradesSetByAppForGroup", @format), {:group_id => group_id}
      end

      # Returns an array of badges awarded by the app to the given user token.
      # Params:
      #
      # => user_token: The user_token to get badges awarded for.
      def badges_awarded user_token
        request :get, resource_uri("badgesAwarded", @format), {:user_token => user_token}
      end

      # Returns an array of events set on behalf of the specified user by the app.
      # Params:
      #
      # => user_token: The user token for the user from which events were set for.
      def events_by_app user_token
        request :get, resource_uri("eventsByApp", @format), {:user_token => user_token}
      end

      # Returns an array of parent user data, given a specified student user token.
      # Params:
      #
      # => user_token: User token of the student
      def parents user_token
        request :get, resource_uri("parents", @format), {:user_token => user_token}
      end

      # Returns an array of data for students, given a specified parent user token.
      # Params:
      #
      # => user_token: User token of the parent
      def children user_token
        request :get, resource_uri("children", @format), {:user_token => user_token}
      end

      # Fetches user profile information.
      # Currently, this is only for teacher users to obtain their school information (if a school is set for the teacher).
      # Params:
      #
      # => user_token: Array of teacher user tokens.
      def profiles user_tokens

        user_tokens = Array(user_tokens)

        request :get, resource_uri("profiles", "json"), {:user_tokens => user_tokens.to_json}
      end

      # -- POST Requests --

      # Send a post to the recipient group(s) or user(s) from the user token specified.
      # Params:
      #
      # => user_token: The user token for the user sending the post.
      # => content: The text of the message.
      # => user_recipients: array of user_tokens that will receive the event.
      # => group_recipients: array of group_ids that will receive the event.
      # => attachments (Optional): array of objects specifying links/embed codes to include in the post message.
      def user_post user_token, content, user_recipients, group_recipients, attachments = nil

        recipients = generate_user_groups_array user_recipients, group_recipients

        request(:post, resource_uri("userPost"), {:user_token => user_token, :content => content, :recipients => recipients, :attachments => attachments}.delete_if{ |k,v| v.nil? })
      end

      # Submits a response to the specified assignment for the given user. The id's for assignments coming due can be retrieved using the assignments_coming_due.
      # Params:
      #
      # => user_token: The user token for the user turning in the assignment.
      # => assignment_id: Assignment Id for the assignment to turn in, obtained from the assignments_coming_due
      # => content: Text of the submission
      # => attachments (Optional): Array of objects specifying links/embed codes to include in the assignment submission
      def turn_in_assignment user_token, assignment_id, content, attachments = nil
        request(:post, resource_uri("turnInAssignment"), {:user_token => user_token, :assignment_id => assignment_id, :content => content, :attachments => attachments}.delete_if{ |k,v| v.nil? } )
      end

      # Registers a badge with Edmodo, returning a badge id that can be used to award a badge that will display on an Edmodo user's profile.
      # Params:
      #
      # => badge_title: limit 50 characters
      # => description: limit 140 characters
      # => image_url: url to badge image, should be 114x114 pixels. Accepted image types: jpg, gif, png
      def register_badge badge_title, description, image_url 
        request(:post, resource_uri("registerBadge"), {:badge_title => badge_title, :description => description, :image_url => image_url}.delete_if { |k,v| v.nil? })
      end

      # Returns an array of user data for all teachers for a student specified by user token.
      # Params:
      #
      # => badge_id: the registered badge id
      # => badge_title: limit 50 characters
      # => description: limit 140 characters
      # => image_url (Optional): If you wish to replace the image of the badge, specify the url of the new badge image. Otherwise, to keep the old badge image, you do not need to specify this parameter.
      def update_badge badge_id, badge_title, description, image_url = nil
        request(:post, resource_uri("updateBadge"), {:badge_id => badge_id, :badge_title => badge_title, :description => description, :image_url => image_url}. delete_if{ |k,v| v.nil? })
      end

      # Awards a badge to a given user.
      # Params:
      #
      # => badge_id: Badge ID of the badge being awarded
      # => user_token: User token of the user receiving the badge
      def award_badge user_token, badge_id
        request(:post, resource_uri("awardBadge"), {:user_token => user_token, :badge_id => badge_id})
      end

      # Revokes a badge that has been awarded to a given user.
      # Params:
      #
      # => badge_id: Badge ID of the badge being revoked
      # => user_token: User token of the user who has been awarded the badge and whom it will be revoked from.
      def revoke_badge user_token, badge_id
        request(:post, resource_uri("revokeBadge"), {:user_token => user_token, :badge_id => badge_id})
      end

      # Add a new grade to the gradebook for a given group.
      # Params:
      #
      # => group_id: The group this grade will be created in
      # => title: The title for this grade
      # => total: The total grade possible for this grade
      def new_grade group_id, title, total
        request(:post, resource_uri("newGrade"), {:group_id => group_id, :title => title, :total => total})
      end

      # Set a score for a grade given a specific user token.
      # Params:
      #
      # => grade_id: The grade the score is being set upon
      # => user_token: The user_token of the user to set the grade for
      # => score: The score to set for this grade
      def set_grade user_token, grade_id, score
        request(:post, resource_uri("setGrade"), {:user_token => user_token, :grade_id => grade_id, :score => score})
      end

      # Set a new event on behalf of a user to specified recipients. Events will be seen on the calendar as well as notifications as the event approaches.
      # Params:
      #
      # => user_token: The user_token of the user to set the event on behalf for.
      # => description: The description of the event.
      # => start_date: The start date of the event.
      # => end_date: The end date of the event. If this is a single day event, the end date should simply be the same as the start date.
      # => user_recipients: array of user_tokens that will receive the event.
      # => groups_recipients: array of group_ids that will receive the event.
      def new_event user_token, description, start_date, end_date, user_recipients, group_recipients

        raise EdmodoApiError.new("Invalid object type for start or end date") unless start_date.is_a?(Date) && end_date.is_a?(Date)

        recipients = generate_user_groups_array user_recipients, group_recipients

        request(:post, resource_uri("newEvent"), {:user_token => user_token, :description => description, :start_date => start_date.to_s, :end_date => end_date.to_s, :recipients => recipients})
      end

      # Adds a resource (url or embed code) to a user's Library
      # Params:
      #
      # => user_token: The user_token of the user that will have the resource added to her/his library.
      # => publisher_owned:  If you want the resources's author to be the publisher account associated with the app, set this parameter. Set to '1' if you want the resource to be publisher owned
      # => resource: Object specifying the link or embed code to add to the user's library.
      def add_to_library user_token, publisher_owned, resource
        publisher_owned_int = publisher_owned ? 1 : 0

        request(:post, resource_uri("addToLibrary"), {:user_token => user_token, :publisher_owned => publisher_owned_int, :resource => resource })
      end

      # Sets a specified count of app notifications for the user.
      # Params:
      #
      # => user_token: The user_token of the user that will have the resource added to her/his library.
      # => notification_count: The number to add to the user's notification count for the app
      def set_notification user_token, notification_count
        request(:post, resource_uri("setNotification"), {:user_token => user_token, :notification_count => notification_count})
      end

      private

      def defaults
        {
          :mode => :sandbox,
          :format => "json"
        }
      end

      # Generates an array of hashes from an array of user ids and group ids
      # Params:
      #
      # => user: array of user_tokens.
      # => groups: array of group_ids.
      def generate_user_groups_array users, groups
        users = Array(users)

        user_array = users.map{|token| {:user_token => token}} 

        groups = Array(groups)

        group_array = groups.map{|id| {:group_id => id}}

        (user_array | group_array).flatten
      end

      # Checks for all required variables to be set when an instance is created and throws errors if they haven't
      def raise_init_errors
        raise EdmodoApiError.new("Edmodo API Error: Api key was not set") if @api_key.empty?

        raise EdmodoApiError.new("EdmodoAPI Error: Mode not available on Edmodo API") unless Edmodo::API::Config.endpoints.keys.include? @mode
      end

      # Creates a uri using for a specific resource based on the mode and format
      def resource_uri resource, format = nil

        format = ".#{format}" if format

        "#{@endpoint}/#{resource}#{format}"
      end

    end
  end
end