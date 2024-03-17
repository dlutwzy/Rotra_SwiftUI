//
//  RotraApp.swift
//  Rotra
//
//  Created by wzy on 2023/7/22.
//

import SwiftUI

@main
struct RotraApp: App {
    @UIApplicationDelegateAdaptor(RotraAppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            MainTabView(engine: DisplayEngine.instance)
        }
    }
}

class RotraAppDelegate: NSObject, UIApplicationDelegate {
    
    var count = 1
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        Engine.instance.load()
        Engine.instance.prepare()
        Engine.instance.run()
        
        return true
    }
}
