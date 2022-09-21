//
//  LocationPermission.swift
//  bglocation
//
//  Created by user on 15/09/2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {

    static let shared = LocationManager()
    private var locationManager: CLLocationManager = CLLocationManager()
    private var requestLocationAuthorizationCallback: ((CLAuthorizationStatus) -> Void)?
    public func lastLocation(){
        locationManager.startUpdatingLocation()
        startMySignificantLocationChanges()
    }
    func startMySignificantLocationChanges() {
        locationManager.showsBackgroundLocationIndicator=true
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            // The device does not support this service.
            return
        }
        
        locationManager.distanceFilter = 500
        locationManager.pausesLocationUpdatesAutomatically=true
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.activityType = .otherNavigation
        locationManager.allowsBackgroundLocationUpdates=true;
        locationManager.startMonitoringSignificantLocationChanges()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        DataCenter().sendLocations(locValue)
           print("locations = \(locValue.latitude) \(locValue.longitude)")
       }
    public func requestLocationAuthorization() {
        self.locationManager.delegate = self
        var currentStatus:CLAuthorizationStatus?
        if #available(iOS 14, *) {
            currentStatus = CLLocationManager().authorizationStatus
        } else {
            currentStatus = CLLocationManager.authorizationStatus()
        }
        // Only ask authorization if it was never asked before
        guard currentStatus == .notDetermined else {
            lastLocation()
            return }

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
        DataCenter().erroReport("\(status.hashValue)")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       if let error = error as? CLError, error.code == .denied {
          print("There is some error")
           DataCenter().erroReport("locationError: \(error.errorUserInfo)")
          manager.stopMonitoringSignificantLocationChanges()
          return
       }
    }
}
