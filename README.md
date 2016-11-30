# React Native RokoMobi Plugin

+ Plugin allows to integrate with RokoMobi Portal

## Prerequisites

+  Install npm here - https://nodejs.org/en/
or run in console 

```bash
curl https://npmjs.org/install.sh | sh
```

+  Install Node - 

```bash
brew install node
```

+  The React Native CLI  - 

```bash
npm install -g react-native-cli
```

[Use original React Native Docs](https://facebook.github.io/react-native/docs/getting-started.html)

## Using Plugin

+ Create a new React-Native

```bash
react-native init AwesomeProject
```

+ Test application (ios)

```bash
react-native run-ios
```

+ Install the plugin

```bash
cd AwesomeProject
npm install react-native-rokomobi --save
npm install react-native-button --save
```

+ Add code to your 

+ [ios] Add RokoMobi project to your Project

* Goto npm_modules/react-native-rokomobi/ios/ and Drag RokoMobi.xcodeproj to your Project Tree

![Image of Dragging](https://api.monosnap.com/rpc/file/download?id=08MVqrBxQMGCnfqSdjSQZRnevzOu9f)

** check ** Copy items if needed

+ [ios] Add your credientals to Info.plist

```XML
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<string>QbFMYfZLnDdzhrJyZNCDetEiF0PlOtoxKk/gTeXj4C4=</string>
</plist>
```

## More Info

* For more information about RokoMobi integration [the documentation](http://docs.roko.mobi/docs/cordova)
