# Installation
## Install from releases (WINDOWS ONLY)
- This is the simplest method, just download the installer form [here](https://github.com/CCExtractor/ccextractor/releases) (currently only has windows), and then install it like any other windows program.

--- 


##### If you run the GUI from nighly builds or source, you need to manually have the ccextractor binary in your PATH (`ccextractorwinfull.exe` if you are on windows or `ccextractor` if you are on linux/macOS).

--- 

## Nightly builds (WINDOWS, LINUX)
- You can also get the latest files for your operating system from [here](https://nightly.link/CCExtractor/ccextractorfluttergui/workflows/create_artifacts/master).
- Once you unzip it, you should see a ccxgui executable in the folder. Double click to run :D

## Building and running the GUI from source (ALL)
- This method only makes sense for people who actually want to debug the app. If you want to skip the hastle of installing frameworks and stuff just go the nightly way, the CI does these below steps for you automatically on every commit. 
- To build the GUI from source first install flutter from [here](https://flutter.dev/docs/get-started/install) for your operating system.
- Switch to flutter master channel using `flutter channel master && flutter upgrade`
- Next enable the flutter platform specific flag with `flutter config --enable-<platform>-desktop`, more info on this [here](https://flutter.dev/desktop).
- Then clone [this](https://github.com/CCExtractor/ccextractorfluttergui) repository and run `flutter run -d <platform> --release` to run the app. 
- To install the Gui you will need to build it using `flutter build <platform> --release`. The release builds should be located under /build/\<platform>.

### Additional macOS steps:
- If you build and install from source, you will probably get a `Process not permitted operation error` to fix remove the below lines from macos/*.entitlements files.

```
<key>com.apple.security.app-sandbox</key>
<true/>
```
--- 
