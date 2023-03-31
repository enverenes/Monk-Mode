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
    
    
    var body: some View {
        ZStack{
            
            VStack{
                
                HStack{
                    Text("Settings")
                }.frame(maxWidth: .infinity)
                    .background(AppColors.TopBar.topBarColor).padding(.bottom,5)
                    .foregroundColor(.white)
                    .font(.custom("Staatliches-Regular", size: 40))
                
               
                            
                
                Form{
                    Section("") {
                      
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
                    
                    Section("Community") {
                
                        HStack(spacing: 40){
                            Spacer()
                            Image("reddit")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            
                            Image("instagram")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            
                            Image("tiktok")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Spacer()
                        }
                        
                    }.foregroundColor(.white)
                       // .listRowBackground(Color.clear)
                       
                    
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
                 
            }.background(AppColors.Back.backgroundColor)
            .font(.custom("Staatliches-Regular", size: 20))
           
            if showAlert {
                CustomAlert(presentAlert: $showAlert)
            }
           
        }
       
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


struct CustomAlert: View {
    
    /// Flag used to dismiss the alert on the presenting view
    @Binding var presentAlert: Bool
    
    /// The alert type being shown
    @State var alertType: String = "Are You Sure ?"
    
    /// based on this value alert buttons will show vertically
    var isShowVerticalButtons = false
    
   
    
    let verticalButtonsHeight: CGFloat = 80
    
    var body: some View {
        
        ZStack {
            
            // faded background
            Color.black.opacity(0.75)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                
                if alertType != "" {
                    
                    // alert title
                    Text(alertType)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(height: 25)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                }

                // alert message
                Text("This action will restart your current cycle. \n (It will not restart your level)")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .font(.custom("Staatliches-Regular", size: 15))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,8)
                    .padding(.bottom, 16)
                    .minimumScaleFactor(0.5)
                
                Divider()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5)
                    .padding(.all, 0)
                
                if !isShowVerticalButtons {
                    HStack(spacing: 0) {
                        
                        // left button
                        if (!alertType.isEmpty) {
                            Button {
                               presentAlert = false
                            } label: {
                                Text("Cancel")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            }
                            Divider()
                                .frame(minWidth: 0, maxWidth: 0.5, minHeight: 0, maxHeight: .infinity)
                        }
                        
                      
                        NavigationLink {
                            ChooseHabitsView().onAppear{
                                UserDefaults.standard.isRestarting = true
                            }
                        } label: {
                            Text("Restart")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.pink)
                                .multilineTextAlignment(.center)
                                .padding(15)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                   
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 55)
                    .padding([.horizontal, .bottom], 0)
                    
                } else {
                    VStack(spacing: 0) {
                        Spacer()
                        Button {
                           
                        } label: {
                            Text(alertType)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        Spacer()
                        
                        Divider()
                        
                        Spacer()
                        Button {
                            
                        } label: {
                            Text(alertType)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.pink)
                                .multilineTextAlignment(.center)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        Spacer()
                        
                    }
                    .frame(height: verticalButtonsHeight)
                }
                
            }
            .frame(width: 200, height: 200)
            .background(
                Color.white
            )
            .cornerRadius(4)
        }.font(.custom("Staatliches-Regular", size: 20))
        .zIndex(2)
    }
}
