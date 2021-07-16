Feature: Job
  Step scenarios that operate on Jobs

  Background:
    * def username = policyDataContainer.getPolicyUser(__arg.cucumberDataCache.currentUserRole).getName()
    * def unrestrictedUser = policyUtil.getUnrestrictedUser()

  @id=BindOnlyJob
  Scenario: I bind the submission
    * step('JobActions.BindOnlyJob', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId}})
    * __arg.cucumberDataCache.policyNumber = getStepVariable('JobActions.BindOnlyJob', 'policyNumber')

  @id=BindOnlyJobWithUWIssue
  Scenario: I bind the submission with UW issue
    * step('JobActions.BindOnlyJobWithIssue', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId}})
    * __arg.cucumberDataCache.IssueMessage = getStepVariable('JobActions.BindOnlyJobWithIssue', 'errorMessage')

  @id=BindAndIssueJob
  Scenario: I issue the submission
    * step('JobActions.BindAndIssueAJob', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId}})

  @id=CheckJobStatus
  Scenario: the submission is in {string} status
    * def parameters = ['expectedJobStatus']
    When step('JobActions.GetJob', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId}})
    * def jobStatus = getStepVariable('JobActions.GetJob', 'jobStatus')
    Then step('JobActions.CheckJobStatus', {'scenarioArgs': {'actualJobStatus': jobStatus, 'expectedJobStatus': __arg.parameters.expectedJobStatus}})

  @id=PolicyNumber
  Scenario: a policy number is set
    * step('JobActions.CheckPolicyNumberIsSet', {'scenarioArgs': {'username': username, 'policyNumber': __arg.cucumberDataCache.policyNumber}})

  @id=BindUWIssueMessage
  Scenario: the submission cannot be bound because of the UW issue
    * def errorMessage = "Underwriting issues block 'bind-only' action"
    * step('JobActions.CompareIssueMessage', {'scenarioArgs': {'username': username, 'actualIssueMessage': __arg.cucumberDataCache.IssueMessage, 'expectedIssueMessage': errorMessage}})

  @id=QuoteUWIssueMessage
  Scenario: the submission cannot be quoted because of the UW issue
    * def errorMessage = "Underwriting issues block 'quote' action"
    * step('JobActions.CompareIssueMessage', {'scenarioArgs': {'username': username, 'actualIssueMessage': __arg.cucumberDataCache.IssueMessage, 'expectedIssueMessage': errorMessage}})

  @id=QuoteValidationErrorMessage
  Scenario: the submission cannot be quoted because of the validation error
    * def errorMessage = "Entity validation errors block 'quote' action"
    * step('JobActions.CompareIssueMessage', {'scenarioArgs': {'username': username, 'actualIssueMessage': __arg.cucumberDataCache.IssueMessage, 'expectedIssueMessage': errorMessage}})

  @id=SubmissionPayment
  Scenario: a Billing Method and Payment Plan are determined
    When step('JobActions.GetPaymentInfo', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId}})

  @id=RenewalStarted
  Scenario: a renewal is started
    * step('JobActions.SearchJobs', {'scenarioArgs': {'username': unrestrictedUser, 'identifier': 'Policy Number'}, 'templateArgs': {'policyNumber': __arg.cucumberDataCache.policyNumber, 'jobTypeCode': 'Renewal'}})
    * def jobCount = getStepVariable('JobActions.SearchJobs', 'jobCount')
    * step('JobActions.VerifyJobCount', {'scenarioArgs': {'actualJobCount': jobCount, 'expectedJobCount': 1}})

  @id=RenewalNotStarted
  Scenario: a renewal is not started
    * step('JobActions.SearchJobs', {'scenarioArgs': {'username': unrestrictedUser, 'identifier': 'Policy Number'}, 'templateArgs': {'policyNumber': __arg.cucumberDataCache.policyNumber, 'jobTypeCode': 'Renewal'}})
    * def jobCount = getStepVariable('JobActions.SearchJobs', 'jobCount')
    * step('JobActions.VerifyJobCount', {'scenarioArgs': {'actualJobCount': jobCount, 'expectedJobCount': 0}})