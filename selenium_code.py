# File: selenium_test.py
from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.firefox.service import Service as FirefoxService
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.webdriver.firefox.options import Options as FirefoxOptions

# Paths to WebDriver executables (set by the script in /usr/local/bin)
CHROME_DRIVER_PATH = "/usr/local/bin/chromedriver"
FIREFOX_DRIVER_PATH = "/usr/local/bin/geckodriver"

def test_chrome():
    print("Testing with Chrome...")
    chrome_options = ChromeOptions()
    # Uncomment the line below to run Chrome in headless mode
    # chrome_options.add_argument("--headless")
    
    # Initialize ChromeDriver
    service = ChromeService(executable_path=CHROME_DRIVER_PATH)
    driver = webdriver.Chrome(service=service, options=chrome_options)
    
    try:
        # Navigate to Google
        driver.get("https://www.google.com")
        print("Chrome - Page Title:", driver.title)
    finally:
        # Close the browser
        driver.quit()

def test_firefox():
    print("Testing with Firefox...")
    firefox_options = FirefoxOptions()
    # Uncomment the line below to run Firefox in headless mode
    # firefox_options.add_argument("--headless")
    
    # Initialize GeckoDriver
    service = FirefoxService(executable_path=FIREFOX_DRIVER_PATH)
    driver = webdriver.Firefox(service=service, options=firefox_options)
    
    try:
        # Navigate to Google
        driver.get("https://www.google.com")
        print("Firefox - Page Title:", driver.title)
    finally:
        # Close the browser
        driver.quit()

if __name__ == "__main__":
    # Run tests for both browsers
    test_chrome()
    test_firefox()