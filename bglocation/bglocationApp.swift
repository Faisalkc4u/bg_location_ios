//
//  bglocationApp.swift
//  bglocation
//
//  Created by Faisal on 15/09/2022.
//

import SwiftUI
import UIKit
// no changes in your AppDelegate class
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        LocationManager.shared.startMySignificantLocationChanges()        
        return true
    }
}
@main
struct bglocationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
