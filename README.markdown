Edmodo::API - Edmodo Ruby API client
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
	client.launchRequests "5c18c7" 

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

- Finish implementation of all the methods
- Thinking about adding all the requests name into an array and overriding the Ruby method_missing method to DRY up the client code
- Adding tests for every method

Edmodo methods that will be supported
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
- userPost
- turnInAssignment
- registerBadge
- updateBadge
- awardBadge
- revokeBadge
- newGrade
- setGrade
- newEvent
- addToLibrary
- setNotification

