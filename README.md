# How to integrate the CrowdConnected SDK using Carthage

### Add dependencies in Cartfile
In your `Carfile` file add the following:
```
github "aws-amplify/aws-sdk-ios"
binary "https://crowdconnected-public-maven.s3.eu-west-1.amazonaws.com/iOSSources/crowdconnected-core-sources"
binary "https://crowdconnected-public-maven.s3.eu-west-1.amazonaws.com/iOSSources/crowdconnected-ips-sources"
binary "https://crowdconnected-public-maven.s3.eu-west-1.amazonaws.com/iOSSources/crowdconnected-shared-sources"
```

### Update carthage dependencies
Run the following command in terminal:
`carthage update --use-xcframeworks --no-use-binaries`

### Link dependecies to the project
On your application targets’ General settings tab, in the Embedded Binaries section, drag and drop each xcframework you nedd to use from the Carthage/Build folder on disk.
You will need:
```
AWSCognitoIdentityProvider.xcframework
AWSCognitoIdentityProviderASF.xcframework
AWSCore.xcframework
CrowdConnectedCore.xcframework
CrowdConnectedIPS.xcframework
CrowdConnectedShared.xcframework
```

### Consume the library
In your `AppDelegate` file or the main `App` file (for SwiftUI Apps) import the follwoing libraries:
```
import CrowdConnectedIPS
import CrowdConnectedCore
```

In your `application(_:didFinishLaunchingWithOptions:)` method (for UIKit apps) or `init()` method (for SwiftUI apps) add the following:
```
CrowdConnectedIPS.activate()
CrowdConnected.shared.start(appKey: "YOUR_APP_KEY", token: "YOUR_TOKEN", secret: "YOUR_SECRET") { deviceId, error in
   // Your code here ...
}
```

For stopping the library use:
```
CrowdConnected.shared.stop()
```

### Get Location permission

#### Navigation-only
If using the library for navigation-only, 'While in Use' location permission is required.
This can be done by adding a description in your `Info.plist` file as follows:
```
<key>NSLocationWhenInUseUsageDescription</key>	
<string>YOUR DESCRIPTIVE TEXT HERE</string>
```
In a suitable place in your app, ask the user for location permission.
```
let locationManager = CLLocationManager()
locationManager.requestWhenInUseAuthorization()
```

#### Background tracking and navigation

If using the library for background tracking, 'Always' location permission is required.
This can be done by adding two descriptions in your `Info.plist` file as follows:
```
<key>NSLocationWhenInUseUsageDescription</key>	
<string>YOUR DESCRIPTIVE TEXT HERE</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>	
<string>YOUR DESCRIPTIVE TEXT HERE</string>
```
In a suitable place in your app, ask the user for location permission.
```
let locationManager = CLLocationManager()
locationManager.requestAlwaysAuthorization()
```

### Use Indoor Navigation in your app
Library's navigation should start when the screen responsible for indoor navigation appears calling:
```
CrowdConnected.shared.startNavigation()
```
Library's navigation should stop when the screen responsible for indoor navigation disappears calling:
```
CrowdConnected.shared.stopNavigation()
```
Create a location provider:
```
class LocationProvider: CrowdConnectedDelegate {
    func didUpdateLocation(_ locations: [Location]) {
        // Use the location updates here
    }
}
```
Set the delegate for the SDK:
```
let locationProvider = LocationProvider()
CrowdConnected.shared.delegate = locationProvider
```
For stopping the location updates stream, either deinitialize the `locationProvider` object or reset the delegate as follows:
```
CrowdConnected.shared.delegate = nil
```
