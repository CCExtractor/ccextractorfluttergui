Super good docs:

#### checkValidJSON currenty supports 3 cases

- Check if the .json file is a valid json file.
- Check if all the settings (keys) are present in the json file
- Check if a value is the same as the datatype as it should be.
- There is one more case in which, a dropdown can be of datatype `String` but still not be a valid option in the dropdown menu. This is also handled in checkValidJSON with a simple `dropDownOptionsList.contains('json[option]')`


sample files for testing are stored in sample/ (.gitignored)