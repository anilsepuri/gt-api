Feature: Groups
  As a system user I want to create additional groups for policy operations

  Background:
    * def sharedPath = 'classpath:gw/apicomponents/groups/'
    * configure headers = read('classpath:admin-headers.js')
    * def HashMap = Java.type('java.util.HashMap');
    * def response = new HashMap();

  @id=CreateGroup
  Scenario: Create group
    * def createGroupTemplate = sharedPath + 'createGroup.json'
    * def groupUrl = PC_URL + '/rest/testsupport/v1/groups'
    Given url groupUrl
    And request readWithArgs(createGroupTemplate, {'groupName': __arg.groupName, 'organization': __arg.organization, 'producerCodes': __arg.producerCodeId})
    When method POST
    Then status 201
    * response.put('name', response.data.attributes.name)
    * response.put('id', response.data.attributes.id)