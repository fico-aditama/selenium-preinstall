#!/bin/bash

# Script to install Selenium WebDriver with Firefox and Chrome on Ubuntu 24.04 with auto-downloads
# Run with sudo: sudo ./install_selenium.sh

# Define variables
INSTALL_DIR="./"  # Change this to your preferred directory
WEBDRIVER_DIR="/usr/local/bin"               # Directory for WebDriver binaries
JAVA_VERSION="openjdk-11-jre"                # Java runtime for Selenium
SELENIUM_VERSION="3.141.59"                  # Selenium Server Standalone version
JUNIT_VERSION="4.12"                         # JUnit version
HAMCREST_VERSION="3.0"                       # Hamcrest version
INTELLIJ_URL="https://download.jetbrains.com/idea/ideaIC-2024.2.0.1.tar.gz"  # IntelliJ IDEA Community Edition

# Ensure the script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo"
  exit 1
fi

# Update package list
echo "Updating package list..."
apt-get update -y

# Install dependencies
echo "Installing Java ($JAVA_VERSION) and tools..."
if ! dpkg -l | grep -q $JAVA_VERSION; then
  apt-get install -y $JAVA_VERSION wget unzip curl
else
  echo "Java ($JAVA_VERSION) is already installed."
fi

# Verify Java installation
java -version
if [ $? -ne 0 ]; then
  echo "Java installation failed. Exiting."
  exit 1
fi

# Create the installation directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
  mkdir -p "$INSTALL_DIR"
  echo "Created directory: $INSTALL_DIR"
else
  echo "Directory $INSTALL_DIR already exists."
fi

cd "$INSTALL_DIR" || exit

# Download Selenium Server Standalone
SELENIUM_FILE="selenium-server-standalone-$SELENIUM_VERSION.jar"
if [ ! -f "$SELENIUM_FILE" ]; then
  echo "Downloading Selenium Server Standalone $SELENIUM_VERSION..."
  wget -O "$SELENIUM_FILE" \
    "https://github.com/SeleniumHQ/selenium/releases/download/selenium-$SELENIUM_VERSION/$SELENIUM_FILE"
  if [ ! -f "$SELENIUM_FILE" ]; then
    echo "Failed to download Selenium Server. Exiting."
    exit 1
  fi
else
  echo "Selenium Server Standalone $SELENIUM_VERSION already exists."
fi

# Download JUnit
JUNIT_FILE="junit-$JUNIT_VERSION.jar"
if [ ! -f "$JUNIT_FILE" ]; then
  echo "Downloading JUnit $JUNIT_VERSION..."
  wget -O "$JUNIT_FILE" \
    "https://repo1.maven.org/maven2/junit/junit/$JUNIT_VERSION/$JUNIT_FILE"
  if [ ! -f "$JUNIT_FILE" ]; then
    echo "Failed to download JUnit. Exiting."
    exit 1
  fi
else
  echo "JUnit $JUNIT_VERSION already exists."
fi

# Download Hamcrest
HAMCREST_FILE="hamcrest-$HAMCREST_VERSION.jar"
if [ ! -f "$HAMCREST_FILE" ]; then
  echo "Downloading Hamcrest $HAMCREST_VERSION..."
  wget -O "$HAMCREST_FILE" \
    "https://repo1.maven.org/maven2/org/hamcrest/hamcrest/$HAMCREST_VERSION/$HAMCREST_FILE"
  if [ ! -f "$HAMCREST_FILE" ]; then
    echo "Failed to download Hamcrest. Exiting."
    exit 1
  fi
else
  echo "Hamcrest $HAMCREST_VERSION already exists."
fi

# # Install Firefox and download GeckoDriver
# echo "Installing Firefox..."
# if ! dpkg -l | grep -q firefox; then
#   apt-get install -y firefox
# else
#   echo "Firefox is already installed."
# fi

GECKO_FILE="$WEBDRIVER_DIR/geckodriver"
if [ ! -f "$GECKO_FILE" ]; then
  echo "Downloading latest GeckoDriver..."
  GECKO_LATEST=$(curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest | grep "tag_name" | cut -d '"' -f 4)
  GECKO_VERSION=${GECKO_LATEST#v}
  wget -O "geckodriver.tar.gz" \
    "https://github.com/mozilla/geckodriver/releases/download/$GECKO_LATEST/geckodriver-$GECKO_VERSION-linux64.tar.gz"
  if [ ! -f "geckodriver.tar.gz" ]; then
    echo "Failed to download GeckoDriver. Exiting."
    exit 1
  fi
  tar -xzf geckodriver.tar.gz
  chmod +x geckodriver
  mv geckodriver "$GECKO_FILE"
  rm geckodriver.tar.gz
  if [ ! -f "$GECKO_FILE" ]; then
    echo "Failed to install GeckoDriver. Exiting."
    exit 1
  fi
  echo "GeckoDriver installed in $WEBDRIVER_DIR"
else
  echo "GeckoDriver already exists in $WEBDRIVER_DIR"
fi

# Install Chrome and download ChromeDriver
echo "Installing Google Chrome..."
if ! dpkg -l | grep -q google-chrome-stable; then
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
  echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
  apt-get update -y
  apt-get install -y google-chrome-stable
else
  echo "Google Chrome is already installed."
fi

CHROME_FILE="$WEBDRIVER_DIR/chromedriver"
if [ ! -f "$CHROME_FILE" ]; then
  echo "Downloading ChromeDriver..."
  CHROME_VERSION=$(google-chrome --version | cut -d ' ' -f 3 | cut -d '.' -f 1-3)
  CHROMEDRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION")
  wget -O "chromedriver.zip" \
    "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
  if [ ! -f "chromedriver.zip" ]; then
    echo "Failed to download ChromeDriver. Exiting."
    exit 1
  fi
  unzip chromedriver.zip
  chmod +x chromedriver
  mv chromedriver "$CHROME_FILE"
  rm chromedriver.zip
  if [ ! -f "$CHROME_FILE" ]; then
    echo "Failed to install ChromeDriver. Exiting."
    exit 1
  fi
  echo "ChromeDriver installed in $WEBDRIVER_DIR"
else
  echo "ChromeDriver already exists in $WEBDRIVER_DIR"
fi

# Install IntelliJ IDEA Community Edition
INTELLIJ_DIR=$(ls -d /opt/idea-IC-* 2>/dev/null | head -n 1)
if [ -z "$INTELLIJ_DIR" ]; then
  echo "Installing IntelliJ IDEA Community Edition..."
  wget -O idea.tar.gz "$INTELLIJ_URL"
  tar -xzf idea.tar.gz -C /opt/
  rm idea.tar.gz
  INTELLIJ_DIR=$(ls -d /opt/idea-IC-* | head -n 1)
  if [ -d "$INTELLIJ_DIR" ]; then
    echo "IntelliJ IDEA installed in $INTELLIJ_DIR"
    # Create a desktop entry
    cat <<EOF > /usr/share/applications/intellij-idea.desktop
[Desktop Entry]
Name=IntelliJ IDEA
Exec=$INTELLIJ_DIR/bin/idea.sh
Type=Application
Icon=$INTELLIJ_DIR/bin/idea.png
Terminal=false
EOF
    chmod +x /usr/share/applications/intellij-idea.desktop
  else
    echo "Error: IntelliJ IDEA installation failed."
    exit 1
  fi
else
  echo "IntelliJ IDEA already installed in $INTELLIJ_DIR"
fi

# Set up environment variables if not already set
if [ ! -f "/etc/profile.d/selenium.sh" ]; then
  echo "Setting up environment variables..."
  echo "export PATH=\$PATH:$WEBDRIVER_DIR" >> /etc/profile.d/selenium.sh
  echo "export SELENIUM_HOME=$INSTALL_DIR" >> /etc/profile.d/selenium.sh
  chmod +x /etc/profile.d/selenium.sh
  source /etc/profile.d/selenium.sh
else
  echo "Environment variables already set in /etc/profile.d/selenium.sh"
fi

# Test Selenium Server
echo "Testing Selenium Server..."
java -jar "$INSTALL_DIR/$SELENIUM_FILE" -help > /dev/null 2>&1 &
if [ $? -eq 0 ]; then
  echo "Selenium Server is ready to use."
else
  echo "Error: Selenium Server test failed."
  exit 1
fi

echo "Installation complete!"
echo "Selenium files are located in $INSTALL_DIR."
echo "Run 'source /etc/profile' to apply environment variables in the current session."
echo "Start IntelliJ IDEA from the applications menu or '$INTELLIJ_DIR/bin/idea.sh'."