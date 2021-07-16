$(document).ready(function() {var formatter = new CucumberHTML.DOMFormatter($('.cucumber-report'));formatter.uri("file:src/main/java/gw/surepath/e2e/behavior/common/COM-AccountSearch.feature");
formatter.feature({
  "name": "Account Search",
  "description": "  As a producer\n  I want to search for an account\n  So that I can review or update the account and associated policies",
  "keyword": "Feature",
  "tags": [
    {
      "name": "@common"
    },
    {
      "name": "@account_search"
    }
  ]
});
formatter.background({
  "name": "",
  "description": "",
  "keyword": "Background"
});
formatter.before({
  "status": "passed"
});
formatter.beforestep({
  "status": "passed"
});
formatter.step({
  "name": "I am a user with the \"Producer\" role",
  "keyword": "Given "
});
formatter.match({
  "location": "gw.cucumber.CucumberStep.anyStepWithoutDataTable()"
});
formatter.result({
  "error_message": "com.intuit.karate.exception.KarateException: GtApiStepExecution.feature:5 - javascript evaluation failed: step(__arg.featureAndScenarioId, __arg.parameters), com.intuit.karate.exception.KarateException: \nPolicyUserRoleSetup.feature:16 - javascript evaluation failed: setupUserRole(__arg.parameters.userRole), com.intuit.karate.exception.KarateException: \nCreatePolicyAdminData.feature:7 - javascript evaluation failed: policyAdminData.loadAdminData(\u0027policysolutions\u0027), ProducerCodes.feature:17 - status code was: 404, expected: 201, response time: 146, url: https://pc-sandbox-gwcpdev.canal.beta3-andromeda.guidewire.net/PolicyCenter.do/rest/testsupport/v1/producer-codes, response: \u003c!doctype html\u003e\u003chtml lang\u003d\"en\"\u003e\u003chead\u003e\u003ctitle\u003eHTTP Status 404 – Not Found\u003c/title\u003e\u003cstyle type\u003d\"text/css\"\u003ebody {font-family:Tahoma,Arial,sans-serif;} h1, h2, h3, b {color:white;background-color:#525D76;} h1 {font-size:22px;} h2 {font-size:16px;} h3 {font-size:14px;} p {font-size:12px;} a {color:black;} .line {height:1px;background-color:#525D76;border:none;}\u003c/style\u003e\u003c/head\u003e\u003cbody\u003e\u003ch1\u003eHTTP Status 404 – Not Found\u003c/h1\u003e\u003c/body\u003e\u003c/html\u003e in \u003ceval\u003e at line number 76 at column number 6 in \u003ceval\u003e at line number 76 at column number 6\r\n\tat ✽.* step(__arg.featureAndScenarioId, __arg.parameters) (GtApiStepExecution.feature:5)\r\n\tat ✽.I am a user with the \"Producer\" role(file:///C:/Users/asepuri/IdeaProjects/gt-api/policysolutions/src/main/java/gw/surepath/e2e/behavior/common/COM-AccountSearch.feature:8)\r\n",
  "status": "failed"
});
formatter.afterstep({
  "status": "passed"
});
formatter.beforestep({
  "status": "skipped"
});
formatter.scenario({
  "name": "Search for an account with account holder\u0027s name",
  "description": "",
  "keyword": "Scenario",
  "tags": [
    {
      "name": "@common"
    },
    {
      "name": "@account_search"
    },
    {
      "name": "@DesignatedFunction"
    }
  ]
});
formatter.step({
  "name": "a Personal account",
  "keyword": "Given "
});
formatter.match({
  "location": "gw.cucumber.CucumberStep.anyStepWithoutDataTable()"
});
formatter.result({
  "status": "skipped"
});
formatter.afterstep({
  "status": "skipped"
});
formatter.beforestep({
  "status": "skipped"
});
formatter.step({
  "name": "I search for that account with the account holder\u0027s first and last name",
  "keyword": "When "
});
formatter.match({
  "location": "gw.cucumber.CucumberStep.anyStepWithoutDataTable()"
});
formatter.result({
  "status": "skipped"
});
formatter.afterstep({
  "status": "skipped"
});
formatter.beforestep({
  "status": "skipped"
});
formatter.step({
  "name": "the account is found",
  "keyword": "Then "
});
formatter.match({
  "location": "gw.cucumber.CucumberStep.anyStepWithoutDataTable()"
});
formatter.result({
  "status": "skipped"
});
formatter.afterstep({
  "status": "skipped"
});
formatter.beforestep({
  "status": "skipped"
});
formatter.step({
  "name": "verify.match(",
  "keyword": "And "
});
formatter.match({
  "location": "gw.cucumber.CucumberStep.anyStepWithoutDataTable()"
});
formatter.result({
  "status": "skipped"
});
formatter.afterstep({
  "status": "skipped"
});
formatter.after({
  "status": "passed"
});
});