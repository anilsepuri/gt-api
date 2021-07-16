package gw.surepath.e2e.suites.designatedfunctions;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = {"src/main/java/gw/surepath/e2e/behavior"},
        glue = {"gw"},
        plugin = { "progress", "html:target/cucumber-reports",
                "json:target/cucumber-reports/Cucumber.json",
                "junit:target/cucumber-reports/Cucumber.xml" },
        tags = {"@add_activity"}
)
public class PCAddActivityCucumberScenarioRunner {
}