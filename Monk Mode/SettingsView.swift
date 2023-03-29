//
//  SettingsView.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 25.02.2023.
//

import SwiftUI
import StoreKit


struct SettingsView: View {
    
    @State private var showAlert = false
    @State private var navigateToPage = false
    
    var body: some View {
        VStack{
            
            HStack{
                Text("Settings")
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
                Section("") {
            
                    HStack{
                        Spacer()
                        Button("Restart the Cycle", action: {
                          showAlert = true
                            
                        }).foregroundColor(.red)
                        Spacer()
                    }
                    
                }
            }
            .scrollContentBackground(.hidden)
            .foregroundColor(AppColors.TopBar.topBarColor)
            
            Spacer().frame(height: 100)
             NavigationLink(destination: ChooseHabitsView(), isActive: $navigateToPage) {
                                EmptyView()
                            }
        }.background(AppColors.Back.backgroundColor)
        .font(.custom("MetalMania-Regular", size: 20))
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Restart"), message: Text("Are you sure you want to restart?"), primaryButton: .default(Text("OK"), action: {
                UserDefaults.standard.isRestarting = true
                
                self.navigateToPage = true
            }), secondaryButton: .cancel(Text("Cancel")))
                }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
