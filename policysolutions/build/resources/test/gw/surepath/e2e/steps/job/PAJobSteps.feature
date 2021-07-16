Feature: Personal Auto Job
  Step scenarios that operate on PA Jobs

  Background:
    * def username = policyDataContainer.getPolicyUser(__arg.cucumberDataCache.currentUserRole).getName()
    * def userProducerCode = call read('classpath:user-config.js') __arg.cucumberDataCache.currentUserRole
    * def jobEffectiveDate = policyUtil.currentISODateString()
    * def createPAPolicySubmission =
    """
      function() {
        step('SubmissionActions.CreateSubmission', {'scenarioArgs': {'username': username}, 'templateArgs': {'accountId': __arg.cucumberDataCache.accountId, 'jobEffectiveDate': jobEffectiveDate, 'producerCode': userProducerCode}})
        var submissionId = getStepVariable('SubmissionActions.CreateSubmission', 'submissionId')
        step('PAJobActions.CreatePAVehicle', {'scenarioArgs': {'username': username, 'jobId': submissionId}})
        var vehicleId = getStepVariable('PAJobActions.CreatePAVehicle', 'vehicleId')
        step('PAJobActions.AddPrimaryDriverToVehicle', {'scenarioArgs': {'username': username, 'jobId': submissionId, 'vehicleId': vehicleId} , 'templateArgs': {'contactId': __arg.cucumberDataCache.contactId}})
        __arg.cucumberDataCache.jobId = submissionId
        __arg.cucumberDataCache.vehicleId = vehicleId
      }
    """

  @id=CreateDraftPAPolicySubmission
  Scenario: a draft Personal Auto Submission; I create a Personal Auto submission
    * call createPAPolicySubmission()

  @id=QuotedPASubmission
  Scenario: a Quoted Personal Auto submission
    * call createPAPolicySubmission()
    * step('PAJobActions.SyncCoverages', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId, 'vehicleId': __arg.cucumberDataCache.vehicleId}})
    * step('JobActions.QuoteAJob', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId}})

  @id=QuotedPASubmissionWithUWIssue
  Scenario: a Quoted Personal Auto submission with a bind blocking UW issue
    * step('SubmissionActions.CreateSubmission', {'scenarioArgs': {'username': username}, 'templateArgs': {'accountId': __arg.cucumberDataCache.accountId, 'jobEffectiveDate': jobEffectiveDate, 'producerCode': userProducerCode}})
    * def submissionId = getStepVariable('SubmissionActions.CreateSubmission', 'submissionId')
    * step('PAJobActions.CreatePAVehicleWithUWIssue', {'scenarioArgs': {'username': username, 'jobId': submissionId}})
    * def vehicleId = getStepVariable('PAJobActions.CreatePAVehicleWithUWIssue', 'vehicleId')
    * step('PAJobActions.AddPrimaryDriverToVehicle', {'scenarioArgs': {'username': username, 'jobId': submissionId, 'vehicleId': vehicleId} , 'templateArgs': {'contactId': __arg.cucumberDataCache.contactId}})
    * step('PAJobActions.SyncCoverages', {'scenarioArgs': {'username': username, 'jobId': submissionId, 'vehicleId': vehicleId}})
    * __arg.cucumberDataCache.jobId = submissionId
    * step('JobActions.QuoteAJob', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId}})

  @id=QuotePAJob
  Scenario: I quote the Personal Auto submission
    * step('PAJobActions.SyncCoverages', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId, 'vehicleId': __arg.cucumberDataCache.vehicleId}})
    * step('JobActions.QuoteAJob', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId}})

  @id=QuotePAJobWithIssue
  Scenario: I quote the Personal Auto submission with UW issue; I quote the Personal Auto submission with validation issue
    When step('PAJobActions.SyncCoverages', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId, 'vehicleId': __arg.cucumberDataCache.vehicleId}})
    And step('JobActions.QuoteJobWithIssue', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId}})
    * __arg.cucumberDataCache.IssueMessage = getStepVariable('JobActions.QuoteJobWithIssue', 'errorMessage')

  @id=VehicleWithNoVIN
  Scenario: a vehicle without a Vehicle Identification Number
    When step('PAJobActions.UpdateVehicleToNoVin', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId, 'vehicleId': __arg.cucumberDataCache.vehicleId}})

  @id=VehicleVIN
  Scenario: a vehicle with a Vehicle Identification Number {string}
    * def parameters = ['vin']
    When step('PAJobActions.UpdateVehicleVin', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId, 'vehicleId': __arg.cucumberDataCache.vehicleId}, 'templateArgs': {'vin': __arg.parameters.vin}})