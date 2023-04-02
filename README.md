# take_a_walk_app

Authors:
Matej Kandráč
Patrik Tomčo


## Firebase initialization
When initializing project, you will need to generate google-services.json file.

To do so, download firebaseCLI for you machine at:
https://firebase.google.com/docs/cli?authuser=0&hl=en#install_the_firebase_cli
Then add it to your environment path and use command
```
firebase login
```
to log in with your credentials.

After that, navigate to project root directory in terminal and execute:
```
dart pub global activate flutterfire_cli
```
This step is required only once so if you have done this before, it is not required.

After that add dart executable libraries to your path by adding this path to your environment variables:
```
$HOME/.pub-cache/bin
```

Now generate file with (still in project root directory):
```
flutterfire configure --project=takeawalk-65934
```


## Launcher icons generation
To generate launcher icons, run in project root directory:
```
flutter pub get
flutter pub run icons_launcher:create
```

This step is required only if app launcher icon in assets folder was edited.

## Splash generation
To generate splash view, run in project root directory:
```
flutter pub get
flutter pub run flutter_native_splash:create
```

## Retrofit api generator
To generate retrofit api requests, run command:
```
flutter pub get
flutter pub run build_runner build
```


## FEATURE FLOW
view -> bloc -> repository impl -> datasource