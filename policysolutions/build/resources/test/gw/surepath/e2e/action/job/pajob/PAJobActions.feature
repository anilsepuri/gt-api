Feature: Personal Auto Job
  Action scenarios that operate on PA jobs

  Background:
    * def username = __arg.scenarioArgs.username
    * def password = policyDataContainer.getPassword()
    * def sharedPath = 'classpath:gw/surepath/e2e/action/job/pajob/'
    * def jobUrl = PC_URL + '/rest/job/v1/jobs'
    * configure headers = read('classpath:headers.js')

  @id=CreatePAVehicle
  Scenario: Create a Personal Auto Vehicle
    * def requiredArguments = ['jobId']
    * def addPersonalVehicleTemplate = sharedPath + 'addPersonalVehicle.json'
    * def personalVehicleUrl = jobUrl +  "/" + __arg.scenarioArgs.jobId + '/lines/PersonalAutoLine/personal-vehicles'
    Given url personalVehicleUrl
    And request read(addPersonalVehicleTemplate)
    When method POST
    Then status 201
    And setStepVariable('vehicleId', response.data.attributes.id)

  @id=CreatePAVehicleWithUWIssue
  Scenario: Create a Personal Auto Vehicle with UW issue
    * def requiredArguments = ['jobId']
    * def addPersonalVehicleTemplate = sharedPath + 'addPersonalVehicleWithUWIssue.json'
    * def personalVehicleUrl = jobUrl +  "/" + __arg.scenarioArgs.jobId + '/lines/PersonalAutoLine/personal-vehicles'
    Given url personalVehicleUrl
    And request read(addPersonalVehicleTemplate)
    When method POST
    Then status 201
    And setStepVariable('vehicleId', response.data.attributes.id)

  @id=AddPrimaryDriverToVehicle
  Scenario: Add a primary driver to the vehicle
    * def requiredArguments = ['jobId', 'vehicleId']
    * def addPrimaryDriverToVehicleTemplate = sharedPath + 'addDriverToVehicle.json'
    * def addDriverUrl = jobUrl +  "/" + __arg.scenarioArgs.jobId + '/lines/PersonalAutoLine/personal-vehicles/' + __arg.scenarioArgs.vehicleId + '/vehicle-drivers'
    Given url addDriverUrl
    And request readWithArgs(addPrimaryDriverToVehicleTemplate, __arg.templateArgs)
    When method POST
    Then status 201

  @id=SyncCoverages
  Scenario: Synchronize coverages
    * def requiredArguments = ['jobId', 'vehicleId']
    * def emptyRequestTemplate = 'classpath:gw/surepath/e2e/action/emptyRequest.json'
    * def syncCoveragesUrl = jobUrl +  "/" + __arg.scenarioArgs.jobId + '/lines/PersonalAutoLine/personal-vehicles/' + __arg.scenarioArgs.vehicleId + '/sync-coverages'
    Given url syncCoveragesUrl
    And request read(emptyRequestTemplate)
    When method POST
    Then status 200

  @id=UpdateVehicleVin
  Scenario: Update vehicle VIN
    * def requiredArguments = ['jobId', 'vehicleId']
    * def updateVehicleVIN = sharedPath + 'updateVehicleVIN.json'
    * def updateVehicleUrl = jobUrl +  "/" + __arg.scenarioArgs.jobId + '/lines/PersonalAutoLine/personal-vehicles/' + __arg.scenarioArgs.vehicleId
    Given url updateVehicleUrl
    And request readWithArgs(updateVehicleVIN, __arg.templateArgs)
    When method PATCH
    Then status 200

  @id=UpdateVehicleToNoVin
  Scenario: Update vehicle to no VIN
    * def requiredArguments = ['jobId', 'vehicleId']
    * def updateVehicleVIN = sharedPath + 'updateVehicleToNoVIN.json'
    * def updateVehicleUrl = jobUrl +  "/" + __arg.scenarioArgs.jobId + '/lines/PersonalAutoLine/personal-vehicles/' + __arg.scenarioArgs.vehicleId
    Given url updateVehicleUrl
    And request read(updateVehicleVIN)
    When method PATCH
    Then status 200