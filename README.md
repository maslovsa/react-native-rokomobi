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

## Promo

Use RMPromoManager for Promo issues.

```JavaScript
_handleLoadPromo() {
  var RMPromoManager = NativeModules.RMPromoManager;
  RMPromoManager.loadPromo(this.state.promoCode, (error, message) => {
  if (error) {
    console.error(error);
  } else {
    console.log(message)
  }
  })
}
```

**message** is a dictionary with these fields
* **applicability** -   Who can use discount (Unspecified, AllUsers, Segments)
* **startDate** - When the promo campaign starts
* **endDate** - When the promo campaign finishes
* **isAlwaysActive** - Indicates the promo campaign is forever. If this property is YES, values of startDate and endDate are not important
* **isSingleUseOnly** - The promo code can be used just once
* **autoApplyOnAppOpen** - Indicates if the discount should be applied automatically on app start
* **cannotBeCombined** - Indicates if the discount can be combined with other discounts

```JavaScript
_handleMarkPromoCodeAsUsed() {
  var RMPromoManager = NativeModules.RMPromoManager;
  var params = {"promoCode":this.state.promoCode}
  RMPromoManager.markPromoCodeAsUsed(params, (error, events) => {
  if (error) {
    console.error(error);
  } else {
    console.log(events)
  }
  })
}
```
**params** is a dictionary with these fields
* **promoCode**  - Promo code to be marked
* **valueOfPurchase** - Purchase value. Needed for analytics
* **valueOfDiscount** - Total discount. Needed for analytics
* **deliveryType** - The way this promo code was obtained

## Referral

Use RMReferralManager for Promo issues.

```JavaScript
_handleLoadReferralDiscountsList() {
  var RMReferralManager = NativeModules.RMReferralManager;
  RMReferralManager.loadReferralDiscountsList((error, events) => {
  if (error) {
    console.error(error);
  } else {
    console.log(events)
  }
  })
}

_handleLoadDiscountInfoWithCode() {
  var RMReferralManager = NativeModules.RMReferralManager;
  RMReferralManager.loadDiscountInfoWithCode(this.state.promoCode, (error, message) => {
  if (error) {
    console.error(error);
  } else {
    console.log(message)
    Alert.alert('_handleLoadDiscountInfoWithCode', message)
  }
  })
}
```
**message** is a dictionary with these fields
* **active** - Indicates whether the campaign is active
* **name**- Company name
* **recipientDiscount**  - ROKOReferralDiscountInfo
* **rewardDiscount** - ROKOReferralDiscountInfo

**ROKOReferralDiscountInfo** type is a dictionary with these fields
* **enabled** - Indicates whether the discount applying is possible
* **value** - Discount value
* **limit** - Discount limit. Applicable for ROKODiscountTypeMatching only
* **type** - Discount type

**ROKODiscountType** type is a dictionary with these fields
* **ROKODiscountTypeUnspecified** - Unknown discount type
* **ROKODiscountTypePercent** - Percent discount
* **ROKODiscountTypeFixed** -  The discount value is fixed
* **ROKODiscountTypeFree** - The goods are absolutely free
* **ROKODiscountTypeMatching** - Matching discount

## Deep Links
To handle Deep links - subscribe to handling.

```JavaScript
const myModuleEvt = new NativeEventEmitter(NativeModules.RMEventEmitter)
var subscriptionDeepLink = myModuleEvt.addListener(
  'DeepLink',
  (data) => {
    console.log("DeepLink")
    console.log(data)
  }
);
...
// Don't forget to unsubscribe, typically in componentWillUnmount
subscriptionDeepLink.remove();
```

**data** is a dictionary with these fields
* **name** - Name of the link
* **createDate** - Date when the link was created
* **updateDate** - Date when the link was updated on Portal
* **shareChannel** - Share channel name
* **vanityLink** - Meaningful part of the link url (after domain)
* **customDomainLink** - Link with custom domain. For example, yourapp://link
* **type** - Type of the link (ROKOLinkType)
* **referralCode** - Referral code this link is targeted to
* **promoCode** - Promo code this link is targeted to



```JavaScript
_handleCreateDeepLink() {
  var RMLinkManager = NativeModules.RMLinkManager;
  RMLinkManager.createLink({type: RMLinkManager.ROKOLinkTypeShare}, (error, events) => {
  if (error) {
    console.error(error);
  } else {
    console.log(events.linkURL)
    this.setState({deepLink : events.linkURL})
  }
  })
}

_handleDeepLink() {
  var RMLinkManager = NativeModules.RMLinkManager;
  RMLinkManager.handleDeepLink(this.state.deepLink, (error, data) => {
  if (error) {
    console.error(error);
  } else {
    console.log(data)
    Alert.alert('handleDeepLink', data.createDate +'\n'+ data.type + '\n' + data.name)
  }
  })
}

```

**data** has the same fields as **data**  on handling events.

## Share

```JavaScript
_handleShare() {
  var RMShareManager = NativeModules.RMShareManager;
  var params = {contentId: this.state.contentId
  RMShareManager.share(params, text: this.state.shareText})
}

const myModuleEvt = new NativeEventEmitter(NativeModules.RMEventEmitter)
var subscriptionShare = myModuleEvt.addListener(
  'ShareStatus',
  (data) => {

    if (data.channel == NativeModules.RMShareManager.ROKOShareChannelTypeEmail) {
      console.log("it was EMAIL")
    }
    if (data.status == "Canceled") {
      console.log("status is Canceled")
    }
    console.log(data)
  }
);

...
// Don't forget to unsubscribe, typically in componentWillUnmount
subscriptionShare.remove();
```
Other fields of Params are :

* **contentId** - Unique identifier of sharing content.*** [required field] ***
* **displayMessage** - Default comment for sharing content
* **text** - Text to be shared
* **contentTitle** - Title of sharing content
* **contentURL** - URL of sharing content
* **linkId** - Identifier of sharing portal link. Set this property if you share deep link to get correct reports on ROKO portal.
* **ShareChannelTypeFacebook** - Sets special text for Facebook only
* **ShareChannelTypeTwitter** - Sets special text for Twitter only
* **ShareChannelTypeMessage** - Sets special text for SMS only

* "data.status" can be:
* **Done** - Successfully shared,
* **Canceled** - Sharing dialog canceled by user
* **Failed** - Sharing failed

```JavaScript
_handleShareCompleteForChannel() {
  var RMShareManager = NativeModules.RMShareManager;
  var param = {channelType: "sms",contentId: this.state.contentId}
  RMShareManager.shareCompleteForChannel(param, (error, data) => {
  if (error) {
    console.error(error);
  } else {
    console.log(data)
  }
  })
}
```
Other fields of Params are :

* **contentId** - Unique identifier of sharing content.*** [required field] ***
* **channelType** - "sms", "twitter", "facebook", "email" or "copy"
* **linkId** - Optional Identifier of sharing portal link. Set this property if you share deep link to get correct reports on ROKO portal.

## More Info

* For more information about RokoMobi integration [the documentation](http://docs.roko.mobi/docs/cordova)
