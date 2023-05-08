//
//  SettingsView.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 25.02.2023.
//

import SwiftUI
import StoreKit
import FirebaseAuth
import FirebaseFirestore


struct SettingsView: View {
    
    @State private var showAlert = false
    @State private var showDeleteAlert = false
    @State private var isShowingMailView = false
    
    
  
    
    
    var body: some View {
        ZStack{
            
         
            
            VStack{
                
                HStack{
                    Text("Settings")
                }.frame(maxWidth: .infinity)
                    .background(AppColors.TopBar.topBarColor).padding(.bottom,5)
                    .foregroundColor(.white)
                    .font(.custom("Staatliches-Regular", size: 40))
                
               
                Spacer().frame(height: 30)
                            
                ScrollView{
                    VStack {
                        Divider()
                        
                             Link(destination: URL(string: "https://www.weinteractive.online/privacy.html")!) {
                                 
                                Text("Privacy Policy")
                             }.padding(5)
                            
                         
                        
                        Divider()
                        Link(destination: URL(string: "https://www.weinteractive.online/terms.html")!) {
                            
                           Text("Terms of Use")
                        }.padding(5)
                        
                        Divider()
                         HStack{
                             
                             Button("Restore Purchases", action: {
                                 Task {
                                     //This call displays a system prompt that asks users to authenticate with their App Store credentials.
                                     //Call this function only in response to an explicit user action, such as tapping a button.
                                     try? await AppStore.sync()
                                 }
                             })
                            
                         }.padding(5)
                        Divider()
                         HStack{
                             Button("Feedback") {
                                         self.isShowingMailView.toggle() // NOT AVAILABLE
                                     }
                                     .sheet(isPresented: $isShowingMailView) {
                                         MailView(isShowing: self.$isShowingMailView)
                                     }
                                 
                            
                         }.padding(5)
                        Divider()
                    }.frame(maxWidth: .infinity)
                    .background(.white)
                     .cornerRadius(10)
                     .padding()
                     
                  
                 
                 
                 .foregroundColor(.black)
                 
                VStack {
                     HStack {
                         Spacer()
                         Text("COMMUNITY").foregroundColor(.white)
                         Spacer()
                     }.frame(height: 20)
                     
                   
                     HStack(spacing: 40){
                         Spacer()
                         
                         Link(destination: URL(string: "https://www.reddit.com/r/monkmodeapp/")!) {
                             HStack{
                                 Image("reddit")
                                     .resizable()
                                     
                                     .frame(width: 50, height: 50)
                             }
                             
                         }
                         .frame(width: 50, height: 50).padding(.vertical)
                         Link(destination: URL(string: "https://www.instagram.com/monkmodeapplication/")!) {
                             HStack{
                                 Image("instagram")
                                     .resizable()
                                     .scaledToFit()
                                     .frame(width: 50, height: 50)
                             }
                             
                         }
                             .frame(width: 50, height: 50).padding(.vertical)
                         
                         Link(destination: URL(string: "https://www.tiktok.com/@monkmodeapplication")!) {
                            
                             HStack{
                                 Image("tiktok")
                                     .resizable()
                                     .scaledToFit()
                                     
                             }
                         }.frame(width: 50, height: 50)
                             .padding(.vertical)

                       
                         Spacer()
                     }.background(.white)
                         .cornerRadius(10)
                         .padding()
                     
                 }.foregroundColor(.white)
                     .padding(.top)
                     
                   
                    
                 
                 VStack {
             
                     HStack{
                         Spacer()
                         Button("Restart the Cycle", action: {
                           showAlert = true
                             
                         }).foregroundColor(.red)
                         Spacer()
                     }
                     .padding(.vertical, 5)

                     
                 }.background(.white)
                     .cornerRadius(10)
                     .padding()
                 
                 Spacer().frame(height: 100)
                }
            
                
                 
            }
            .font(.custom("Staatliches-Regular", size: 20))
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .topLeading
                )
            
            
           
            if showAlert {
                CustomAlert(presentAlert: $showAlert)
            }
            
            if showDeleteAlert{
                DeleteAlert(presentAlert: $showDeleteAlert)
            }
           
        }
        .navigationViewStyle(.stack)
        .preferredColorScheme(.light)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.Back.backgroundColor)
       
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
                            ChooseHabitsView()
                        } label: {
                            Text("Restart")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.pink)
                                .multilineTextAlignment(.center)
                                .padding(15)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            UserDefaults.standard.isRestarting = true
                            UserDefaults.standard.addingHabit = false
                                    })
                   
                        
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

struct DeleteAlert: View {
    
    /// Flag used to dismiss the alert on the presenting view
    @Binding var presentAlert: Bool
    
    /// The alert type being shown
    @State var alertType: String = "Are You Sure ?"
    
    /// based on this value alert buttons will show vertically
    var isShowVerticalButtons = false
    
   
    
    let verticalButtonsHeight: CGFloat = 80
    
    
    func deleteHistory(){
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser!.uid
        db.collection("user_data").document(userId).delete()
        
        
    }
    
    
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
                Text("This action will delete all history data. \n (It will not restart your level)")
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
                        
                      
                        Button {
                           deleteHistory()
                            presentAlert = false
                        } label: {
                            Text("Delete")
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
