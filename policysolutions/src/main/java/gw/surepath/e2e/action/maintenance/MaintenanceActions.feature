Feature: Maintenance
  Action scenarios that operate on system maintenance

  Background:
    * def username = __arg.scenarioArgs.username
    * def password = policyDataContainer.getPassword()
    * def sharedPath = 'classpath:gw/surepath/e2e/action/maintenance/'
    * def maintenanceUrl = PC_URL + '/rest/system/v1/maintenance'
    * configure headers = read('classpath:headers.js')

  @id=RunBatchProcess
  Scenario:  Run batch process
    * def runBatchProcessTemplate = sharedPath + 'runBatchProcess.json'
    Given url maintenanceUrl + '/processes'
    And request readWithArgs(runBatchProcessTemplate, __arg.templateArgs)
    When method POST
    Then status 200

  @id=GetWorkQueue
  Scenario: Get work queue
    * def parameters = ['processType']
    Given url maintenanceUrl + '/workqueues/' + __arg.scenarioArgs.processType
    When method GET
    Then status 200
    * setStepVariable('numOfActiveWorkItems', response.numOfActiveWorkItems)
