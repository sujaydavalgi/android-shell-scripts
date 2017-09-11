# scripts

Shell scripts to help work with Android device

1. Edit the bash file
*  In Linux: `vi ~/.bashrc` </br>
*  In Mac OSX: `vi ~/.bash_profile` </br>

2. Add/append the following adb paths ( Make sure to use your sdk path for ANDROID_HOME below ) </br>

`export ANDROID_HOME=~/Setup/android/sdk` </br>
  
`export ANDROID_TOOLS=${ANDROID_HOME}/tools` </br>
`export ANDROID_PTOOLS=${ANDROID_HOME}/platform-tools` </br>
`export ANDROID_BTOOLS=${ANDROID_HOME}/build-tools/26.0.0` </br>
`export PATH=${PATH}:$ANDROID_HOME:$ANDROID_TOOLS:$ANDROID_PTOOLS:$ANDROID_BTOOLS:$ANDROID_TOOLS/bin` </br>

3. Save and close </br>

4. Then run
  * In Linux: `source ~/.bashrc` </br>
  * In MaxOSX: `source ~/.bash_profile` </br>
