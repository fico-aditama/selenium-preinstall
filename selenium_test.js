// File: selenium_test.js
const { Builder } = require('selenium-webdriver');
const chrome = require('selenium-webdriver/chrome');
const firefox = require('selenium-webdriver/firefox');

const CHROME_DRIVER_PATH = '/usr/local/bin/chromedriver';
const FIREFOX_DRIVER_PATH = '/usr/local/bin/geckodriver';

async function testChrome() {
    console.log('Testing with Chrome...');
    let driver;
    try {
        // Set up Chrome options
        const chromeOptions = new chrome.Options();
        // Uncomment the line below to run Chrome in headless mode
        // chromeOptions.addArguments('--headless');

        // Initialize ChromeDriver
        driver = await new Builder()
            .forBrowser('chrome')
            .setChromeOptions(chromeOptions)
            .setChromeService(new chrome.ServiceBuilder(CHROME_DRIVER_PATH))
            .build();

        // Navigate to Google
        await driver.get('https://www.google.com');
        const title = await driver.getTitle();
        console.log('Chrome - Page Title:', title);
    } finally {
        // Close the browser
        if (driver) await driver.quit();
    }
}

async function testFirefox() {
    console.log('Testing with Firefox...');
    let driver;
    try {
        // Set up Firefox options
        const firefoxOptions = new firefox.Options();
        // Uncomment the line below to run Firefox in headless mode
        // firefoxOptions.addArguments('--headless');

        // Initialize GeckoDriver
        driver = await new Builder()
            .forBrowser('firefox')
            .setFirefoxOptions(firefoxOptions)
            .setFirefoxService(new firefox.ServiceBuilder(FIREFOX_DRIVER_PATH))
            .build();

        // Navigate to Google
        await driver.get('https://www.google.com');
        const title = await driver.getTitle();
        console.log('Firefox - Page Title:', title);
    } finally {
        // Close the browser
        if (driver) await driver.quit();
    }
}

(async () => {
    // Run tests for both browsers
    await testChrome();
    await testFirefox();
})();