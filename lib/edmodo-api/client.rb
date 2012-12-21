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
        group_ids = Arary(group_ids)

        request :get, resource_uri("groups", @format), {:group_ids => group_ids.to_json}
      end

      # Returns the data for groups a user belongs to given a user token.
      # Params:
      #
      # => user_token: User token
      def groups_for_user

      end

      # Returns an array of user data for members of a group, specified by group id.
      # Params:
      #
      # => group_id: integer Group ID
      def members

      end

      # Returns an array of user data for all students that belong to at least one group with the student specified by user token.
      # Params:
      #
      # => user_token: User token of the student
      def classmates

      end

      # Returns an array of user data for all teachers for a student specified by user token.
      # Params:
      #
      # => user_token: User token of the student
      def teachers

      end

      # Returns an array of user data for all teachers that are connected to the teacher specified by user token.
      # Params:
      #
      # => user_token: User token of the teacher
      def teachermates

      end

      # Returns an array of assignments coming due (in the next 60 days) for the user specified by the token.
      # Params:
      #
      # => user_token: User token of the user
      def teacher_connections

      end

      # This call can be used in conjunction with turnInAssignment to allow a user to submit content from the app for a particular assignment in Edmodo.
      # Params:
      #
      # => user_token: User token of the user
      def assignments_coming_due

      end
      
      # Returns an array of grades set by the app for the given user token.
      # Params:
      #
      # => user_token: User token of the user to get grades for
      def grades_set_by_app_for_user

      end

      # Returns an array of grades set by the app for the given group.
      # Params:
      #
      # => group_id: The group to get grades for.
      def grades_set_by_app_for_group

      end

      # Returns an array of badges awarded by the app to the given user token.
      # Params:
      #
      # => user_token: The user_token to get badges awarded for.
      def badges_awarded

      end

      # Returns an array of events set on behalf of the specified user by the app.
      # Params:
      #
      # => user_token: The user token for the user from which events were set for.
      def events_by_app

      end

      # Returns an array of parent user data, given a specified student user token.
      # Params:
      #
      # => user_token: User token of the student
      def parents

      end

      # Returns an array of data for students, given a specified parent user token.
      # Params:
      #
      # => user_token: User token of the parent
      def children

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
      # => recipients: Array of objects specifying the recipients of the post. These can be either users (specified by a user_token) or groups (specified by a group_id).
      # => attachments (Optional): array of objects specifying links/embed codes to include in the post message.
      def user_post

      end

      # Submits a response to the specified assignment for the given user. The id's for assignments coming due can be retrieved using the assignments_coming_due.
      # Params:
      #
      # => user_token: The user token for the user turning in the assignment.
      # => assignment_id: Assignment Id for the assignment to turn in, obtained from the assignments_coming_due
      # => content: Text of the submission
      # => attachments (Optional): Array of objects specifying links/embed codes to include in the assignment submission
      def turn_in_assignment

      end

      # Registers a badge with Edmodo, returning a badge id that can be used to award a badge that will display on an Edmodo user's profile.
      # Params:
      #
      # => badge_title: limit 50 characters
      # => description: limit 140 characters
      # => image_url: url to badge image, should be 114x114 pixels. Accepted image types: jpg, gif, png
      def register_badge badge_title, description, image_url 
        request(:post, resource_uri("registerBadge"), {:badge_title => badge_title, :description => description, :image_url => image_url})
      end

      # Returns an array of user data for all teachers for a student specified by user token.
      # Params:
      #
      # => badge_id: the registered badge id
      # => badge_title: limit 50 characters
      # => description: limit 140 characters
      # => image_url (Optional): If you wish to replace the image of the badge, specify the url of the new badge image. Otherwise, to keep the old badge image, you do not need to specify this parameter.
      def update_badge badge_id, badge_title, description, image_url 

      end

      # Awards a badge to a given user.
      # Params:
      #
      # => badge_id: Badge ID of the badge being awarded
      # => user_token: User token of the user receiving the badge
      def award_badge

      end

      # Revokes a badge that has been awarded to a given user.
      # Params:
      #
      # => badge_id: Badge ID of the badge being revoked
      # => user_token: User token of the user who has been awarded the badge and whom it will be revoked from.
      def revoke_badge
      
      end

      # Add a new grade to the gradebook for a given group.
      # Params:
      #
      # => group_id: The group this grade will be created in
      # => title: The title for this grade
      # => The total grade possible for this grade
      def new_grade
      
      end

      # Set a score for a grade given a specific user token.
      # Params:
      #
      # => grade_id: User token of the student
      # => user_token: The user_token of the user to set the grade for
      # => score: The score to set for this grade
      def set_grade

      end

      # Set a new event on behalf of a user to specified recipients. Events will be seen on the calendar as well as notifications as the event approaches.
      # Params:
      #
      # => user_token: The user_token of the user to set the event on behalf for.
      # => description: The description of the event.
      # => start_date: The start date of the event (specified in the format YYYY-MM-DD).
      # => end_date: The end date of the event (specified in the format YYYY-MM-DD). If this is a single day event, the end date should simply be the same as the start date.
      # => recipients: array of objects specifying the recipients of the post. These can be either users (specified by a user_token) or groups (specified by a group_id).
      def new_event

      end

      # Adds a resource (url or embed code) to a user's Library
      # Params:
      #
      # => user_token: The user_token of the user that will have the resource added to her/his library.
      # => publisher_owned:  If you want the resources's author to be the publisher account associated with the app, set this parameter. Set to '1' if you want the resource to be publisher owned
      # => resource: Object specifying the link or embed code to add to the user's library.
      def add_to_library

      end

      # Sets a specified count of app notifications for the user.
      # Params:
      #
      # => user_token: The user_token of the user that will have the resource added to her/his library.
      # => notification_count: The number to add to the user's notification count for the app
      def set_notification
      end

      private

      def defaults
        {
          :mode => :sandbox,
          :format => "json"
        }
      end

      def raise_init_errors
        raise EdmodoApiError.new("Edmodo API Error: Api key was not set") if @api_key.empty?

        raise EdmodoApiError.new("EdmodoAPI Error: Mode not available on Edmodo API") unless Edmodo::API::Config.endpoints.keys.include? @mode
      end

      # Creates a uri using for a specific resource based on the mode
      def resource_uri resource, format = nil

        format = ".#{format}" if format

        "#{@endpoint}/#{resource}#{format}?api_key=#{api_key}"
      end

    end
  end
end