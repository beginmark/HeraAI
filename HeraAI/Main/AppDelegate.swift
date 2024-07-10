//
//  AppDelegate.swift
//  HeraAI
//
//  Created by ali arvas on 8.07.2024.
//

import UIKit
import Firebase


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Firebase yapılandırmasını burada yapıyoruz
        FirebaseApp.configure()
        return true
    }
}
