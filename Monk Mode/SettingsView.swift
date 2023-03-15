//
//  SettingsView.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 25.02.2023.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    var body: some View {
        VStack{
            
            HStack{
                Text("")
            }.frame(maxWidth: .infinity)
                .background(AppColors.TopBar.topBarColor).padding(.bottom,5)
                .foregroundColor(.white)
                .font(.custom("MetalMania-Regular", size: 40))
            Form{
                Section("") {
                    HStack{
                        Text("Join The Community")
                    }
                    HStack{
                        Button("Privacy & Terms of Use", action: {
                          
                        })
                    }
                    HStack{
                        Button("Restore Purchases", action: {
                            Task {
                                //This call displays a system prompt that asks users to authenticate with their App Store credentials.
                                //Call this function only in response to an explicit user action, such as tapping a button.
                                try? await AppStore.sync()
                            }
                        })
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .foregroundColor(AppColors.TopBar.topBarColor)
            
            Spacer().frame(height: 400)
            
        }.background(AppColors.Back.backgroundColor)
        .font(.custom("MetalMania-Regular", size: 20))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
