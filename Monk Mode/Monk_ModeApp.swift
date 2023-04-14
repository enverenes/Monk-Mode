//
//  Monk_ModeApp.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 24.02.2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension UserDefaults {
    var welcomescreenShown: Bool {
        get{
            return (UserDefaults.standard.bool(forKey: "welcomeScreenShown") as Bool?) ?? false
        }
        set{
            return (UserDefaults.standard.set(newValue,forKey: "welcomeScreenShown") )
        }
    }
    
    var isRestarting: Bool {
        get{
            return (UserDefaults.standard.bool(forKey: "isRestarting") as Bool?) ?? false
        }
        set{
            return (UserDefaults.standard.set(newValue,forKey: "isRestarting"))
        }
    }
    var addingHabit: Bool {
        get{
            return (UserDefaults.standard.bool(forKey: "addingHabit") as Bool?) ?? false
        }
        set{
            return (UserDefaults.standard.set(newValue,forKey: "addingHabit"))
        }
    }
}

@main
struct Monk_ModeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            SplashScreenView().defaultAppStorage(UserDefaults(suiteName: "group.monkmode")!)
        }
    }
}
