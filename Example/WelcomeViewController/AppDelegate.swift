//
//  AppDelegate.swift
//  WelcomeViewController
//
//  Created by Dan Loewenherz on 02/26/2018.
//  Copyright (c) 2018 Dan Loewenherz. All rights reserved.
//

import UIKit
import WelcomeViewController
import LionheartExtensions

enum WelcomeItem {
    case library
    case watchNow
    case store
}

extension WelcomeItem: WelcomeCardProvider {
    var title: String {
        switch self {
        case .library: return "Library"
        case .watchNow: return "Watch Now"
        case .store: return "Store"
        }
    }
    
    var description: String {
        switch self {
        case .library: return "Find your purchases and rentals in one convenient place."
        case .watchNow: return "Start watching the TV shows and movies you love from all your supported apps."
        case .store: return "Get supported apps, discover new movie releases, and find popular TV shows."
        }
    }

    var imageName: String? {
        switch self {
        case .library: return "Categories"
        case .watchNow: return "Preview"
        case .store: return "Check"
        }
    }

    var color: UIColor? {
        return UIColor(.RGB(37, 185, 255))
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegateWithWindow {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        rootViewController = WelcomeViewController<WelcomeItem>(header: "Welcome to the TV app.", paragraph: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat", buttonText: "Continue", callouts: [.library, .watchNow, .store], delegate: nil)
        return true
    }
}
