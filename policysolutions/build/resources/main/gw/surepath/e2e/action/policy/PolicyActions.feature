Feature: Policy
  Action scenarios that operate on policies

  Background:
    * def username = __arg.scenarioArgs.username
    * def password = policyDataContainer.getPassword()
    * def sharedPath = 'classpath:gw/surepath/e2e/action/policy/'
    * def policyUrl = PC_URL + '/rest/policy/v1/'
    * configure headers = read('classpath:headers.js')

  @id=SearchPolicy
  Scenario: Search for a policy
    Given url policyUrl + 'search/policies'
    And request readWithArgs(sharedPath + 'searchPolicyByPolicyNumber.json', __arg.templateArgs)
    When method POST
    Then status 200
    * def listOfPolicies = karate.jsonPath(response, '$.data[*].attributes.policyId')
    * setStepVariable('listOfPolicies', listOfPolicies)

  @id=MatchPolicyByPolicyId
  Scenario: Match a policy by policy id
    * def requiredArguments = ['listOfPolicies', 'policyId']
    * match __arg.scenarioArgs.listOfPolicies contains __arg.scenarioArgs.policyId

  @id=StartPolicyChange
  Scenario: Start a policy change
    * def requiredArguments = ['policyId']
    * def policyChangeRequest = sharedPath + 'startPolicyChange.json'
    * def policyChangeUrl = policyUrl + 'policies/' + __arg.scenarioArgs.policyId + '/change'
    Given url policyChangeUrl
    And request readWithArgs(policyChangeRequest,  __arg.templateArgs)
    When method POST
    Then status 201
    And match response.data.attributes.jobType.code == 'PolicyChange'
    And setStepVariable('jobId', response.data.attributes.id)
