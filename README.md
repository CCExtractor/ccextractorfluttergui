## Super good docs:


### Build and run

- Check out how to install Flutter [here](https://flutter.dev/docs/get-started/install)
- Enable the flutter platform specific flag with `flutter config --enable-<platform>-desktop`, more info on this [here](https://flutter.dev/desktop)
- To run the GUI, clone the repo and run `flutter run` or `flutter run -d <platform>` inside the cloned directory. 
- To get any output you should have `ccextractorwinfull.exe` if you are on windows or `ccextractor` if you are on linux/macOS in your PATH. 

#### For release builds: 
- Run `flutter build <platform>` and you should get a executable in `./build/linux/x64/release/bundle/ccxgui`

#### Using pre-built executables:
- You can also just download the latest required executable from [here](https://nightly.link/CCExtractor/ccextractorfluttergui/workflows/create_artifacts/master) or manually from the github actions artifacts, keep in mind these still need `ccextractorwinfull.exe` if you are on windows or `ccextractor` if you are on linux/macOS in your PATH. 
- For linux you need to `chmod 700 ./ccxgui`
- Until the parameter names are more consistent in main ccx repo, please use [this](https://github.com/Techno-Disaster/ccextractor/tree/td/consistent-param-names) branch to build ccx.

### checkValidJSON currenty supports 3 cases

- Check if the .json file is a valid json file.
- Check if all the settings (keys) are present in the json file
- Check if a value is the same as the datatype as it should be.
- There is one more case in which, a dropdown can be of datatype `String` but still not be a valid option in the dropdown menu. This is also handled in checkValidJSON with a simple `dropDownOptionsList.contains('json[option]')`

### Other docs

Most of the other parts of super good docs lie in the [process_bloc](lib/bloc/process_bloc/process_bloc.dart) file. Feel free to check that to see how most of the logic and file handling of the app. 

### Proof of Concept videos submitted before GSoC'21

https://user-images.githubusercontent.com/52817235/118916824-5420fb00-b94d-11eb-8134-7bf7740be11d.mp4

https://user-images.githubusercontent.com/52817235/118916820-51260a80-b94d-11eb-81c8-a433171e5177.mp4

sample files for testing are stored in sample/ (.gitignored)

### Project structure
```
lib/
├── bloc
│   ├── dashboard_bloc
│   │   ├── dashboard_bloc.dart
│   │   ├── dashboard_event.dart
│   │   └── dashboard_state.dart
│   ├── process_bloc
│   │   ├── process_bloc.dart
│   │   ├── process_event.dart
│   │   └── process_state.dart
│   └── settings_bloc
│       ├── settings_bloc.dart
│       ├── settings_event.dart
│       └── settings_state.dart
├── generated_plugin_registrant.dart
├── main.dart
├── models
│   ├── settings_model.dart
│   └── video.dart
├── repositories
│   ├── ccextractor.dart
│   └── settings_repository.dart
├── screens
│   ├── dashboard
│   │   ├── components
│   │   │   ├── add_files.dart
│   │   │   ├── custom_snackbar.dart
│   │   │   ├── process_tile.dart
│   │   │   └── udp_button.dart
│   │   └── dashboard.dart
│   ├── home.dart
│   └── settings
│       ├── basic_settings.dart
│       ├── components
│       │   ├── custom_divider.dart
│       │   ├── custom_dropdown.dart
│       │   ├── custom_swtich_listTile.dart
│       │   └── custom_textfield.dart
│       ├── input_settings.dart
│       ├── obscure_settings.dart
│       └── output_settings.dart
└── utils
    ├── constants.dart
    └── responsive.dart
    
12 directories, 31 files

```
