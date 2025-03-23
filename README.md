# Selenium WebDriver Test Project

This project provides a setup for running Selenium WebDriver tests with both Chrome and Firefox browsers on Ubuntu 24.04. It includes scripts in Python, JavaScript (Node.js), and Java to automate browser testing, along with an installation script to set up the required dependencies.

## Project Structure

```
.
├── hamcrest-3.0.jar                # Hamcrest library for Java
├── install.sh                      # Bash script to install dependencies
├── junit-4.12.jar                  # JUnit library for Java
├── selenium_code.py                # Python script for Selenium tests
├── selenium-server-standalone-3.141.59.jar  # Selenium Server Standalone
├── SeleniumTest.java               # Java script for Selenium tests
└── selenium_test.js                # JavaScript (Node.js) script for Selenium tests
```

## Prerequisites

- **Operating System:** Ubuntu 24.04
- **Internet Connection:** Required for downloading dependencies.
- **Sudo Privileges:** Needed to run the installation script.
- **IntelliJ IDEA:** Used for running Java tests (installed by the script).

## Setup Instructions

### 1. Run the Installation Script

The `install.sh` script automates the installation of all required dependencies, including Java, Chrome, Firefox, WebDrivers (ChromeDriver and GeckoDriver), and IntelliJ IDEA.

1. **Make the Script Executable:**
   ```bash
   chmod +x install.sh
   ```

2. **Run the Script:**
   ```bash
   sudo ./install.sh
   ```

3. **Post-Installation:**
   - Apply environment variables:
     ```bash
     source /etc/profile
     ```
   - The script will:
     - Install Java, Chrome, and Firefox.
     - Download and place ChromeDriver and GeckoDriver in `/usr/local/bin`.
     - Install IntelliJ IDEA in `/opt/`.
     - Set up environment variables (`SELENIUM_HOME` and `PATH`).

### 2. Set Up Dependencies for Each Language

#### Python
- **Install Python and Selenium:**
  ```bash
  sudo apt-get install python3 python3-pip
  pip3 install selenium
  ```

#### JavaScript (Node.js)
- **Install Node.js and Selenium WebDriver:**
  ```bash
  sudo apt-get install nodejs npm
  npm init -y
  npm install selenium-webdriver
  ```

#### Java
- **Set Up IntelliJ IDEA Project:**
  1. Open IntelliJ IDEA (installed in `/opt/idea-IC-*`).
  2. Create a new Java project or open an existing one.
  3. Add the following libraries to your project (already in the project directory):
     - `selenium-server-standalone-3.141.59.jar`
     - `junit-4.12.jar`
     - `hamcrest-3.0.jar`
  4. In IntelliJ:
     - Go to `File > Project Structure > Libraries`.
     - Click `+`, select `Java`, and add the `.jar` files from the project directory.

## Running the Tests

### 1. Python Script (`selenium_code.py`)

This script tests Selenium with both Chrome and Firefox.

```bash
python3 selenium_code.py
```

**Expected Output:**
```
Testing with Chrome...
Chrome - Page Title: Google
Testing with Firefox...
Firefox - Page Title: Google
```

### 2. JavaScript Script (`selenium_test.js`)

This script tests Selenium with both Chrome and Firefox using Node.js.

```bash
node selenium_test.js
```

**Expected Output:**
```
Testing with Chrome...
Chrome - Page Title: Google
Testing with Firefox...
Firefox - Page Title: Google
```

### 3. Java Script (`SeleniumTest.java`)

This script tests Selenium with both Chrome and Firefox using Java.

1. Open `SeleniumTest.java` in IntelliJ IDEA.
2. Right-click the file and select `Run 'SeleniumTest.main()'`.

**Expected Output:**
```
Testing with Chrome...
Chrome - Page Title: Google
Testing with Firefox...
Firefox - Page Title: Google
```

## Troubleshooting

- **ChromeDriver/Firefox Version Mismatch:**
  - If you encounter errors like "This version of ChromeDriver only supports Chrome version X," ensure the ChromeDriver version matches your installed Chrome version. The `install.sh` script automatically downloads the correct version.
  - Similarly, ensure GeckoDriver is compatible with your Firefox version.
  - Check browser versions:
    ```bash
    google-chrome --version
    firefox --version
    ```

- **File Not Found Errors:**
  - Verify that `chromedriver` and `geckodriver` are in `/usr/local/bin`:
    ```bash
    ls /usr/local/bin/chromedriver /usr/local/bin/geckodriver
    ```
  - If missing, re-run the `install.sh` script.

- **Environment Variables:**
  - Ensure environment variables are set:
    ```bash
    echo $PATH
    echo $SELENIUM_HOME
    ```
  - If not set, source the profile:
    ```bash
    source /etc/profile
    ```

- **IntelliJ IDEA Issues:**
  - If IntelliJ IDEA doesn't start, run it manually:
    ```bash
    /opt/idea-IC-*/bin/idea.sh
    ```

## Notes

- **Headless Mode:** The scripts include options to run in headless mode (commented out). Uncomment the relevant lines in each script if you don't want browser windows to open visibly.
- **Customization:** Adjust the `INSTALL_DIR` in `install.sh` if you want to use a different directory for Selenium files.
- **Dependencies:** The `install.sh` script ensures all required files are downloaded and placed in the project directory.

## License

This project is licensed under the MIT License. Feel free to modify and distribute as needed.

