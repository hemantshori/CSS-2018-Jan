package runnerAndSteps;

import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

// This is Runner and the tests will be run from here......Right click and Run as Junit tests
@RunWith(Cucumber.class)
@CucumberOptions

// ************************************** USS Portal as on 17/10/2016
// OCT***********************************

(format = { "pretty", "html:target/html/result.html" },  tags = {"@USS_Regression"},
    //*********************for SHAKEOUT*************************************
	//	 features = "src/test/resource/com/USS/SanityTestScript.feature") 
		
    //****************for Regression****************************
	 features = "src/test/resource/com/USS/RegressionTests.feature") 
		
    //********************for wip********************************
	//	features = "src/test/resource/com/USS/wip.feature") /// wip


//  *********************Testing TANG 
//features = "src/test/resource/com/TSS/TANG_TSSPhase1.feature") 


     //**** p10 ************************************
 
   // features = "src/test/resource/com/USS/wip.feature") 

// ************************************** Admin
// Portal***********************************
// features = "src/test/resource/UAP.feature")


//features = "src/test/resource/com/DB_SS/DB_Regression.feature") 
//features = "src/test/resource/com/DB_SS/SelfServe_Regression.feature") 

// ****************************************************************************************

public class RunnerTest {

}
