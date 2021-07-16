Feature: Activity
  Step scenarios that operate on Activities

  Background:
    * def username = policyDataContainer.getPolicyUser(__arg.cucumberDataCache.currentUserRole).getName()
    * def getActivityPatternCode =
    """
      function(activity) {
        switch(activity) {
          case 'Review new mail':
            return 'new_mail';
          default:
            throw 'Unhandled activity pattern: ' + activity;
        }
      }
    """

  @id=AccountActivity
  Scenario: I create an activity to {string} for the account
    * def parameters = ['activity']
    * def activityPattern = getActivityPatternCode(__arg.parameters.activity)
    When step('ActivityActions.AddActivityToAccount', {'scenarioArgs': {'username': username, 'accountId': __arg.cucumberDataCache.accountId}, 'templateArgs': {'activityPattern': activityPattern}})
    * __arg.cucumberDataCache.activityId = getStepVariable('ActivityActions.AddActivityToAccount', 'activityId')

  @id=PolicyActivity
  Scenario: I create an activity to {string} for the policy
    * def parameters = ['activity']
    * def activityPattern = getActivityPatternCode(__arg.parameters.activity)
    When step('ActivityActions.AddActivityToPolicy', {'scenarioArgs': {'username': username, 'policyId': __arg.cucumberDataCache.policyId}, 'templateArgs': {'activityPattern': activityPattern}})
    * __arg.cucumberDataCache.activityId = getStepVariable('ActivityActions.AddActivityToPolicy', 'activityId')

  @id=ActivityInAccountWorkplan
  Scenario: the activity is in the account's workplan
    Then step('ActivityActions.EnsureActivityExistsInAccount', {'scenarioArgs': {'username': username, 'accountId': __arg.cucumberDataCache.accountId, 'activityId': __arg.cucumberDataCache.activityId}})

  @id=ActivityInPolicyWorkplan
  Scenario: the activity is in the policy's workplan
    Then step('ActivityActions.EnsureActivityExistsInPolicy', {'scenarioArgs': {'username': username, 'policyId': __arg.cucumberDataCache.policyId, 'activityId': __arg.cucumberDataCache.activityId}})

  @id=ActivityAssignedTo
  Scenario: the activity is assigned to me
    * def userId = policyDataContainer.getPolicyUser(__arg.cucumberDataCache.currentUserRole).getId()
    Then step('ActivityActions.CheckActivityAssignedTo', {'scenarioArgs': {'username': username, 'activityId': __arg.cucumberDataCache.activityId, 'userId': userId}})

  @id=ActivityPlanned
  Scenario: an activity to {string} is planned
    * def parameters = ['activityName']
    Then step('ActivityActions.CheckActivityPlanned', {'scenarioArgs': {'username': username, 'jobId': __arg.cucumberDataCache.jobId, 'activityName': __arg.parameters.activityName}})