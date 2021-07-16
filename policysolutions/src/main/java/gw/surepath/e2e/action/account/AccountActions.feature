Feature: Account
  Action scenarios that operate on Accounts

  Background:
    * def username = __arg.scenarioArgs.username
    * def password = policyDataContainer.getPassword()
    * configure headers = read('classpath:headers.js')
    * def accountsUrl = PC_URL + '/rest/account/v1/accounts'
    * def sharedPath = 'classpath:gw/surepath/e2e/action/account/'

  @id=AddAccount
  Scenario: Create an account
    * def requiredArguments = ['accountType']
    * def getCreateAccountTemplateName =
    """
     function(accountType) {
        switch(accountType) {
          case 'Person':
            return sharedPath + 'addPersonAccount.json';
          case 'Company':
            return sharedPath + 'addCompanyAccount.json';
          default:
           throw 'Unhandled Account Type: ' + accountType;
       }
     }
    """
    Given url accountsUrl
    And request readWithArgs(getCreateAccountTemplateName(__arg.scenarioArgs.accountType), __arg.templateArgs)
    When method POST
    Then status 201
    * setStepVariable('contactId', response.data.attributes.accountHolder.id)
    * setStepVariable('accountId', response.data.attributes.id)
    * setStepVariable('accountNumber', response.data.attributes.accountNumber)

  @id=GetAccountAssociatedPolicies
  Scenario: Get account associated policies
    Given url accountsUrl + '/' + __arg.scenarioArgs.accountId + '/policies'
    When method GET
    Then status 200
    And assert response.count > 0
    * def listOfPolicies = karate.jsonPath(response, '$.data[*].attributes.id')
    * setStepVariable('listOfPolicies', listOfPolicies)

  @id=SearchAccounts
  Scenario: Search accounts
    * def requiredArguments = ['identifier']
    * def getSearchAccountTemplate =
    """
      function(identifier) {
        if(identifier === 'Name') {
          return sharedPath + 'searchAccountWithFirstAndLastName.json';
        }
      }
    """
    Given url PC_URL + '/rest/account/v1/search/accounts'
    And request readWithArgs(getSearchAccountTemplate(__arg.scenarioArgs.identifier), __arg.templateArgs)
    When method POST
    Then status 200
    And assert response.count > 0
    * def listOfAccounts = karate.jsonPath(response, '$.data[*].attributes.id')
    * setStepVariable('listOfAccounts', listOfAccounts)

  @id=MatchAccountByAccountId
  Scenario: Match an account by account id
    * def requiredArguments = ['listOfAccounts', 'accountId']
    * match __arg.scenarioArgs.listOfAccounts contains __arg.scenarioArgs.accountId

