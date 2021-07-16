Feature: Personal Auto Policy
  Step scenarios that operate on Personal Auto Policies

  Background:
    * def username = policyDataContainer.getPolicyUser(__arg.cucumberDataCache.currentUserRole).getName()
    * def userProducerCode = call read('classpath:user-config.js') __arg.cucumberDataCache.currentUserRole
    * def jobEffectiveDate = policyUtil.currentISODateString()
    * def oneYearBeforeToday = policyUtil.addMonthsToISODateString(policyUtil.currentISODateString(), -12)
    * def backDatedJobEffectiveDate = policyUtil.addDaysToISODateString(oneYearBeforeToday, policyUtil.getPersonalAutoRenewalLeadTime())

  @id=PAPolicy
  Scenario: a Personal Auto policy
    * def accountType = "Person"
    Given step('AccountActions.AddAccount', {'scenarioArgs': {'username': username, 'accountType': accountType}, 'templateArgs': {'producerCodeId': userProducerCode}})
    * def accountId = getStepVariable('AccountActions.AddAccount', 'accountId')
    * def contactId = getStepVariable('AccountActions.AddAccount', 'contactId')
    * __arg.cucumberDataCache.accountId = accountId
    When step('SubmissionActions.CreateSubmission', {'scenarioArgs': {'username': username}, 'templateArgs': {'accountId': accountId, 'jobEffectiveDate': jobEffectiveDate, 'producerCode': userProducerCode}})
    * def submissionId = getStepVariable('SubmissionActions.CreateSubmission', 'submissionId')
    And step('PAJobActions.CreatePAVehicle', {'scenarioArgs': {'username': username, 'jobId': submissionId}})
    * def vehicleId = getStepVariable('PAJobActions.CreatePAVehicle', 'vehicleId')
    And step('PAJobActions.AddPrimaryDriverToVehicle', {'scenarioArgs': {'username': username, 'jobId': submissionId, 'vehicleId': vehicleId} , 'templateArgs': {'contactId': contactId}})
    And step('PAJobActions.SyncCoverages', {'scenarioArgs': {'username': username, 'jobId': submissionId, 'vehicleId': vehicleId}})
    And step('JobActions.QuoteAJob', {'scenarioArgs': {'username': username, 'jobId': submissionId}})
    And step('JobActions.BindAndIssueAJob', {'scenarioArgs': {'username': username, 'jobId': submissionId}})
    * __arg.cucumberDataCache.policyId = getStepVariable('JobActions.BindAndIssueAJob', 'policyId')
    * __arg.cucumberDataCache.policyNumber = getStepVariable('JobActions.BindAndIssueAJob', 'policyNumber')

  @id=BackdatedPAPolicy
  Scenario: a Personal Auto policy with expiration date within the renewal lead time
    * def accountType = "Person"
    Given step('AccountActions.AddAccount', {'scenarioArgs': {'username': username, 'accountType': accountType}, 'templateArgs': {'producerCodeId': userProducerCode}})
    * def accountId = getStepVariable('AccountActions.AddAccount', 'accountId')
    * def contactId = getStepVariable('AccountActions.AddAccount', 'contactId')
    When step('SubmissionActions.CreateSubmission', {'scenarioArgs': {'username': username}, 'templateArgs': {'accountId': accountId, 'jobEffectiveDate': backDatedJobEffectiveDate, 'producerCode': userProducerCode}})
    * def submissionId = getStepVariable('SubmissionActions.CreateSubmission', 'submissionId')
    And step('PAJobActions.CreatePAVehicle', {'scenarioArgs': {'username': username, 'jobId': submissionId}})
    * def vehicleId = getStepVariable('PAJobActions.CreatePAVehicle', 'vehicleId')
    And step('PAJobActions.AddPrimaryDriverToVehicle', {'scenarioArgs': {'username': username, 'jobId': submissionId, 'vehicleId': vehicleId} , 'templateArgs': {'contactId': contactId}})
    And step('PAJobActions.SyncCoverages', {'scenarioArgs': {'username': username, 'jobId': submissionId, 'vehicleId': vehicleId}})
    And step('JobActions.QuoteAJob', {'scenarioArgs': {'username': username, 'jobId': submissionId}})
    And step('JobActions.BindAndIssueAJob', {'scenarioArgs': {'username': username, 'jobId': submissionId}})
    * __arg.cucumberDataCache.policyId = getStepVariable('JobActions.BindAndIssueAJob', 'policyId')
    * __arg.cucumberDataCache.policyNumber = getStepVariable('JobActions.BindAndIssueAJob', 'policyNumber')