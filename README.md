# CCExtractor Flutter GUI 
[![Upload artifact](https://github.com/CCExtractor/ccextractorfluttergui/actions/workflows/create_artifacts.yml/badge.svg)](https://github.com/CCExtractor/ccextractorfluttergui/actions/workflows/create_artifacts.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![bloc](https://img.shields.io/badge/flutter-bloc-blue)](https://github.com/felangel/bloc)
[![GitHub All Releases](https://img.shields.io/github/downloads/CCExtractor/ccextractorfluttergui/total.svg)](https://github.com/CCExtractor/ccextractorfluttergui/releases/latest)

The new cross platform interface is all you need, as it includes all the options. After installing GUI you will have a shortcut in your desktop, this lets users not familiar with CLI to extract subtitles.

Usually, you will never need to use all the options (and even if you do, all the settings are saved locally at `Documents/config.json` in your PC) for regular usage.

The GUI basically uses dart's [process](https://api.dart.dev/stable/2.13.4/dart-io/Process-class.html) class to [start](https://api.dart.dev/stable/2.13.4/dart-io/Process/start.html) the ccextractor executable and shows the progress and live output.

## Table of contents
* [Installation](#installation)
* [Usage](#usage)
* [Contributing](#contributing)
* [License](#license)
* [GSoC](#gsoc)


## Installation
Depending on your OS of choice, one or multiple options are available.

### Windows
- (preferred) [Download the .msi](https://github.com/CCExtractor/ccextractor/releases) to install CCExtractor and the GUI
- Download the built GUI from the releases on this repository. You'll have to provide a CCExtractor binary yourself
- Download this repository and build the GUI by yourself. You'll have to provide a CCExtractor binary yourself

### Linux
Executables for Linux can be  found [here](https://nightly.link/CCExtractor/ccextractorfluttergui/workflows/create_artifacts/master) or on the [releases page](https://github.com/CCExtractor/ccextractorfluttergui/releases). Both still require to get ccextractor manually. 

### macOS
MacOS requires you to build the GUI from source and get ccextractor manually. For detailed information on this please refer [INSTALL.MD](INSTALL.MD).


## Usage
For users new to GUI check out the usage guide [here](USAGE.MD). You can also check all the options avaiable in ccextractor [here](https://ccextractor.org/public/general/command_line_usage/).


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change. Please make sure to update tests as appropriate. For more details, see the [Contributing Page](CONTRIBUTING.md)

## License
[MIT License](LICENSE)

## GSoC
#### GSoC'21
* Student: @Techno-Disaster ([commits](https://github.com/CCExtractor/ccextractorfluttergui/commits?author=Techno-Disaster))
* Mentor: @csfmp3

