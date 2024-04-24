# scripts

Shell scripts to help work with Android device

**STEP-1:**
Download or Clone the repo in your local machine
- Download: https://github.com/sujaydavalgi/android-shell-scripts/archive/master.zip
  - Extract it to your setup folder
- Clone: https://github.com/sujaydavalgi/android-shell-scripts.git
  - Create a setup folder and initialize that folder
  - Clone the repo in that folder

**STEP-2:**
Edit the PATH variables

1. Open the environment variables file

- For Linux/Mac (Unix based), edit the bash profile file</br>
  - In Linux: `vi ~/.bashrc`</br>
  - In Mac OSX: `vi ~/.bash_profile`</br>
  
- For Windows, edit the [environment variables](http://www.360logica.com/blog/how-to-set-path-environmental-variable-for-sdk-in-windows/) based</br>
  - Click Start (Orb) menu button</br>
  - Right click on Computer icon</br>
  - Click on Properties. This will bring up System window in Control Panel</br>
  - Click on Advanced System Settings on the left. This will bring up the System Properties window with Advanced tab selected </br>
  - Click on Environment Variables button on the bottom of the dialog. This brings up the Environment Variables dialog</br>
  - In the System Variables section (or User variables if system variables is uneditable), scroll down till you see Path</br>
  - Click on Path to select it, then the Edit button. This will bring up the Edit System Variable dialog</br>
  - While the Variable value field is selected, press the End key on your keyboard to go to the right end of the line, or use the arrow keys to move the marker to the end</br>

2. Add/append the following adb paths ( Make sure to use your sdk path for ANDROID_HOME below )</br>
 - For Linux / Mac (Unix based)</br>

`export ANDROID_HOME=~/Setup/android/sdk` <- Enter the Android sdk path in your machine</br>
  
`export ANDROID_TOOLS=${ANDROID_HOME}/tools`</br>
`export ANDROID_PTOOLS=${ANDROID_HOME}/platform-tools`</br>
`export ANDROID_BTOOLS=${ANDROID_HOME}/build-tools/26.0.0` <- Check and add the actual builds-tools subfolder</br>
`export PATH=${PATH}:$ANDROID_HOME:$ANDROID_TOOLS:$ANDROID_PTOOLS:$ANDROID_BTOOLS:$ANDROID_TOOLS/bin`</br>

 - For Windows</br>

-- Add these variables</br>

Variable name: `ANDROID_HOME`</br>
Variable value: `%USERPROFILE%\AppData\Local\Android\Sdk`</br>

Variable name: `ANDROID_TOOLS`</br>
Variable value: `%ANDROID_HOME%\tools`</br>

Variable name: `ANDROID_PTOOLS`</br>
Variable value:`%ANDROID_HOME%\platform-tools`</br>

Variable name: `ANDROID_BTOOLS`</br>
Variable value:`%ANDROID_HOME%\build-tools\26.0.1`</br>

-- Edit the PATH variable and add</br>
`%ANDROID_HOME%`</br>
`%ANDROID_TOOLS%`</br>
`%ANDROID_PTOOLS%`</br>
`%ANDROID_BTOOLS%`</br>

3. Save and close</br>

4. Then run
 - In Linux: `source ~/.bashrc`</br>
 - In MaxOSX: `source ~/.bash_profile`</br>
 - In Windows: May be restart the system

5. Close all the existing terminals and reopen

**STEP-3:**
Setup your test environments:
 - Open the mySetup.txt under "library" folder
  - Search for "myShellScripts" variable and set it with the path that the scripts are present
  - Search for "myProjDir" variable and set it with your system test folder path (include the complet path inside quotes)
