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

	edmodo = Edmodo::API::Client.new(api_key)

	The gem uses sandbox mode by default. Use :mode => :production to use it on production environments
	You can also add your API key to an ENV variable with name EDMODO_API_KEY and pass nil to the constructor

- Start calling Edmodo API methods.

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
- Thinking about adding all the requests name into arrays and overriding the Ruby method_missing method to DRY up the client code
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

