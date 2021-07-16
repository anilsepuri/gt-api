Feature: Maintenance
  Step scenarios that operate on system maintenance

  Background:
    * def unrestrictedUser = policyUtil.getUnrestrictedUser()

  @id=RunPolicyRenewalStartBatch
  Scenario: policies are checked for renewal
    * def waitToProcessWorkItems =
    """
      function(){
        var done = false;
        while(!done) {
          step('MaintenanceActions.GetWorkQueue', {'scenarioArgs': {'username': unrestrictedUser, 'processType': 'PolicyRenewalStart'}});
          var numOfActiveWorkItems = getStepVariable('MaintenanceActions.GetWorkQueue', 'numOfActiveWorkItems');
          if(numOfActiveWorkItems === 0) {
            done = true;
          } else {
            java.lang.Thread.sleep(1000);
          }
        }
      }
    """
    * step('MaintenanceActions.RunBatchProcess', {'scenarioArgs': {'username': unrestrictedUser}, 'templateArgs': {'processType': 'PolicyRenewalStart'}})
    * call waitToProcessWorkItems()