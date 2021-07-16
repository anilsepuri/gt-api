Feature: Job
  Action scenarios that operate on jobs

  Background:
    * def username = __arg.scenarioArgs.username
    * def password = policyDataContainer.getPassword()
    * def sharedPath = 'classpath:gw/surepath/e2e/action/job/'
    * def emptyRequestTemplate = 'classpath:gw/surepath/e2e/action/emptyRequest.json'
    * def jobUrl = PC_URL + '/rest/job/v1/jobs'
    * configure headers = read('classpath:headers.js')

  @id=GetJob
  Scenario: Get a job
    * def requiredArguments = ['jobId']
    * def getJobUrl = jobUrl + '/' + __arg.scenarioArgs.jobId
    Given url getJobUrl
    When method GET
    Then status 200
    And setStepVariable('jobStatus', response.data.attributes.jobStatus.code)

  @id=QuoteAJob
  Scenario: Quote a job
    * def requiredArguments = ['jobId']
    * def quoteUrl = jobUrl +  "/" + __arg.scenarioArgs.jobId + '/quote'
    Given url quoteUrl
    And request read(emptyRequestTemplate)
    When method POST
    Then status 200

  @id=QuoteJobWithIssue
  Scenario: Quote a job with issue
    * def requiredArguments = ['jobId']
    * def quoteJobUrl = jobUrl + "/" + __arg.scenarioArgs.jobId + '/quote'
    Given url quoteJobUrl
    And request read(emptyRequestTemplate)
    When method POST
    Then status 400
    And setStepVariable('errorMessage', response.userMessage)

  @id=BindOnlyJob
  Scenario: Bind a job
    * def requiredArguments = ['jobId']
    * def bindJobUrl = jobUrl + "/" + __arg.scenarioArgs.jobId + '/bind-only'
    Given url bindJobUrl
    And request read(emptyRequestTemplate)
    When method POST
    Then status 200
    * setStepVariable('policyNumber', response.data.attributes.policyNumber)

  @id=BindOnlyJobWithIssue
  Scenario: Bind a job with issue
    * def requiredArguments = ['jobId']
    * def bindJobUrl = jobUrl + "/" + __arg.scenarioArgs.jobId + '/bind-only'
    Given url bindJobUrl
    And request read(emptyRequestTemplate)
    When method POST
    Then status 400
    And setStepVariable('errorMessage', response.userMessage)

  @id=BindAndIssueAJob
  Scenario: Bind and issue a job
    * def requiredArguments = ['jobId']
    * def bindJobUrl = jobUrl + "/" + __arg.scenarioArgs.jobId + '/bind-and-issue'
    Given url bindJobUrl
    And request read(emptyRequestTemplate)
    When method POST
    Then status 200
    * setStepVariable('policyNumber', response.data.attributes.policyNumber)
    * setStepVariable('policyId', response.data.attributes.policy.id)

  @id=CheckJobStatus
  Scenario: Check job status
    * def requiredArguments = ['actualJobStatus', 'expectedJobStatus']
    * match karate.lowerCase(__arg.scenarioArgs.actualJobStatus) == karate.lowerCase(__arg.scenarioArgs.expectedJobStatus)

  @id=CheckPolicyNumberIsSet
  Scenario: Check is policy number set
    * def requiredArguments = ['policyNumber']
    * match __arg.scenarioArgs.policyNumber != null

  @id=CompareIssueMessage
  Scenario: Compare issue message
    * def requiredArguments = ['actualIssueMessage', 'expectedIssueMessage']
    * match karate.lowerCase(__arg.scenarioArgs.actualIssueMessage) == karate.lowerCase(__arg.scenarioArgs.expectedIssueMessage)

  @id=GetPaymentInfo
  Scenario: Get payment info
    * def requiredArguments = ['jobId']
    Given url jobUrl + '/' + __arg.scenarioArgs.jobId + '/payment-info'
    When method GET
    Then status 200
    * match response.data.attributes.billingMethod.code != null
    * match response.data.attributes.selectedPaymentPlan.id != null

  @id=SearchJobs
  Scenario: Search Jobs
    * def requiredArguments = ['identifier']
    * def jobSearchUrl = PC_URL + '/rest/job/v1/search/jobs'
    * def getSearchJobTemplate =
    """
      function(identifier) {
        if(identifier === "Policy Number") {
          return sharedPath + 'searchJobByPolicyNumberAndJobType.json';
        }
      }
    """
    Given url jobSearchUrl
    And request readWithArgs(getSearchJobTemplate(__arg.scenarioArgs.identifier), __arg.templateArgs)
    When method POST
    Then status 200
    * setStepVariable('jobCount', response.count)

  @id=VerifyJobCount
  Scenario: Verify job count
    * def requiredArguments = ['actualJobCount', 'expectedJobCount']
    * match __arg.scenarioArgs.actualJobCount == __arg.scenarioArgs.expectedJobCount