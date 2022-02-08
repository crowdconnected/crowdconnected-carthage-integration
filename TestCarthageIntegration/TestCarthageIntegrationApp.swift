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

//    let testBT = TestBT()
    
    init() {
        CrowdConnectedIPS.activate()
        CrowdConnectedGeo.activate()
        CrowdConnectedCoreBluetooth.activate()

        CrowdConnected.shared.start(appKey: "testkey", token: "iosuser", secret: "Ea80e182$") { deviceId, error in
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
