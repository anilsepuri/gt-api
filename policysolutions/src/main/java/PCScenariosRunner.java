import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        glue = {"gw"},
        strict = true,
        plugin = { "progress", "html:target/cucumber-reports",
                "json:target/cucumber-reports/Cucumber.json",
                "junit:target/cucumber-reports/Cucumber.xml" },
        tags = {"@<Tag_Name>"}
)
public class PCScenariosRunner {
}
