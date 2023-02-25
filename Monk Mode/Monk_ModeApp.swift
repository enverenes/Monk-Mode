//
//  Monk_ModeApp.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 24.02.2023.
//

import SwiftUI

extension UserDefaults {
    var welcomescreenShown: Bool {
        get{
            return (UserDefaults.standard.bool(forKey: "welcomeScreenShown") as Bool?) ?? false
        }
        set{
            return (UserDefaults.standard.set(newValue,forKey: "welcomeScreenShown") )
        }
    }
}

@main
struct Monk_ModeApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
