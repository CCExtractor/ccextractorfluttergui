## Super good docs:


### Build and run

#### Currently only linux is supported, macOS should work to (not tested) (reason: windows has different filePaths)
- Check out how to install Flutter [here](https://flutter.dev/docs/get-started/install)
- To run the GUI, clone the repo and run `flutter run` or `flutter run -d linux` inside the cloned directory. 

### checkValidJSON currenty supports 3 cases

- Check if the .json file is a valid json file.
- Check if all the settings (keys) are present in the json file
- Check if a value is the same as the datatype as it should be.
- There is one more case in which, a dropdown can be of datatype `String` but still not be a valid option in the dropdown menu. This is also handled in checkValidJSON with a simple `dropDownOptionsList.contains('json[option]')`

### Proof of Concept videos submitted before GSoC'21

https://user-images.githubusercontent.com/52817235/118916824-5420fb00-b94d-11eb-8134-7bf7740be11d.mp4

https://user-images.githubusercontent.com/52817235/118916820-51260a80-b94d-11eb-81c8-a433171e5177.mp4

sample files for testing are stored in sample/ (.gitignored)

### Project structure
```
lib
├── bloc
│   ├── dashboard_bloc
│   ├── process_bloc
│   ├── redundant_process_bloc
│   └── settings_bloc
├── models
├── repositories
├── screens
│   ├── dashboard
│   │   └── components
│   └── settings
└── utils

12 directories

```