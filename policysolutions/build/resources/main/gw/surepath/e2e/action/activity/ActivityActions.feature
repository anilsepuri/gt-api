Feature: Activity
  Action scenarios that operate on Activities

  Background:
    * def username = __arg.scenarioArgs.username
    * def password = policyDataContainer.getPassword()
    * configure headers = read('classpath:headers.js')
    * def accountsUrl = PC_URL + '/rest/account/v1/accounts'
    * def policiesUrl = PC_URL + '/rest/policy/v1/policies'
    * def activitiesUrl = PC_URL + '/rest/common/v1/activities'
    * def sharedPath = 'classpath:gw/surepath/e2e/action/activity/'
    * def jobsUrl = PC_URL + '/rest/job/v1/jobs'

  @id=AddActivityToAccount
  Scenario: Add activity to account
    * def requiredArguments = ['accountId']
    Given url accountsUrl + '/' + __arg.scenarioArgs.accountId + '/activities'
    And request readWithArgs(sharedPath + 'addActivity.json', __arg.templateArgs)
    When method POST
    Then status 201
    * match response.data.attributes.activityPattern == __arg.templateArgs.activityPattern
    * setStepVariable('activityId', response.data.attributes.id)

  @id=AddActivityToPolicy
  Scenario: Add activity to policy
    * def requiredArguments = ['policyId']
    Given url policiesUrl + '/' + __arg.scenarioArgs.policyId + '/activities'
    And request readWithArgs(sharedPath + 'addActivity.json', __arg.templateArgs)
    When method POST
    Then status 201
    * match response.data.attributes.activityPattern == __arg.templateArgs.activityPattern
    * setStepVariable('activityId', response.data.attributes.id)

  @id=EnsureActivityExistsInAccount
  Scenario: Ensure the activity exists in the account
    * def requiredArguments = ['accountId', 'activityId']
    Given url accountsUrl + '/' + __arg.scenarioArgs.accountId + '/activities'
    When method GET
    Then status 200
    And match response.data[*].attributes.id contains __arg.scenarioArgs.activityId

  @id=EnsureActivityExistsInPolicy
  Scenario: Ensure the activity exists in the policy
    * def requiredArguments = ['policyId', 'activityId']
    Given url policiesUrl + '/' + __arg.scenarioArgs.policyId + '/activities'
    When method GET
    Then status 200
    And match response.data[*].attributes.id contains __arg.scenarioArgs.activityId

  @id=CheckActivityAssignedTo
  Scenario: Check to whom the activity is assigned to
    * def requiredArguments = ['activityId', 'userId']
    Given url activitiesUrl + '/' + __arg.scenarioArgs.activityId
    When method GET
    Then status 200
    And match response.data.attributes.assignedUser.id == __arg.scenarioArgs.userId

  @id=CheckActivityPlanned
  Scenario: Check whether activity is planned in submission
    * def requiredArguments = ['jobId', 'activityName']
    Given url jobsUrl + '/' + __arg.scenarioArgs.jobId + '/activities'
    When method GET
    Then status 200
    And match response.data[*].attributes.subject contains __arg.scenarioArgs.activityName