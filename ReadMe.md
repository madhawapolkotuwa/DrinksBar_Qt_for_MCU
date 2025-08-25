# DrinksBar - Qt for MCUs Drink Ordering System

## Overview
*DrinksBar* is an embedded application built with *Qt for MCUs* for a drink-ordering system running on the STM32F769 Discovery board. It features a touchscreen QML-based user interface, a real-time clock (RTC) for time and date display, and a JSON-driven drinks menu loaded from an SD card. Users can select hot drinks, cold drinks, or fresh juices, customize options like size and sugar level, and simulate drink preparation. Images are dynamically loaded from the SD card in real-time and removed from RAM after display, optimizing memory for larger pages with images or videos.

## Features
- **Dynamic UI**: QML-based interface with a `Loader` for switching between screens (e.g., drink selection, customization).
- **Dynamic Image Rendering**: Images are loaded in real-time from the SD card and cleared from RAM after display, enabling efficient handling of large pages with images or potential video assets.
- **Drink Models**: Supports hot drinks, cold drinks, and fresh juices, loaded from a JSON file (`j.json`) using the FatFs file system.
- **RTC Integration**: Displays and updates the current time and date using the STM32F769's RTC.
- **Order Simulation**: Simulates drink preparation with a 3-second timer and customizable options.
- **Embedded Optimization**: Lightweight design tailored for microcontrollers using *Qt for MCUs*.

## Prerequisites
- **Hardware**: STM32F769I-Discovery board with an SD card slot.
- **Software**:
  - Qt for MCUs (tested with Qt 6.x).
  - STM32CubeIDE or a compatible IDE for building and flashing.
  - CMake 3.21.1 or higher.
  - SD card containing `j.json` and referenced image files (e.g., `latte.png`, `glass.png`).
- **Dependencies**:
  - STM32F7xx HAL Drivers (included in the project).
  - FatFs library for SD card access.
  - jsmn JSON parser.

## Project Structure
```
DrinksBar/
├── 3rdParty/FatFs/          # FatFs library for SD card file system
├── assets/                  # Images and resources (referenced from SD card)
│   ├── j.json               # JSON file with drink data
│   ├── images/              # Image files (e.g., latte.png, glass.png)
├── fonts/                   # Fonts (Roboto, NotoSansJP)
├── i18n/                    # Translation files
├── interface/               # C++ interface headers
│   ├── DateTimeProvider.h   # RTC time/date management
│   ├── DrinksModel.h        # Drink data models
│   ├── SystemInterface.h    # System logic and state management
├── stm/                     # Board-specific configuration
│   ├── board_config.cpp     # Hardware initialization (RTC, SD card)
├── board_config.h
├── ui/                      # QML UI files (e.g., HotCoolSelectScreen.qml)
├── DrinksBar.qml            # Main QML entry point
├── DrinksBar.qmlproject     # Qt for MCUs project configuration
├── CMakeLists.txt           # Build configuration
├── main.cpp                 # Application entry point
```

## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/madhawapolkotuwa/DrinksBar.git
   ```

2. Open `DrinksBar` project in **Qt Creator** and build the poject.
    - in the build directory `CMakeFiles\DrinksBar.dir\resources\assets\images` you can find the converted images from `QT for MCU` image generator.
    

3. **Prepare the SD Card**:
   - Copy converted images image file to the root directory of the SD card. 
   - Copy the provided `j.json` file to the root directory of the SD card. 
   - Copy the referenced image files (e.g., `001.png`, `002.png`, etc.) from the `CMakeFiles\DrinksBar.dir\resources\assets\images` directory to the root directory of the SD card.
   - Insert the SD card into the STM32F769 board.

4. **Flash to the Board**:
   - Flash the board using QT creator.
   - The app will load the *DrinksBar.qml* interface, displaying the time, date, and drink selection options with images dynamically rendered from the SD card.
   - use the console application (Tera Term) to check log output.

5. **Run the Application**:
   - Power on the board with the SD card inserted.
   - The app will load the *DrinksBar.qml* interface, displaying the time, date, and drink selection options with images dynamically rendered from the SD card.

## Dynamic Image Rendering
The *DrinksBar* application optimizes memory usage by dynamically loading images from the SD card in real-time, as specified in the `j.json` file (e.g., `image` and `glassImage` fields in `DrinksModel.h`). After an image is displayed in the QML UI, it is removed from RAM, freeing memory for other application tasks. This approach is ideal for handling larger pages with multiple images or potential video assets, ensuring efficient resource usage on resource-constrained microcontrollers. The FatFs file system, initialized in `board_config.cpp`, enables seamless SD card access for this feature.

## Usage
- **Navigation**: Use the touchscreen to navigate through drink categories (hot, cold, juices) and customize orders (size, sugar level). Images for drinks are loaded dynamically from the SD card and cleared from RAM after display to optimize memory.
- **Settings**: Tap the settings icon to open the *SettingsDialog* for adjusting time and date.
- **Preparation**: Select a drink and start the preparation process, which triggers a 3-second timer and console output of the order details.
- **Memory Efficiency**: Dynamic image loading ensures that large assets don’t overwhelm the STM32F769’s limited RAM, making the app scalable for complex UIs with images or videos.

## Key Files
- **DrinksBar.qml**: Main QML file defining the UI layout, including a `TopBar`, settings button, and `Loader` for dynamic pages.
- **SystemInterface.cpp/h**: Manages app state (current page, drink selection, order details) and simulates drink preparation.
- **DateTimeProvider.h**: Handles RTC interactions for time and date display/update.
- **DrinksModel.h**: Loads and parses JSON drink data, including image paths, into models for hot drinks, cold drinks, and fresh juices.
- **board_config.cpp/h**: Initializes the STM32F769’s clock, SD card, and RTC, enabling dynamic image loading.
- **main.cpp**: Application entry point, initializing hardware and setting up the Qt application.
- **CMakeLists.txt**: Configures the build, including Qt for MCUs and STM32 HAL dependencies.
- **j.json**: Defines the drink menu and image paths.
- **images/**: Contains image files referenced in `j.json`.


## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments
- Built with *Qt for MCUs* by The Qt Company.
- Uses STM32F7xx HAL drivers and FatFs for hardware and file system support.
- JSON parsing powered by *jsmn*.
