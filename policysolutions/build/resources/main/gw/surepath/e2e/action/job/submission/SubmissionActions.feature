Feature: Submission
  Action scenarios that operate on submissions

  Background:
    * def username = __arg.scenarioArgs.username
    * def password = policyDataContainer.getPassword()
    * def sharedPath = 'classpath:gw/surepath/e2e/action/job/submission/'
    * def submissionUrl = PC_URL + '/rest/job/v1/submissions'
    * configure headers = read('classpath:headers.js')

    @id=CreateSubmission
    Scenario: Create a policy submission
      * def createSubmissionTemplate = sharedPath + 'createSubmission.json'
      Given url submissionUrl
      And request readWithArgs(createSubmissionTemplate,  __arg.templateArgs)
      When method POST
      Then status 201
      And setStepVariable('submissionId', response.data.attributes.id)