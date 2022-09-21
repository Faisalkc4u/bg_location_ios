//
//  LocationUtil.swift
//  bglocation
//
//  Created by Faisal on 15/09/2022.
//

import Foundation
import CoreLocation
class LocationManager: NSObject, CLLocationManagerDelegate {

    static let shared = LocationManager()
    private var locationManager: CLLocationManager = CLLocationManager()
    private var requestLocationAuthorizationCallback: ((CLAuthorizationStatus) -> Void)?
    var currentStatus: CLAuthorizationStatus?
    public func requestLocationAuthorization() {
        self.locationManager.delegate = self
         if #available(iOS 14, *) {
             currentStatus = CLLocationManager().authorizationStatus
        } else {
            currentStatus = CLLocationManager.authorizationStatus()
        }
        print(currentStatus == .notDetermined)

        // Only ask authorization if it was never asked before
        guard currentStatus == .notDetermined else { return }

        // Starting on iOS 13.4.0, to get .authorizedAlways permission, you need to
        // first ask for WhenInUse permission, then ask for Always permission to
        // get to a second system alert
        if #available(iOS 13.4, *) {
            self.requestLocationAuthorizationCallback = { status in
                if status == .authorizedWhenInUse {
                    self.locationManager.requestAlwaysAuthorization()
                }
            }
            self.locationManager.requestWhenInUseAuthorization()
        } else {
            self.locationManager.requestAlwaysAuthorization()
        }
    }
    // MARK: - CLLocationManagerDelegate
    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
        self.requestLocationAuthorizationCallback?(status)
    }
}
