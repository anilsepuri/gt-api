Feature: Producer Codes
  As a system user I want to create additional producer codes for policy operations

  Background:
    * def sharedPath = 'classpath:gw/apicomponents/producercodes/'
    * configure headers = read('classpath:admin-headers.js')
    * def HashMap = Java.type('java.util.HashMap');
    * def response = new HashMap();

  @id=CreateProducerCode
  Scenario: Create producer code
    * def createProducerTemplate = sharedPath + 'createProducerCode.json'
    * def producerCodeUrl = PC_URL + '/rest/testsupport/v1/producer-codes'
    Given url producerCodeUrl
    And request readWithArgs(createProducerTemplate, {'code': __arg.code,'organization': __arg.organization,'roles':__arg.roles})
    When method POST
    Then status 201
    * response.put('code', response.data.attributes.code)
    * response.put('id', response.data.attributes.id)
    * response.put('organization', response.data.attributes.organization)