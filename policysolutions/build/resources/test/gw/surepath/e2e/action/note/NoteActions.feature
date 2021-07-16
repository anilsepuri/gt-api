Feature: Note
  Action scenarios that operate on Notes

  Background:
    * def username = __arg.scenarioArgs.username
    * def password = policyDataContainer.getPassword()
    * configure headers = read('classpath:headers.js')
    * def accountsUrl = PC_URL + '/rest/account/v1/accounts'
    * def policiesUrl = PC_URL + '/rest/policy/v1/policies'
    * def sharedPath = 'classpath:gw/surepath/e2e/action/note/'

  @id=AddNoteToAccount
  Scenario: Add note to account
    * def requiredArguments = ['accountId']
    Given url accountsUrl + '/' + __arg.scenarioArgs.accountId + '/notes'
    And request readWithArgs(sharedPath + 'addNote.json', __arg.templateArgs)
    When method POST
    Then status 201
    * match response.data.attributes.topic.code == __arg.templateArgs.topic
    * match response.data.attributes.body == __arg.templateArgs.body
    * setStepVariable('noteId', response.data.attributes.id)

  @id=AddNoteToPolicy
  Scenario: Add note to policy
    * def requiredArguments = ['policyId']
    Given url policiesUrl + '/' + __arg.scenarioArgs.policyId + '/notes'
    And request readWithArgs(sharedPath + 'addNote.json', __arg.templateArgs)
    When method POST
    Then status 201
    * match response.data.attributes.topic.code == __arg.templateArgs.topic
    * match response.data.attributes.body == __arg.templateArgs.body
    * setStepVariable('noteId', response.data.attributes.id)

  @id=GetAccountNotes
  Scenario: Get account notes
    * def requiredArguments = ['accountId', 'noteId']
    Given url accountsUrl + '/' + __arg.scenarioArgs.accountId + '/notes'
    When method GET
    Then status 200
    And match response.data[*].attributes.id contains __arg.scenarioArgs.noteId

  @id=GetPolicyNotes
  Scenario: Get policy notes
    * def requiredArguments = ['policyId', 'noteId']
    Given url policiesUrl + '/' + __arg.scenarioArgs.policyId + '/notes'
    When method GET
    Then status 200
    And match response.data[*].attributes.id contains __arg.scenarioArgs.noteId