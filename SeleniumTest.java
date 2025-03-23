// File: SeleniumTest.java
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxOptions;

public class SeleniumTest {
    public static void main(String[] args) {
        // Test with Chrome
        testChrome();
        // Test with Firefox
        testFirefox();
    }

    public static void testChrome() {
        System.out.println("Testing with Chrome...");

        // Set ChromeDriver path
        System.setProperty("webdriver.chrome.driver", "/usr/local/bin/chromedriver");

        // Initialize ChromeDriver
        ChromeOptions chromeOptions = new ChromeOptions();
        // Uncomment the line below to run Chrome in headless mode
        // chromeOptions.addArguments("--headless");
        WebDriver driver = new ChromeDriver(chromeOptions);

        try {
            // Navigate to Google
            driver.get("https://www.google.com");
            System.out.println("Chrome - Page Title: " + driver.getTitle());
        } finally {
            // Close the browser
            driver.quit();
        }
    }

    public static void testFirefox() {
        System.out.println("Testing with Firefox...");

        // Set GeckoDriver path
        System.setProperty("webdriver.gecko.driver", "/usr/local/bin/geckodriver");

        // Initialize GeckoDriver
        FirefoxOptions firefoxOptions = new FirefoxOptions();
        // Uncomment the line below to run Firefox in headless mode
        // firefoxOptions.addArguments("--headless");
        WebDriver driver = new FirefoxDriver(firefoxOptions);

        try {
            // Navigate to Google
            driver.get("https://www.google.com");
            System.out.println("Firefox - Page Title: " + driver.getTitle());
        } finally {
            // Close the browser
            driver.quit();
        }
    }
}