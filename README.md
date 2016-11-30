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

+ [ios] Add code to your index.ios.js

```JavaScript
import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';
import { NativeModules } from 'react-native';
import Button from 'react-native-button';

export default class AwesomeProject extends Component {
  _handleSetUser() {
    var RMPortalManager = NativeModules.RMPortalManager;
    RMPortalManager.setUser({userName: 'Sergey'}, (error, events) => {
    if (error) {
      console.error(error);
    } else {
      console.log(events)
    }
    })
  }

  _handleSetUserProperty() {
    var RMPortalManager = NativeModules.RMPortalManager;
    RMPortalManager.setUserCustomProperty({propertyName: 'Sex', propertyValue: 'Male'}, (error, events) => {
    if (error) {
      console.error(error);
    } else {
      console.log(events)
    }
    })
  }

  render() {

    var RMLoggerManager = NativeModules.RMLoggerManager;
    RMLoggerManager.addEvent({name: 'Start', params : {location: '4 Privet Drive, Surrey', time: "10:00", description: 'abba'}});

    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>

        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.ios.js
        </Text>
        <Text style={styles.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>
        <Button
        style={{fontSize: 20, color: 'green'}}
        styleDisabled={{color: 'red'}}
        onPress={() => this._handleSetUser()}>
        SetUser
        </Button>

        <Button
        style={{fontSize: 20, color: 'cyan'}}
        styleDisabled={{color: 'red'}}
        onPress={() => this._handleSetUserProperty()}>
        SetCustomUserProperty
        </Button>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('AwesomeProject', () => AwesomeProject);
```
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
