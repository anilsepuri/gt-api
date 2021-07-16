Feature: Account
  Step scenarios that operate on Accounts

  Background:
    * def username = policyDataContainer.getPolicyUser(__arg.cucumberDataCache.currentUserRole).getName()
    * def userProducerCode = call read('classpath:user-config.js') __arg.cucumberDataCache.currentUserRole
    * def generateUUID =
      """
        function(){ return java.util.UUID.randomUUID() + '' }
      """

  @id=PersonalAccount
  Scenario: a Personal account
    * __arg.cucumberDataCache.accountHolderFirstName = ('John' + generateUUID()).substring(0, 28)
    * __arg.cucumberDataCache.accountHolderLastName = ('Portman' + generateUUID()).substring(0, 28)
    When step('AccountActions.AddAccount', {'scenarioArgs': {'username': username, 'accountType': 'Person'}, 'templateArgs': {'producerCodeId': userProducerCode, 'accountHolderFirstName': __arg.cucumberDataCache.accountHolderFirstName, 'accountHolderLastName': __arg.cucumberDataCache.accountHolderLastName}})
    * __arg.cucumberDataCache.accountId = getStepVariable('AccountActions.AddAccount', 'accountId')
    * __arg.cucumberDataCache.contactId = getStepVariable('AccountActions.AddAccount', 'contactId')

  @id=AccountWithDetails
  Scenario: an account exists with the following details
    * def parameters = ['accountType', 'state']
    When step('AccountActions.AddAccount', {'scenarioArgs': {'username': username, 'accountType': __arg.parameters.accountType}, 'templateArgs': {'producerCodeId': userProducerCode, 'state': __arg.parameters.state}})
    * __arg.cucumberDataCache.accountId = getStepVariable('AccountActions.AddAccount', 'accountId')
    * __arg.cucumberDataCache.contactId = getStepVariable('AccountActions.AddAccount', 'contactId')

  @id=GetAccountAssociatedPolicies
  Scenario: I retrieve policies associated with the account
    * step('AccountActions.GetAccountAssociatedPolicies', {'scenarioArgs': {'username': username, 'accountId': __arg.cucumberDataCache.accountId}})
    * __arg.cucumberDataCache.listOfPolicies = getStepVariable('AccountActions.GetAccountAssociatedPolicies', 'listOfPolicies')

  @id=SearchAccountWithName
  Scenario: I search for that account with the account holder's first and last name
    * step('AccountActions.SearchAccounts', {'scenarioArgs': {'username': username, 'identifier': 'Name'}, 'templateArgs': {'accountHolderFirstName': __arg.cucumberDataCache.accountHolderFirstName, 'accountHolderLastName': __arg.cucumberDataCache.accountHolderLastName}})
    * __arg.cucumberDataCache.listOfAccounts = getStepVariable('AccountActions.SearchAccounts', 'listOfAccounts')

  @id=AccountFound
  Scenario: the account is found
    * step('AccountActions.MatchAccountByAccountId', {'scenarioArgs': {'listOfAccounts': __arg.cucumberDataCache.listOfAccounts, 'accountId': __arg.cucumberDataCache.accountId}})