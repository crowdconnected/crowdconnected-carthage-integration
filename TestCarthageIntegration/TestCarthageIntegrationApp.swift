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
                return
            }

            print(id)
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
        print("Got location update")
    }
}
