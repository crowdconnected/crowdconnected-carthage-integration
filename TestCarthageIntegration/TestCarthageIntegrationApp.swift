//  Created by TCode on 8/7/21.

import SwiftUI
import CrowdConnectedCore
import CrowdConnectedIPS
import CrowdConnectedGeo
import CrowdConnectedCoreBluetooth

import CoreLocation

@main
struct TestCarthageIntegrationApp: App {

    let locationProvider = LocationProvider()
    let locationManager = CLLocationManager()
    
    init() {
        CrowdConnectedIPS.activate()
        CrowdConnectedGeo.activate()
        CrowdConnectedCoreBluetooth.activate()

        CrowdConnected.shared.start(appKey: "testkey", token: "iosuser", secret: "Ea80e182$") { deviceId, error in
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
