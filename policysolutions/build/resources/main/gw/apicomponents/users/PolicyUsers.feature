Feature: Users
  As a system user I want to create additional users for policy operations

  Background:
    * def sharedPath = 'classpath:gw/apicomponents/users/'
    * configure headers = read('classpath:admin-headers.js')
    * def HashMap = Java.type('java.util.HashMap');
    * def response = new HashMap();

  @id=CreateUser
  Scenario: Create user
    * def createUserTemplate = sharedPath + 'createPolicyUser.json'
    * def userUrl = PC_URL + '/rest/testsupport/v1/users'
    Given url userUrl
    And request readWithArgs(createUserTemplate, {'userName': __arg.userName, 'roles': __arg.roles, 'groups': __arg.groups, 'useProducerCodeSecurity': __arg.useProducerCodeSecurity, 'uWAuthorityProfiles': __arg.uWAuthorityProfiles})
    When method POST
    Then status 201
    * response.put('userName', response.data.attributes.username)
    * response.put('groupId', response.data.attributes.groupId)
    * response.put('userId', response.data.attributes.id)