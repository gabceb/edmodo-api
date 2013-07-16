Edmodo::API - Edmodo Ruby API client [![Build Status](https://secure.travis-ci.org/gabceb/edmodo-api.png)](http://travis-ci.org/gabceb/edmodo-api) [![Dependency Status](https://gemnasium.com/gabceb/edmodo-api.png)](https://gemnasium.com/gabceb/edmodo-api) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/gabceb/edmodo-api)

=======

A Ruby wrapper for the Edmodo REST API.

Install:
-------

	gem install edmodo-api

Usage:
-------

- Get an Edmodo Publisher Account at http://www.edmodo.com/publishers-requests.
- Initialize an edmodo-api object passing your api key.
- Start calling Edmodo API methods.

The gem uses sandbox mode by default. Use :mode => :production to use it on production environments

You can set the environment EDMODO_API_KEY and the gem will use it if you pass nil as the api_key when you create an instance

Examples:
----------
	client = Edmodo::API::Client.new(api_key , :mode => :production)
	client.launch_requests "5c18c7" 

Error Handling:
--------

The gem raises EdmodoApiError exceptions if a request doesn't return with status code 200 or if a key cannot be found on initialization

Support:
--------

This gem is not associated with Edmodo so please contact them for Edmodo specific questions

ZOMG Fork! Thank you!
---------

You're welcome to fork this project and send pull requests. Just remember to include specs.

TO DO
---------

- Find a way to pass a string as query params to a POST requests when using HTTParty to finish implementing the methods that are not supported yet
- Thinking about adding all the requests name into an array and overriding the Ruby method_missing method to DRY up the client code

Supported Edmodo API methods
---------

- launchRequests
- users
- groups
- groupsForUser
- members
- classmates
- teachers
- teachermates
- teacherConnections
- assignmentsComingDue
- gradesSetByAppForUser
- gradesSetByAppForGroup
- badgesAwarded
- eventsByApp
- parents
- children
- profiles
- registerBadge
- updateBadge
- awardBadge
- revokeBadge
- newGrade
- setGrade
- newEvent
- addToLibrary
- setNotification
- UserPost
- turnInAssignment
- NewEvent
- AddToLibrary

