Feature: Policy
  Step scenarios that operate on Policies

  Background:
    * def username = policyDataContainer.getPolicyUser(__arg.cucumberDataCache.currentUserRole).getName()
    * def jobEffectiveDate = policyUtil.currentISODateString()

  @id=SearchPolicy
  Scenario: I search for that policy with policy number
    * step('PolicyActions.SearchPolicy', {'scenarioArgs': {'username': username}, 'templateArgs': {'policyNumber': __arg.cucumberDataCache.policyNumber}})
    * __arg.cucumberDataCache.listOfPolicies = getStepVariable('PolicyActions.SearchPolicy','listOfPolicies')

  @id=PolicyFound
  Scenario: the policy is found
    * step('PolicyActions.MatchPolicyByPolicyId', {'scenarioArgs': {'listOfPolicies': __arg.cucumberDataCache.listOfPolicies, 'policyId': __arg.cucumberDataCache.policyId}})

  @id=DraftPolicyChange
  Scenario: with a draft Policy Change
    * step('PolicyActions.StartPolicyChange', {'scenarioArgs': {'username': username, 'policyId': __arg.cucumberDataCache.policyId}, 'templateArgs': {'jobEffectiveDate': jobEffectiveDate}})