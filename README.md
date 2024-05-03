# PBL5-Mobile-Application

Project Base Learning at Da Nang University of Science and Technology.

## Getting Started

### 1. Clone the repository:

```sh
git clone https://github.com/dhv-pbl5/pbl5-mobile.git
```

### 2. Install packages and generate code files

- Get pub package

```sh
flutter pub get
```

- Generate code files

```sh
flutter pub run build_runner build --delete-conflicting-outputs
```

In the development process, you can use the command line below for more convenience.

```sh
flutter pub run build_runner watch
```

- Generate translation file

```sh
flutter pub run easy_localization:generate --source-dir 'assets/translations' --output-dir 'lib/generated' --output-file 'translations.g.dart' --format keys
```

- App's icon

```sh
flutter pub run flutter_launcher_icons
```

#### QUICK COMMAND

- **Windows**

```sh
flutter clean; flutter pub get; flutter pub run build_runner build --delete-conflicting-outputs; flutter pub run easy_localization:generate --source-dir 'assets/translations' --output-dir 'lib/generated' --output-file 'translations.g.dart' --format keys
```

- **Linux and MacOS**

```sh
flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs && flutter pub run easy_localization:generate --source-dir 'assets/translations' --output-dir 'lib/generated' --output-file 'translations.g.dart' --format keys
```

### 3. Executing program

```sh
flutter run
```
