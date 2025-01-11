<div align="center">

<h1> Recall </h1>

![recall](https://socialify.git.ci/luciferro01/recall/image?custom_description=An+advanced+Clipboard+Manager+for+linux&description=1&language=1&name=1&owner=1&theme=Auto)
<br/>

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Riverpod](https://img.shields.io/badge/Riverpod-42a5f5?logo=dart&logoColor=white)
![Hive](https://img.shields.io/badge/Hive-FFB300?logo=hive&logoColor=white)

</div>

## Overview

**Recall** is an advanced clipboard manager built with Flutter. It allows you to save, organize, and manage clipboard items efficiently. Whether you're copying text, URLs, or other data, Recall helps you keep track of everything.

## Features

### 1. 📝 Clipboard Management

- Save and organize clipboard items.
- Automatically categorize items based on their type (text, URL, etc.).

### 2. ⭐ Favorites

- Mark important clipboard items as favorites for quick access.

### 3. 🔍 Search and Filter

- Search through your clipboard history by keywords.
- Filter items based on their type or favorite status.

### 4. 📋 User Interface

- Intuitive and user-friendly interface.
- Access clipboard items through a sleek list view.

### 5. 🔒 Privacy-Focused

- All data is stored locally on your device.
- No external servers or third-party apps are used, ensuring maximum privacy and security.

## Project Structure

```
recall/
├── assets/
│   └── icons/
├── lib/
│   ├── screens/
│   │   └── home_screen.dart
│   ├── services/
│   │   └── clipboard_service.dart
│   ├── widgets/
│   │   └── clipboard_list.dart
│   └── main.dart
└── README.md
```

## Files

### Core Components

- `lib/main.dart`: The main entry point of the application.
- `lib/services/clipboard_service.dart`: Service for managing clipboard items.
- `lib/widgets/clipboard_list.dart`: Widget for displaying clipboard items.
- `lib/screens/home_screen.dart`: Main screen of the application.

### Assets

- `assets/icons/`: Directory containing application icons.

## Installation

1. Clone the repository or download it as a ZIP file.
   ```bash
   git clone https://github.com/luciferro01/recall.git
   ```
2. Navigate to the project directory.
3. Install dependencies.
4. Run the application.

## Usage

1. Launch the application.
2. Copy text or URLs to your clipboard.
3. Open Recall to view, organize, and manage your clipboard items.

## Development

### Prerequisites

- Flutter SDK
- Git (for version control)

### Building

This application is designed to work out of the box. If you want to modify the code:

1. Edit the Dart files as required.
2. Run the application using `flutter run` to test your changes.

## Contribution

Feel free to fork the repository, create a new branch, and submit a pull request with your improvements.

## License

This project is licensed under the AGPL-3.0 - see the LICENSE file for details.

## Author

Developed by [luciferro01](https://github.com/luciferro01/).
