//  Created by TCode on 8/7/21.

import SwiftUI
import CrowdConnectedCore
import CrowdConnectedIPS
import CoreLocation

@main
struct TestCarthageIntegrationApp: App {

    let locationProvider = LocationProvider()
    let locationManager = CLLocationManager()

    init() {
        CrowdConnectedIPS.activate()
        CrowdConnected.shared.start(appKey: "YOUR_APP_KEY", token: "YOUR_TOKEN", secret: "YOUR_SECRET") { deviceId, error in
            guard let id = deviceId else {
                // Check the error and make sure to start the library correctly
                return
            }

            // Library started successfully
        }

        CrowdConnected.shared.delegate = locationProvider
        locationManager.requestWhenInUseAuthorization()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class LocationProvider: CrowdConnectedDelegate {
    func didUpdateLocation(_ locations: [Location]) {
        // Use the location updates as you need
    }
}
