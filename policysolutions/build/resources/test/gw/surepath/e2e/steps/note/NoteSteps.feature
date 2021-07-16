Feature: Note
  Step scenarios that operate on Notes

  Background:
    * def username = policyDataContainer.getPolicyUser(__arg.cucumberDataCache.currentUserRole).getName()

  @id=AddAndGetAccountNote
  Scenario: I can add a note to the account with the following
    * def parameters = ['topic', 'body']
    When step('NoteActions.AddNoteToAccount', {'scenarioArgs': {'username': username, 'accountId': __arg.cucumberDataCache.accountId}, 'templateArgs': __arg.parameters})
    * def noteId = getStepVariable('NoteActions.AddNoteToAccount', 'noteId')
    Then step('NoteActions.GetAccountNotes', {'scenarioArgs': {'username': username, 'accountId': __arg.cucumberDataCache.accountId, 'noteId': noteId}})

  @id=AddAndGetPolicyNote
  Scenario: I can add a note to the policy with the following
    * def parameters = ['topic', 'body']
    When step('NoteActions.AddNoteToPolicy', {'scenarioArgs': {'username': username, 'policyId': __arg.cucumberDataCache.policyId}, 'templateArgs': __arg.parameters})
    * def noteId = getStepVariable('NoteActions.AddNoteToPolicy', 'noteId')
    Then step('NoteActions.GetPolicyNotes', {'scenarioArgs': {'username': username, 'policyId': __arg.cucumberDataCache.policyId, 'noteId': noteId}})
