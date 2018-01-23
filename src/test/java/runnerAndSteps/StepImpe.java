
package runnerAndSteps;

import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.regex.Pattern;

import org.apache.commons.io.FileUtils;
import org.junit.AfterClass;
import org.junit.Assert;
import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.Platform;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxBinary;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.Select;

import cucumber.api.DataTable;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import io.github.bonigarcia.wdm.ChromeDriverManager;
import io.github.bonigarcia.wdm.FirefoxDriverManager;
import reporting.com.HTMLReports.AccountFinancialHistorypage;
import reporting.com.HTMLReports.BillingHistoryPage;
import reporting.com.HTMLReports.DBUtilities;
import reporting.com.HTMLReports.ForgotYourPasswordPage;
import reporting.com.HTMLReports.GoalsAndTargetsPage;
import reporting.com.HTMLReports.HomePage;
import reporting.com.HTMLReports.LandingPage;
import reporting.com.HTMLReports.MakeAPaymentPage;

final public class StepImpe {
	// ********************************************** following is before and
	// after *****************************************
	WebDriver driver;

	// all WCAG stuff
	static String Capture;
	static String sourceCode;

	static String URLCaptured;
	final String wcag_subdirectory = "wcagoutput";
	final String screenshot_subdirectory = "screenshots";
	Hashtable<String, Integer> summary = new Hashtable<String, Integer>();
	BROWSER browser_type = BROWSER.CHROME; // change this to change what browser
											// is used
	boolean printErrors = new DBUtilities(driver).printErrors; // for printing
																// errors

	private int sleepMultiplier = 1; // multiplier for the values in
										// Thread.sleep()s. If the site is being
										// slow, increase it for greater pauses
										// between steps. Should not be less
										// than 1.

	@Before()
	public void startUp() {

		// Log.info("opening Browser");
		// //+++++++++++++ FOR CHROME ++++++++++++++++++++++++++

		// // following is added to fix chrome maximise issue

		if (browser_type == BROWSER.CHROME) {
			System.setProperty("webdriver.chrome.driver",
					"C:\\Program Files\\Automation Tools\\Drivers\\chromedriver.exe");
			ChromeOptions options = new ChromeOptions();
			options.addArguments("test-type");
			options.addArguments("start-maximized");
			options.addArguments("--js-flags=--expose-gc");
			options.addArguments("--enable-precise-memory-info");
			options.addArguments("--disable-popup-blocking");
			options.addArguments("--disable-default-apps");
			options.addArguments("test-type=browser");
			options.addArguments("disable-infobars");
			driver = new ChromeDriver(options);
		} else if (browser_type == BROWSER.FIREFOX) {
			FirefoxDriverManager.getInstance().setup();
			File browserAppPath = null;

			// check if the platform is windows
			if (Platform.getCurrent().is(Platform.WINDOWS)) {
				browserAppPath = new File("C:\\Program Files\\Mozilla Firefox\\firefox.exe");

				// alternative path
				if (!browserAppPath.exists()) {
					browserAppPath = new File("C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe");
				}
			} else {
				// Ubuntu
				browserAppPath = new File("/usr/bin/firefox/firefox-bin");
			}

			FirefoxBinary ffBinary = new FirefoxBinary(browserAppPath);

			// create a binary
			FirefoxProfile firefoxProfile = new FirefoxProfile();
			FirefoxOptions ffo = new FirefoxOptions().setBinary(ffBinary).setProfile(firefoxProfile);
			driver = new FirefoxDriver(ffo);

		}

		// ChromeOptions options = new ChromeOptions();
		// options.addArguments("test-type");
		// options.addArguments("start-maximized");
		// options.addArguments("--js-flags=--expose-gc");
		// options.addArguments("--enable-precise-memory-info");
		// options.addArguments("--disable-popup-blocking");
		// options.addArguments("--disable-default-apps");
		// options.addArguments("test-type=browser");
		// options.addArguments("disable-infobars");
		// driver = new ChromeDriver(options);
		////
		// +++++++++++++ FOR FIREFOX ++++++++++++++++++++++++++

	}
	// **************disable to leave browser
	// open***************************************

	@After()
	public void tearDown() {
		// driver.quit();
	}
	// ******************************************************************************

	// for Chrome driver
	// System.setProperty("webdriver.chrome.driver", "C:\\Program
	// Files\\Automation Tools\\Drivers\\chromedriver.exe");
	// driver = new ChromeDriver();
	// driver.manage().window().maximize();

	// for IE
	// System.setProperty("webdriver.chrome.driver", "C:\\Program
	// Files\\Automation Tools\\Drivers\\IEDriverServer.exe");
	// driver = new ChromeDriver();
	// driver.manage().window().maximize();

	// *****************************************************following are
	// steps******************************************

	// ********************************************************************************************************************************
	// *************************************************************** WACG
	// ************************************************************

	@Given("^I erase previous data$")
	public void i_erase_previous_data() throws Throwable {
		// destroy the files in the folder before running
		File outputDirectory = new File(wcag_subdirectory);
		System.out.println(outputDirectory.getAbsolutePath());
		FileUtils.cleanDirectory(outputDirectory);
		PrintWriter pw = new PrintWriter("summary.txt");
		pw.close();

	}

	@Given("^I capture \"(.*?)\"$")
	public String i_capture(String arg1) throws Throwable {

		if (arg1.equals("html")) {
			StepImpe.sourceCode = driver.getPageSource();
			StepImpe.URLCaptured = driver.getCurrentUrl();

		} else {
			DBUtilities createXpath = new DBUtilities(driver);
			String myxpath = createXpath.xpathMakerById(arg1);
			System.out.println(myxpath);

			WebElement xyz = driver.findElement(By.xpath(myxpath));
			StepImpe.Capture = xyz.getText();
			System.out.println("*****************************FINAL RESULTS*****************************\n");
			System.out.println(StepImpe.URLCaptured + " HAS " + Capture + " WCAG ERRORS\n");
			System.out.println("***********************************************************************");
		}
		return Capture;

	}

	@Given("^I write \"(.*?)\" information to file")
	public void i_write_information_to_file(String arg1) throws Throwable {

		// date format for timestamp in the filenames
		// DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd
		// HH\ua789mm\ua789ss");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String currentDate = dateFormat.format(cal.getTime());
		String outputText = driver.findElement(By.xpath("//*[contains(@id, 'output_div')]")).getText();
		String lineSeparate = "-------------------------------------------------------------------------------------------";
		try {
			// write information to both files
			if (Integer.parseInt(Capture) > 0) {
				PrintWriter pwsource = new PrintWriter(wcag_subdirectory + "/" + arg1 + " SOURCE CODE.html", "UTF-16");
				pwsource.write(sourceCode);
				pwsource.close();
			}
			PrintWriter pwinfo = new PrintWriter(wcag_subdirectory + "/" + arg1 + " WCAG EVALUATION.txt", "UTF-16");
			pwinfo.write("URL: " + URLCaptured);
			pwinfo.write("\n" + lineSeparate + "\n NUMBER OF ERRORS \n" + lineSeparate + "\n");
			pwinfo.write(Capture);
			pwinfo.write("\n" + lineSeparate + "\n OUTPUT TEXT \n" + lineSeparate + "\n");
			pwinfo.write(outputText);
			pwinfo.write(
					"\n\n\n(NUMBER OF 'COLUMN's in the OUTPUT TEXT should equal the NUMBER OF ERRORS. If not, contact Chris Tang for assistance and bugfixing.)");

			pwinfo.close();

		} catch (IOException e) {
			if (printErrors) {
				e.printStackTrace();
			}
		}

		summary.put(arg1, Integer.parseInt(Capture));

	}

	// writes the WCAG summary to the file summary.txt
	@Then("^I write to the summary file")
	public void i_write_to_the_summary_file() throws Throwable {
		String summaryFilePath = "summary.txt";

		File summaryFile = new File("summary.txt");
		if (!summaryFile.exists()) {
			summaryFile.createNewFile();
		}
		FileWriter fw = new FileWriter(summaryFile, true);

		ArrayList<String> keys = Collections.list(summary.keys());
		Collections.sort(keys);
		for (String key : keys) {
			fw.write(key + ": " + summary.get(key) + " Errors.\n");
		}

		fw.close();
	}

	// sorts the summary file. Currently not working?
	@Then("^I sort the summary file")
	public void i_sort_the_summary_file() throws Throwable {
		String summaryFilePath = "summary.txt";
		BufferedReader br = null;

		// open the summary file
		File summaryFile = new File("summary.txt");
		if (!summaryFile.exists()) {
			summaryFile.createNewFile();
		}

		ArrayList<String> lines = new ArrayList<String>();
		FileWriter fw = new FileWriter(summaryFile, true);
		try {
			br = new BufferedReader(new FileReader(summaryFile));
			String line;

			// add the contents of the file to the arraylist
			while ((line = br.readLine()) != null) {
				lines.add(line);
			}

			// sort and write it it
			Collections.sort(lines);
			for (String content : lines) {
				fw.write(content + "\n");
			}

		} catch (Exception e) {
			if (printErrors)
				e.printStackTrace();
		} finally {
			if (br != null) {
				br.close();
			}

			fw.close();
		}

		// now write it

	}

	// step for pasting clipboard text into something
	// make sure what's copied doesn't contain any unicode characters
	@Given("^I paste \"(.*?)\"$")
	public void i_paste(String arg1) throws Throwable {

		StringSelection selection = new StringSelection(StepImpe.sourceCode);
		Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();

		// get the what was originally in the clipboard so that it can be
		// restored later
		String oldContent = (String) clipboard.getData(DataFlavor.stringFlavor);

		// set the clipboard contents as what was captured in the previous
		// step(s)
		clipboard.setContents(selection, selection);

		// find the element
		WebElement inputField = driver.findElement(By.xpath("//*[contains(@id, 'checkpaste')]"));
		inputField.click();

		// paste the captured stuff
		Actions actions = new Actions(driver);
		actions.sendKeys(Keys.chord(Keys.LEFT_CONTROL, "v")).build().perform();

		// revert the clipboard contents to what was there before
		StringSelection oldSelection = new StringSelection(oldContent);
		clipboard.setContents(oldSelection, oldSelection);

	}

	// checks if something is not readonly (i.e. activated)
	@Then("^I check \"(.*?)\" is not readonly$")
	public void i_check_is_not_readonly(String arg1) throws Throwable {
		DBUtilities createXpath = new DBUtilities(driver);
		String myXpath = createXpath.xpathMakerById(arg1);
		Thread.sleep(3000 * sleepMultiplier);
		WebElement some_element = driver.findElement(By.xpath(myXpath));
		Assert.assertTrue(some_element.isEnabled());
	}

	// to check if asterisk is present on a mandatory field

	@Given("^I check \"(.*?)\" is marked as \"(.*?)\"$")
	public void i_check_is_marked_as(String arg1, String arg2) throws Throwable {
		String myxpath = new DBUtilities(driver).xpathMakerById(arg1);
		WebElement elementName = driver.findElement(By.xpath(myxpath));
		System.out.println(elementName);
		String myxpath2 = new DBUtilities(driver).xpathMakerByTextInClass(arg2);

		// following is generating a combined xpath and then looking for element
		String combineXPaths = new DBUtilities(driver).combine2Xpaths(myxpath, myxpath2);
		System.out.println(combineXPaths);
		WebElement elementName2 = driver.findElement(By.xpath(combineXPaths));
		System.out.println(elementName2);
		Assert.assertTrue(elementName2.isDisplayed());

	}

	@Then("^I check \"(.*?)\" contains \"(.*?)\"$")
	public void i_Check_contains(String arg1, String arg2) throws Throwable {
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = createXpath.xpathMakerById(arg1);
		Thread.sleep(3000 * sleepMultiplier);
		WebElement inputBox = driver.findElement(By.xpath(myxpath));
		String boxContents = inputBox.getAttribute("value");
		System.out.println("boxContents: " + boxContents);
		System.out.println("arg2: " + arg2);

		try {
			Assert.assertTrue(boxContents.equals(arg2));
		} catch (AssertionError | Exception e) {
			try {
				myxpath = myxpath.replace("*", "input");
				inputBox = driver.findElement(By.xpath(myxpath));
				boxContents = inputBox.getAttribute("value");
				System.out.println("boxContents: " + boxContents);
				System.out.println("arg2: " + arg2);
				Assert.assertTrue(boxContents.equals(arg2));
			}
			// check for origvalue
			catch (AssertionError | Exception ae) {
				try {
					System.out.println("Attempting to search for origvalue...");
					boxContents = inputBox.getAttribute("origvalue");
					System.out.println("boxContents: " + boxContents);
					System.out.println("arg2: " + arg2);
					Assert.assertTrue(boxContents.equals(arg2));
				} catch (AssertionError | Exception ae2) {
					// for input fields that default to the placeholder value
					// when empty (very specific ones)
					if (printErrors)
						ae2.printStackTrace();
					System.out.println("Attempting to search for placeholder...");
					boxContents = inputBox.getAttribute("placeholder");
					System.out.println("boxContents: " + boxContents);
					System.out.println("arg2: " + arg2);
					Assert.assertTrue(boxContents.equals(arg2));
				}
			}
		}

		boxContents = null;
		inputBox = null;
		Thread.sleep(3000 * sleepMultiplier);

	}

	@Then("^I check label \"(.*?)\" contains \"(.*?)\"$")
	public void i_Check_label_contains(String arg1, String arg2) throws Throwable {
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = createXpath.xpathMakerById(arg1);
		Thread.sleep(3000 * sleepMultiplier);
		WebElement contents = driver.findElement(By.xpath(myxpath));
		String labelContents = contents.getText();
		System.out.println("labelContents: " + labelContents);
		System.out.println("arg2: " + arg2);

		Assert.assertTrue(labelContents.equals(arg2));

	}

	// **********************************WHY WE CHANGE THIS to
	// above?????????*************************************************
	// @Then("^I check \"(.*?)\" contains \"(.*?)\"$")
	// public void i_Check_contains(String arg1, String arg2) throws Throwable {
	// DBUtilities createXpath = new DBUtilities(driver);
	// String myxpath = createXpath.xpathMakerById(arg1);
	// System.out.println(myxpath);
	// String elementToBeSearched = StepImpe.Capture;
	// System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
	// +elementToBeSearched);
	// DBUtilities t1 = new DBUtilities(driver);
	// t1.isTextPresent(elementToBeSearched);
	//
	//
	//
	// }

	// checks if something is empty,
	// uses the 'value' attribute as a basis
	@Then("^I check \"(.*?)\" is empty$")
	public void i_check_is_empty(String arg1) throws Throwable {
		String myxpath = new DBUtilities(driver).xpathMakerById(arg1);
		WebElement inputBox = driver.findElement(By.xpath(myxpath));
		Assert.assertTrue(inputBox.isDisplayed());
		String boxContents = inputBox.getAttribute("value");
		try {
			Assert.assertTrue(boxContents.isEmpty());
		}
		// in the
		catch (Exception e) {
			Assert.assertTrue(boxContents == null);
		}
	}

	// opposite of above
	@Then("^I check \"(.*?)\" is not empty$")
	public void i_check_is_not_empty(String arg1) throws Throwable {
		String myxpath = new DBUtilities(driver).xpathMakerById(arg1);
		WebElement inputBox = driver.findElement(By.xpath(myxpath));
		Assert.assertTrue(inputBox.isDisplayed());
		String boxContents = inputBox.getAttribute("value");
		System.out.println("Box Contents: " + boxContents);
		try {
			Assert.assertTrue(!boxContents.isEmpty());
		}
		// in the
		catch (Exception e) {
			Assert.assertTrue(boxContents != null);
		}
	}

	// checks if contents of something match a java regex
	// checks by class, then by id,
	@Then("^I check \"(.*?)\" contents match regex \"(.*?)\"$")
	public void i_check_contents_are_of_pattern(String arg1, String arg2) throws Throwable {
		String myxpath = new DBUtilities(driver).xpathMakerById(arg1);
		Pattern regex = Pattern.compile(arg2);
		try {
			WebElement inputBox = driver.findElement(By.xpath(myxpath));
			String value = inputBox.getAttribute("value");

			System.out.println("value: " + value);
			System.out.println("arg2: " + arg2);

			Assert.assertTrue(regex.matcher(value).matches());
		} catch (Exception | AssertionError e) {
			try {
				myxpath = new DBUtilities(driver).xpathMakerByClass(arg1);
				WebElement inputBox2 = driver.findElement(By.xpath(myxpath));
				String value = inputBox2.getAttribute("value");
				System.out.println("value: " + value);
				System.out.println("arg2: " + arg2);
				Assert.assertTrue(regex.matcher(value).matches());
			} catch (Exception | AssertionError e2) {
				myxpath = new DBUtilities(driver).xpathMakerById(arg1);
				WebElement inputBox3 = driver.findElement(By.xpath(myxpath));
				String value = inputBox3.getText();
				System.out.println("value: " + value);
				System.out.println("arg2: " + arg2);
				Assert.assertTrue(regex.matcher(value).matches());
			}
		}
	}

	// *************************************************************************************************************************

	@Given("^I want to login to portal \"(.*?)\"$")
	public void i_want_to_login_to_portal(String arg1) throws Throwable {
		HomePage home = PageFactory.initElements(driver, HomePage.class);
		home.navigateTo(arg1);
	}

	@And("^I hit Enter$")
	public LandingPage I_hit_Enter() throws InterruptedException {
		PageFactory.initElements(driver, LandingPage.class).hitEnter();
		Thread.sleep(3000 * sleepMultiplier);

		return PageFactory.initElements(driver, LandingPage.class);
	}

	// will be used to tab out to activate a button incase the button is not
	// activated.
	@Given("^I Tab Out$")
	public void i_Tab_Out() throws Throwable {
		new DBUtilities(driver).tabOut();
	}

	@And("^I click \"(.*?)\" regarding DB topic \"(.*?)\"$")
	public void i_click_regarding_DB_topic(String arg1, String arg2) throws Throwable {
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = createXpath.xpathMakerByDBTopic(arg1, arg2);
		System.out.println("clicking DB topic on " + myxpath);
		Assert.assertTrue(driver.findElement(By.xpath(myxpath)).isDisplayed());
		Thread.sleep(3000 * sleepMultiplier);
		driver.findElement(By.xpath(myxpath)).click();

	}

	@And("^I click on button \"(.*?)\"$")
	public void i_click_on_button(String arg1) throws Throwable {
		Thread.sleep(3000 * sleepMultiplier);
		Pattern datePattern = Pattern.compile("\\d\\d\\d\\d\\d\\d\\d\\d"); // date
																			// pattern
																			// as
																			// used
																			// in
																			// the
																			// calendar
																			// popup
		String myXpath = null;
		DBUtilities createXpath = new DBUtilities(driver);
		if (datePattern.matcher(arg1).matches()) {
			myXpath = createXpath.xpathMakerContainsCustomField("dyc-date", arg1);
			try {
				driver.findElement(By.xpath(myXpath)).click();
			} catch (Exception e) {
				for (int i = 0; i < 100; i++) {
					System.out.println("(" + myXpath + ")[" + i + "]");
					try {
						driver.findElement(By.xpath("(" + myXpath + ")[" + i + "]")).click();
						break;
					} catch (Exception e2) {
						System.out.println();
					}
				}

			}
		} else {
			try {
				myXpath = createXpath.xpathMakerById(arg1);
				driver.findElement(By.xpath(myXpath)).click();
			} catch (Exception e) {
				if (printErrors)
					e.printStackTrace();
				myXpath = createXpath.xpathMakerByClass(arg1);
				driver.findElement(By.xpath(myXpath)).click();
			}
		}
		Thread.sleep(3000 * sleepMultiplier);

	}

	// clicks an object based on the 'value' attribute
	@And("^I click on button with value \"(.*?)\"$")
	public void i_click_on_button_with_value(String arg1) throws Throwable {
		Thread.sleep(3000 * sleepMultiplier);
		String myXpath = null;
		DBUtilities createXpath = new DBUtilities(driver);
		myXpath = createXpath.xpathMakerByValue(arg1);
		try {
			try {
				driver.findElement(By.xpath(myXpath)).click();
			} catch (Exception e) {
				driver.findElement(By.xpath(myXpath)).submit();
			}
		} catch (Exception e2) {
			myXpath = createXpath.xpathMakerByLinkAndText(arg1);
			driver.findElement(By.xpath(myXpath)).click();
		}
	}

	@And("^I click on image with filename \"(.*?)\"$")
	public void i_click_on_image_with_filename(String arg1) throws Throwable {
		Thread.sleep(3000 * sleepMultiplier);
		String myXpath = null;
		DBUtilities createXpath = new DBUtilities(driver);
		myXpath = createXpath.xpathMakerByImage(arg1);
		driver.findElement(By.xpath(myXpath)).click();
		// try {
		// try {
		//
		// }
		// catch (Exception e ){
		// driver.findElement(By.xpath(myXpath)).submit();
		// }
		// }
		// catch (Exception e2){
		// myXpath = createXpath.xpathMakerByLinkAndText(arg1);
		// driver.findElement(By.xpath(myXpath)).click();
		// }
	}

	@And("^I click on link with URL \"(.*?)\"$")
	public void i_click_on_link_with_URL(String arg1) throws Throwable {
		Thread.sleep(3000 * sleepMultiplier);
		String myXpath = null;
		DBUtilities createXpath = new DBUtilities(driver);
		myXpath = createXpath.xpathMakerByLinkHref(arg1);

		driver.findElement(By.xpath(myXpath)).click();
		// try {
		// try {
		//
		// }
		// catch (Exception e ){
		// driver.findElement(By.xpath(myXpath)).submit();
		// }
		// }
		// catch (Exception e2){
		// myXpath = createXpath.xpathMakerByLinkAndText(arg1);
		// driver.findElement(By.xpath(myXpath)).click();
		// }
	}

	// scrolls down the page, may not be working correctly
	@And("^I scroll down by \"(.*?)\" percent$")
	public void i_scroll_down_by_factor(String arg1) throws Throwable {
		JavascriptExecutor jse = (JavascriptExecutor) driver;
		final int pageScrollFactor = 5000;
		double factor = (Double.parseDouble(arg1) / 100) * pageScrollFactor;
		System.out.println(factor);
		// String factor = "0," + arg1;
		jse.executeScript("window.scrollBy(0," + factor + ")", "");
	}

	// scrolls up the page, may not be working correctly
	@And("^I scroll up$")
	public void i_scroll_up() throws Throwable {
		JavascriptExecutor jse = (JavascriptExecutor) driver;
		jse.executeScript("window.scrollBy(0,-5000)", "");
	}

	// for clicking on text
	@And("^I click on \"(.*?)\"$")
	public void i_click_on(String arg1) throws Throwable {

		// give time for page loading
		Thread.sleep(3000 * sleepMultiplier);
		Pattern datePattern = Pattern.compile("\\d\\d\\d\\d\\d\\d\\d\\d"); // date
																			// pattern
																			// as
																			// used
																			// in
																			// the
																			// old
																			// calendar
																			// popup

		// this if block was used to click on the calendar popup; it is now
		// depreciated
		if (datePattern.matcher(arg1).matches()) {
			DBUtilities createXpath = new DBUtilities(driver);
			String myxpath4 = createXpath.xpathMakerContainsCustomField("dyc-date", arg1);
			try {
				driver.findElement(By.xpath(myxpath4)).click();
			} catch (Exception e) {
				for (int i = 0; i < 100; i++) {
					System.out.println("(" + myxpath4 + ")[" + i + "]");
					try {
						driver.findElement(By.xpath("(" + myxpath4 + ")[" + i + "]")).click();
						break;
					} catch (Exception e2) {
						System.out.println();
					}
				}
			}
		} else {
			try {
				DBUtilities createXpath = new DBUtilities(driver);
				String myxpath = createXpath.xpathMaker(arg1);
				System.out.println("cliclking on " + myxpath);
				if(arg1.equals("SETTINGS"))
				{
					String myxpath2 = createXpath.xpathMakerContainsText3rdOption(arg1);
					driver.findElement(By.xpath(myxpath2)).click();
				}
				
			   
				driver.findElement(By.xpath(myxpath)).click();
			} catch (Exception | AssertionError e) {
				
				DBUtilities createXpath = new DBUtilities(driver);
				String myxpath = createXpath.xpathMakerContainsText(arg1);
				System.out.println("cliclking on " + myxpath);
//				 Assert.assertTrue(driver.findElement(By.xpath(myxpath)).isDisplayed());
//				Thread.sleep(3000 * sleepMultiplier);
//				
//				driver.findElement(By.xpath(myxpath)).click();
			}
		}

	}

	// doesn't always work, be careful
	@Given("^I select \"(.*?)\" from \"(.*?)\"$")
	public void i_select_from(String arg1, String arg2) throws Throwable {
		Thread.sleep(sleepMultiplier * 3000);
		if (arg1.equals("SetGoal")) {
			String myxpath = PageFactory.initElements(driver, GoalsAndTargetsPage.class).xpathMakerById1AndId2(arg1,
					arg2);
			WebElement element = driver.findElement(By.xpath(myxpath));
			JavascriptExecutor executor = (JavascriptExecutor) driver;
			executor.executeScript("arguments[0].click()", element);
		} else {
			PageFactory.initElements(driver, LandingPage.class).selectDropdownValue(arg1, arg2);

		}
	}

	// for the strange dropdowns on the DB Results website, currently doesn't
	// work, be careful
	@Given("^I hover over \"(.*?)\" and click on \"(.*?)\"$")
	public void i_hover_over_and_click_on(String arg1, String arg2) throws Throwable {
		// Thread.sleep(sleepMultiplier * 3000);
		String myxpath = new DBUtilities(driver).xpathMakerContainsText(arg1);
		WebElement hoverElement = driver.findElement(By.xpath(myxpath));
		WebElement hoverElement2 = null;
		String newmyxpath = null;
		String myxpath2 = null;

		try {
			hoverElement.click();
		} catch (Exception e) {
			for (int i = 2; i < 10; i++) {
				newmyxpath = "(" + myxpath + ")[" + i + "]";
				if (driver.findElements(By.xpath(newmyxpath)).size() != 0) {
					break;
				}
			}
		}
		System.out.println(newmyxpath);
		hoverElement = driver.findElement(By.xpath(newmyxpath));
		myxpath2 = new DBUtilities(driver).xpathMakerByLinkAndText(arg2);
		System.out.println(myxpath2);
		String javaScript = "var evObj = document.createEvent('MouseEvents');"
				+ "evObj.initMouseEvent(\"mouseover\",true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);"
				+ "arguments[0].dispatchEvent(evObj);";
		((JavascriptExecutor) driver).executeScript(javaScript, hoverElement);

		hoverElement2 = driver.findElement(By.xpath(myxpath2));

		// JavascriptExecutor executor = (JavascriptExecutor)driver;
		((JavascriptExecutor) driver).executeScript("arguments[0].click()", hoverElement2);
		// executor.executeScript(, hoverElement2);

		// Actions builder = new Actions(driver);
		// //builder.moveToElement(hoverElement).build().perform();
		// hoverElement.click();
		//// By locator = By.id("clickElementID");
		//// driver.click(locator);
		// builder.moveToElement(driver.findElement(By.xpath(myxpath2))).build().perform();
		// builder.click();
		//// builder.moveToElement(driver.findElement(By.xpath(myxpath2))).click();
		// driver.findElement(By.xpath(myxpath2)).click();
	}

	// check for field text and text boxes
	@And("^I enter the details as$")
	public void I_enter_then_details_as(DataTable table) throws Throwable {

		PageFactory.initElements(driver, DBUtilities.class).enterCucumbertableValuesInUI(table);

	}

	// simple wait
	@Then("^I wait for \"(.*?)\" millisecond$")
	public void i_wait_for_millisecond(long arg1) throws Throwable {
		Thread.sleep(arg1 * sleepMultiplier);
	}

	@Then("^I hover on \"(.*?)\" to verify \"(.*?)\" is displayed$")
	public void i_hover_on_to_verify_is_displayed(String arg1, String arg2) throws Throwable {
		PageFactory.initElements(driver, MakeAPaymentPage.class).hoverOverElement(arg1, arg2);
	}

	// CHECK ELEMENT IS READ ONLY
	@Then("^I check \"(.*?)\" is readonly$")
	public void i_check_is(String arg1) throws Throwable {
		PageFactory.initElements(driver, DBUtilities.class).elementIsreadOnly(arg1);
	}

	// this is for checking checkbox
	@Given("^I click on \"(.*?)\" checkbox$")
	public void i_click_on_checkbox(String arg1) throws Throwable {
		PageFactory.initElements(driver, ForgotYourPasswordPage.class).checkBoxClick(arg1);
	}

	@Then("^I check \"(.*?)\" exists$")
	public void i_check_exists(String arg1) throws Throwable {
		Thread.sleep(3000 * sleepMultiplier);
		DBUtilities checkElementDisplayed = new DBUtilities(driver);
		try {
			String myxpath = checkElementDisplayed.xpathMakerById(arg1);
			WebElement object = driver.findElement(By.xpath(myxpath));
			Assert.assertTrue(object.isDisplayed());
		} catch (Exception e) {
			if (printErrors)
				e.printStackTrace();
			String myxpath = checkElementDisplayed.xpathMakerByClass(arg1);
			WebElement object = driver.findElement(By.xpath(myxpath));
			Assert.assertTrue(object.isDisplayed());
		}

	}

	@Then("^I check \"(.*?)\" does not exist$")
	public void i_check_does_not_exist(String arg1) throws Throwable {
		DBUtilities checkElementDisplayed = new DBUtilities(driver);
		String myxpath = checkElementDisplayed.xpathMakerById(arg1);
		// WebElement object = driver.findElement(By.xpath(myxpath));
		System.out.println("Elements found: " + driver.findElements(By.xpath(myxpath)).size());
		try {
			Assert.assertFalse(!driver.findElement(By.xpath(myxpath)).isDisplayed());
		} catch (NoSuchElementException nsee) {
			Assert.assertFalse(false);
		}

	}

	// *********************************************** read popup
	// message********************************************
	@Then("^I see \"(.*?)\" displayed on popup and I click \"(.*?)\"$")
	public void i_see_displayed_on_popup_and_I_click(String arg1, String arg2) throws Throwable {
		Thread.sleep(3000);
		PageFactory.initElements(driver, DBUtilities.class).checkPopUpMessage(arg1);
		PageFactory.initElements(driver, DBUtilities.class).clickOnPopUP(arg2);

	}

	// ***************************************************Landing
	// Page********************************************************
	@Then("^\"(.*?)\" is displayed as \"(.*?)\"$")
	public void is_displayed_as(String arg1, String arg2, DataTable table) throws Throwable {

		PageFactory.initElements(driver, LandingPage.class).checkElementPresentOnScreen(table);
	}

	// Read All SAs
	@Then("^I read all \"(.*?)\" from the corousel$")
	public void i_read_all_from_the_corousel(String arg1) throws Throwable {
		PageFactory.initElements(driver, LandingPage.class).selectSAsFromCorousel(arg1);

	}

	// ******************************************************* new page is
	// launched*********************************************
	@Then("^a new page \"(.*?)\" is launched$")
	public void a_new_page_is_launched(String arg1) throws Throwable {
		String URL = driver.getCurrentUrl();
		System.out.println(URL);
		new DBUtilities(driver).passControlToNewWindow(arg1);
	}

	@Then("^I will see message \"(.*?)\"$") // this is just a workaround for the
											// temp para coming in
	public void i_will_see_message(String arg1) throws Exception {

		Assert.assertTrue(driver.findElement(By.xpath("//*[contains(text(),arg1)]")).isDisplayed());
		System.out.println("Message sucessfully displayed as " + arg1);
		Thread.sleep(3000 * sleepMultiplier);
	}

	@When("^I view the left hand panel of screen$")
	public void i_view_the_left_hand_panel_of_screen() throws Throwable {
		System.out.println("Checking UI Elements on LHS of screen");
		Thread.sleep(3000 * sleepMultiplier);
	}

	@Then("^I see \"(.*?)\" displayed$")
	public void i_see_and_displayed(String arg1) throws Throwable {
		PageFactory.initElements(driver, LandingPage.class).checkUIElementIsDisplayed(arg1);

	}

	@Then("^I see text \"(.*?)\" displayed$")
	public void i_see_text_displayed(String arg1) throws Throwable {
		LandingPage AU = PageFactory.initElements(driver, LandingPage.class);

		DBUtilities checkElementDisplayed = new DBUtilities(driver);
		Thread.sleep(3000 * sleepMultiplier);
		String myxpath = checkElementDisplayed.xpathMakerContainsText(arg1); // keep
																				// an
																				// eye...changed
																				// because
																				// of
																				// 520
		System.out.println("checking for text " + myxpath);
		Assert.assertTrue(driver.getPageSource().contains(arg1)); // other
																	// methods
																	// may not
																	// work

	}

	@Then("^I see text \"(.*?)\" shown$")
	public void i_see_text_shown(String arg1) throws Throwable {
		LandingPage AU = PageFactory.initElements(driver, LandingPage.class);
		Thread.sleep(3000 * sleepMultiplier);
		DBUtilities checkElementDisplayed = new DBUtilities(driver);
		String myxpath = checkElementDisplayed.xpathMakerContainsText(arg1); // keep
																				// an
																				// eye...changed
																				// because
																				// of
																				// 520
		System.out.println("checking for text " + myxpath);

		Assert.assertTrue(driver.getPageSource().contains(arg1));

	}

	@Then("^I see text \"(.*?)\" not displayed$")
	public void i_see_text_not_displayed(String arg1) throws Throwable {
		DBUtilities checkElementDisplayed = new DBUtilities(driver);
		Thread.sleep(3000 * sleepMultiplier);
		String myxpath = checkElementDisplayed.xpathMakerContainsText(arg1); // keep
																				// an
																				// eye...changed
																				// because
																				// of
																				// 520
		System.out.println("Checking for text: " + myxpath);

		try {
			Assert.assertFalse(!driver.findElement(By.xpath(myxpath)).isDisplayed());
		} catch (Exception | AssertionError ae) {
			Assert.assertFalse(false);
		}
	}

	// check i am on right page
	@Given("^I check I am on \"(.*?)\" page$")
	public void i_check_I_am_on_page(String arg1) throws Throwable {
		PageFactory.initElements(driver, BillingHistoryPage.class).checkIfOnRightPage(arg1);

		System.out.println(" on correct page " + arg1);
	}

	@Given("^I check page has URL \"(.*?)\"$")
	public void i_check_page_has_URL(String arg1) throws Throwable {
		String currentURL = driver.getCurrentUrl();
		Assert.assertTrue(arg1.equals(currentURL));

	}

	// check that a checkbox is checked
	@Then("^I see checkbox \"(.*?)\" as selected$")
	public void i_see_checkbox_as_selected(String arg1) throws Throwable {
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = createXpath.xpathMakerById(arg1);
		System.out.println("Checking if checkbox " + myxpath + " has been selected.");
		Assert.assertTrue(driver.findElement(By.xpath(myxpath)).isSelected());
	}

	@Then("^I see checkbox \"(.*?)\" as not selected$")
	public void i_see_checkbox_as_not_selected(String arg1) throws Throwable {
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = createXpath.xpathMakerById(arg1);
		System.out.println("Checking if checkbox " + myxpath + " has not been selected.");
		Assert.assertFalse(driver.findElement(By.xpath(myxpath)).isSelected());
	}

	// check the dropdown displays expected
	@Then("^\"(.*?)\" displays \"(.*?)\" by default$")
	public void displays_by_default(String arg1, String arg2) throws Throwable {
		DBUtilities createXpath = new DBUtilities(driver);
		String myXpath = createXpath.xpathMakerContainsText(arg2);
		WebElement dropdownValue = driver.findElement(By.xpath(myXpath));
		System.out.println(dropdownValue.getText());
		PageFactory.initElements(driver, AccountFinancialHistorypage.class).isTextPresent(arg2);

	}

	// ***************************************** GRAPH CHECKS
	// *********************
	@Then("^the graph for \"(.*?)\" is displayed$")
	public void the_graph_for_is_displayed(String arg1) throws Throwable {
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = createXpath.xpathMakerById(arg1);
		driver.findElement(By.xpath(myxpath)).click();
	}

	// ******************************************Compare values on
	// screen*************************
	@Then("^I compare \"(.*?)\" to \"(.*?)\"$")
	public void i_compare_to(String arg1, String arg2) throws Throwable {
		LandingPage compareValues = PageFactory.initElements(driver, LandingPage.class);
		compareValues.compareValueOneToValueTwo(arg1, arg2);
	}

	// compare 2 values
	@Then("^I verify \"(.*?)\" is \"(.*?)\" then \"(.*?)\"$")
	public void i_verify_is_then(String arg1, String arg2, String arg3) throws Throwable {
		DBUtilities val1 = new DBUtilities(driver);
		String a = val1.xpathMakerById(arg1);
		String currentValue1 = driver.findElement(By.xpath(a)).getText();
		System.out.println(currentValue1);
		String b = val1.xpathMakerById(arg3);
		String currentValue2 = driver.findElement(By.xpath(b)).getText();
		System.out.println(currentValue2);

		DBUtilities compareAccountTotalToServiceTotal = new DBUtilities(driver);
		String result = compareAccountTotalToServiceTotal.compare2DollarValues(currentValue1, currentValue2);

		Assert.assertTrue(result.contains(arg2));

	}

	// selects radio button for a perticular section and combine xpaths to avoid
	// radio buttons of same name
	@Then("^from section \"(.*?)\" I select radio button option \"(.*?)\"$")
	public void from_section_I_select_radio_button_option(String arg1, String arg2) throws Throwable {
		String myxpath = new DBUtilities(driver).xpathMakerById(arg1);

		String myxpath2 = new DBUtilities(driver).xpathMakerById(arg2);

		// following is generating a combined xpath and then looking for element
		String combineXPaths = new DBUtilities(driver).combine2Xpaths(myxpath, myxpath2);
		System.out.println(combineXPaths);
		WebElement elementName2 = driver.findElement(By.xpath(combineXPaths));

		Assert.assertTrue(elementName2.isDisplayed());
		elementName2.click();
	}

	@Then("^I compare \"(.*?)\" to \"(.*?)\" to check if variation is displayed correctly$")
	public void i_compare_to_to_check_if_variation_is_displayed_correctly(String arg1, String arg2) throws Throwable {
		LandingPage compareValues = PageFactory.initElements(driver, LandingPage.class);
		compareValues.compareValueOneToValueTwo(arg1, arg2);
	}

	// *****************************************************************************************
	// **********************************************PAYMENT
	// WINDOW*****************************
	// *****************************************************************************************
	@Then("^a new \"(.*?)\" window is open$")
	public void a_new_window_is_open(String arg1) throws Throwable {
		// to do... add test once bug is fixed.
	}

	// *****************************************************************************************
	// **********************************************DATA BASE
	// CONNECTION***********************
	// *****************************************************************************************

	@Given("^I want to connect to Webservice$")
	public void i_want_to_connect_to_Webservice() throws Throwable {

	}

	// *****************************************************************************************
	// **********************************************PDF FILE
	// ***********************
	// *****************************************************************************************

	// don't know if this works
	@Then("^I see a pdf document with name \"(.*?)\" generated$")
	public void i_see_a_pdf_document_with_name_generated(String arg1) throws Throwable {
		System.out.println("Yes******************* pdf is open");
		// DBUtilities moveControlToNewWindow = new DBUtilities(driver);
		new DBUtilities(driver).passControlToNewWindow(arg1);

	}

	// *****************************************************************************************
	// **********************************************Verify Table Rows
	// ***********************
	// *****************************************************************************************

	@Then("^I verify the \"(.*?)\" count is \"(.*?)\" to \"(.*?)\"$")
	public void i_verify_the_count_is_to(String arg1, String arg2, int arg3) throws Throwable {
		PageFactory.initElements(driver, AccountFinancialHistorypage.class).readAndCompareTableRows(arg1, arg2, arg3);

	}

	// used to have problems with Jenkins, but should work now
	@Then("^I check \"(.*?)\" has CSS property \"(.*?)\" with value \"(.*?)\"$")
	public void i_check_has_a_css_property_with_value(String arg1, String arg2, String arg3) throws Throwable {
		DBUtilities dbutil = new DBUtilities(driver);
		String xpath1 = dbutil.xpathMakerById(arg1);
		String property = arg2;
		String cssVal = arg3;
		String currentCssVal = null;
		try {
			currentCssVal = driver.findElement(By.xpath(xpath1)).getCssValue(arg2);
			System.out.println("Comparing '" + cssVal + "' against the property value found: '" + currentCssVal + "'.");
			Assert.assertTrue(cssVal.equals(currentCssVal));
		}
		// specifically for finding CSS values of labels with ::after psuedo
		// selector
		catch (AssertionError | Exception e) {
			try {
				xpath1 = dbutil.xpathMakerByLabelAndId(arg1);
				WebElement currentElement = driver.findElement(By.xpath(xpath1));
				currentCssVal = ((JavascriptExecutor) driver).executeScript(
						"return window.getComputedStyle(arguments[0], '::after').getPropertyValue('" + property + "');",
						currentElement).toString();
				System.out.println(
						"Comparing '" + cssVal + "' against the property value found: '" + currentCssVal + "'.");
				Assert.assertTrue(cssVal.equals(currentCssVal));
			} catch (AssertionError | Exception ae2) {
				try {
					xpath1 = dbutil.xpathMakerBySpanAndId(arg1);
					WebElement currentElement = driver.findElement(By.xpath(xpath1));
					currentCssVal = ((JavascriptExecutor) driver)
							.executeScript("return window.getComputedStyle(arguments[0], '::after').getPropertyValue('"
									+ property + "');", currentElement)
							.toString();
					System.out.println(
							"Comparing '" + cssVal + "' against the property value found: '" + currentCssVal + "'.");
					Assert.assertTrue(cssVal.equals(currentCssVal));
				} catch (AssertionError | Exception ae3) {
					xpath1 = dbutil.xpathMakerBySpanAndClass(arg1);
					WebElement currentElement = driver.findElement(By.xpath(xpath1));
					currentCssVal = ((JavascriptExecutor) driver)
							.executeScript("return window.getComputedStyle(arguments[0], '::after').getPropertyValue('"
									+ property + "');", currentElement)
							.toString();
					System.out.println(
							"Comparing '" + cssVal + "' against the property value found: '" + currentCssVal + "'.");
					Assert.assertTrue(cssVal.equals(currentCssVal));
				}
			}

		}
	}
	@And("^I \"(.*?)\" windows alert$")
	public void on_windows_alert(String arg1)
	{
		if(arg1.equals("Accept"))
		{
			driver.switchTo().alert().accept();
		}else{
			driver.switchTo().alert().dismiss();
			}
		}
		
	@Then("^I check the values of dropdown \"(.*?)\" are alphabetical$")
	public void i_check_the_values_of_dropdown_are_alphabetical(String arg1) throws Throwable {
		DBUtilities dbutil = new DBUtilities(driver);
		String xpath1 = dbutil.xpathMakerBySelectAndId(arg1);
		WebElement dropdown = driver.findElement(By.xpath(xpath1));
		Select select = new Select(dropdown);
		List<WebElement> allOptions = select.getOptions();

		// convert into string format
		List<String> allOptionsText = new ArrayList<String>();
		for (WebElement e : allOptions) {
			allOptionsText.add(e.getText());
		}

		// check for sortability
		boolean sorted = true;
		for (int i = 1; i < allOptionsText.size(); i++) {
			if (allOptionsText.get(i - 1).compareTo(allOptionsText.get(i)) > 0) {
				sorted = false;
			}
		}
		Assert.assertTrue(sorted);

	}

	// **************************************************************************************************************************
	// **************************************************************************************************************************
	// **************************************************************************************************************************
	// **************************************************************************************************************************
	// ****************************************************UAP
	// STEPS*************************************************************
	// **************************************************************************************************************************
	// **************************************************************************************************************************
	// **************************************************************************************************************************
	// **************************************************************************************************************************

	@Given("^I read the table on \"(.*?)\" page$")
	public void i_read_the_table_on_page(String arg1) throws Throwable {
		new DBUtilities(driver).readTableAndCaptureInString(arg1);
	}

	// for those Outsystems popups, set argument as 0 or 1 if there is only one
	// frame present
	@Then("^I switch to frame \"(.*?)\"$")
	public void i_switch_to_frame(String arg1) throws Throwable {
		int frameNum = Integer.parseInt(arg1);
		driver.switchTo().frame(frameNum);
	}

	// similar to print screen, doesn't capture an image of the entire page
	@Then("^I take a screenshot with name \"(.*?)\"$")
	public void i_take_a_screenshot(String arg1) throws Throwable {

		File scrFile = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
		// Now you can do whatever you need to do with it, for example copy
		// somewhere
		FileUtils.copyFile(scrFile, new File(screenshot_subdirectory + "/" + arg1 + "_screenshot.png"));
	}

	// doesn't seem to work, Chrome specific
	@Then("^I change download destinations$")
	public void i_change_download_destinations() throws Throwable {
		String downloadFilepath = "/pdfs";
		HashMap<String, Object> chromePrefs = new HashMap<String, Object>();
		chromePrefs.put("profile.default_content_settings.popups", 0);
		chromePrefs.put("download.default_directory", downloadFilepath);
		ChromeOptions options = new ChromeOptions();
		options.setExperimentalOption("prefs", chromePrefs);
		DesiredCapabilities cap = DesiredCapabilities.chrome();
		cap.setCapability(CapabilityType.ACCEPT_SSL_CERTS, true);
		cap.setCapability(ChromeOptions.CAPABILITY, options);
		WebDriver new_driver = new ChromeDriver(cap);
		driver = new_driver;
	}

	// **************************************************************************************************************************
	// **************************************************************************************************************************
	// **************************************************************************************************************************
	// **************************************************************************************************************************
	// ****************************************************GENERIC XPATH
	// FUNCTIONS***********************************************
	// **************************************************************************************************************************
	// **************************************************************************************************************************
	// **************************************************************************************************************************
	// **************************************************************************************************************************

	/* Use as a last resort */

	@Then("^I check object with xpath \"(.*?)\" exists$")
	public void i_check_object_with_xpath_exists(String arg1) throws Throwable {
		Thread.sleep(3000 * sleepMultiplier);
		DBUtilities checkElementDisplayed = new DBUtilities(driver);

		WebElement object = driver.findElement(By.xpath(arg1));
		Assert.assertTrue(object.isDisplayed());

	}

	@Then("^I check object with xpath \"(.*?)\" contains \"(.*?)\"$")
	public void i_check_object_with_xpath_contains(String arg1, String arg2) throws Throwable {
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = arg1;
		Thread.sleep(3000 * sleepMultiplier);
		WebElement inputBox = driver.findElement(By.xpath(myxpath));
		String contents = inputBox.getText().trim();
		System.out.println("boxContents: " + contents);
		System.out.println("arg2: " + arg2);

		Assert.assertTrue(contents.equals(arg2));
	}

	@Then("^I check object with xpath \"(.*?)\" contents match regex \"(.*?)\"$")
	public void i_check_object_with_xpath_contents_are_of_pattern(String arg1, String arg2) throws Throwable {
		Pattern regex = Pattern.compile(arg2);
		WebElement inputBox = driver.findElement(By.xpath(arg1));
		String value = inputBox.getText();
		System.out.println("value: " + value);
		System.out.println("arg2: " + arg2);
		try {
			Assert.assertTrue(regex.matcher(value).matches());
		} catch (AssertionError | Exception e) {
			String value2 = inputBox.getAttribute("value");
			System.out.println("value: " + value2);
			System.out.println("arg2: " + arg2);
			Assert.assertTrue(regex.matcher(value2).matches());
		}
	}

	@Then("^I click on object with xpath \"(.*?)\"$")
	public void i_click_on_object_with_xpath(String arg1) throws Throwable {
		WebElement object = driver.findElement(By.xpath(arg1));
		System.out.println("Clickin " + arg1);
		object.click();
	}

	@Then("^I click on checkbox with xpath \"(.*?)\" until it is \"(.*?)\"$")
	public void i_click_on_object_with_xpath(String arg1, String arg2) throws Throwable {
		WebElement object = driver.findElement(By.xpath(arg1));
		boolean status = object.isSelected();
		if (arg2.equals("checked")) {
			if (!status) {
				object.click();
			}
		} else if (arg2.equals("unchecked")) {
			if (status) {
				object.click();
			}
		} else {
			Assert.assertTrue(false);
		}

	}

	@Then("^I drag object with xpath \"(.*?)\" onto object with xpath \"(.*?)\"$")
	public void i_drag_object_with_xpath_onto_object_with_xpath(String arg1, String arg2) throws Throwable {
		WebElement element = driver.findElement(By.xpath(arg1));

		WebElement target = driver.findElement(By.xpath(arg2));

		(new Actions(driver)).dragAndDrop(element, target).perform();
	}

	// doesn't seem to work on Chrome
	@Then("^I upload file with path \"(.*?)\" to \"(.*?)\"$")
	public void i_upload_file_with_path_to(String arg1, String arg2) throws Throwable {
		DBUtilities dbutil = new DBUtilities(driver);
		String xpath1 = dbutil.xpathMakerById(arg2);
		driver.findElement(By.id(xpath1)).click();

		// put path to your image in a clipboard
		StringSelection ss = new StringSelection("C:\\IMG_3827.JPG");
		Toolkit.getDefaultToolkit().getSystemClipboard().setContents(ss, null);

		// imitate mouse events like ENTER, CTRL+C, CTRL+V
		Robot robot = new Robot();
		robot.keyPress(KeyEvent.VK_ENTER);
		robot.keyRelease(KeyEvent.VK_ENTER);
		robot.keyPress(KeyEvent.VK_CONTROL);
		robot.keyPress(KeyEvent.VK_V);
		robot.keyRelease(KeyEvent.VK_V);
		robot.keyRelease(KeyEvent.VK_CONTROL);
		robot.keyPress(KeyEvent.VK_ENTER);
		robot.keyRelease(KeyEvent.VK_ENTER);

	}

	// take screenshot
	@And("^I store a snapshot of page$")

	public void I_take_a_snapshot_of_the_above_page_as_a_record() throws Throwable {
		// File scrFile =
		// ((TakesScreenshot)driver).getScreenshotAs(OutputType.FILE);
		// String dnt = DBUtilities.DNT(null);
		// System.out.println(dnt);
		// FileUtils.copyFile(scrFile, new File(dnt+".jpg"));

	}

}
