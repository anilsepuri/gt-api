function fn() {
    var pcBaseUrl = java.lang.System.getenv('pcBaseUrl') ? java.lang.System.getenv('pcBaseUrl') : 'https://pc-sandbox-gwcpdev.canal.beta3-andromeda.guidewire.net/PolicyCenter.do';

    var config = {
        util: Java.type('gw.gtapi.util.KarateJavaWrapper'),
        stepVariablesContainer : Java.type('com.gw.execution.CucumberStepVariablesContainer'),
        policyDataContainer : Java.type('gw.datacreation.admindata.PolicyDataContainer'),
        policyUtil: Java.type('gw.util.PolicyUtil')
    };

    karate.configure('logPrettyRequest', true);
    karate.configure('logPrettyResponse', true);

    config.PC_URL = pcBaseUrl;

    karate.callSingle('classpath:com/gw/GtApiHealthCheck.feature@id=AppHealthCheck', {'appUrl': config.PC_URL});
    karate.call('classpath:gtapi-e2e-util.js', config);

    return config;
}
