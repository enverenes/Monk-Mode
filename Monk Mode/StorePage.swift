//
//  StorePage.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 7.03.2023.
//

import SwiftUI
import StoreKit

struct StorePage: View {
    @StateObject var storeKit = StoreKitManager()
    @State var isPurchased: Bool = false
   
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

      var btnBack : some View { Button(action: {
          self.presentationMode.wrappedValue.dismiss()
          }) {
              HStack {
                  Image(systemName: "arrow.left.circle").resizable().scaledToFit().frame(width: 30, height: 30)
                  .aspectRatio(contentMode: .fit)
                  .foregroundColor(.white)
                  
              }
          }
      }

    var body: some View {
        
        ZStack{
          
            
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x00000), Color(hex: 0x962b08)]), startPoint: .center, endPoint: .zero)
                       .edgesIgnoringSafeArea(.all)
            
           
            VStack(alignment: .center) {
                Spacer().frame(minHeight: 90, idealHeight:120)
                    
                    Text("We Make You a Monk in 6 Months").minimumScaleFactor(0.8)
                        .foregroundColor(.white)
                        .font(.custom("Staatliches-Regular", size: 30))
                                .bold()
                    Spacer().frame(maxHeight: 10)
                    
                    Text("- Monk Mode Full Access -").minimumScaleFactor(0.8)
                        .foregroundColor(.white)
                        .font(.custom("Staatliches-Regular", size: 20))
                                .bold()
                Spacer().frame( minHeight: 20, maxHeight: 50)
                    
                    VStack(spacing:10){
                        HStack{
                            Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                            Text("Choose your habits")
                            Spacer()
                        }.foregroundColor(.white)
                        HStack{
                            Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                            Text("Track your progress")
                            Spacer()
                        }.foregroundColor(.white)
                        HStack{
                            Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                            Text("Level Up and Share your Progress")
                            Spacer()
                        }
                        .foregroundColor(.white)
                        HStack{
                            Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                            Text("1 Month FREE trial")
                            Spacer()
                        }
                        .foregroundColor(.white)
                        
                     
                    }.padding(.leading, 20)
                    Spacer().frame(minHeight: 50, maxHeight: 100)
                        
                            
                    
                    if storeKit.isFetching{
                        Button {
                            
                        } label: {
                            Text("Loading..").font(.custom("Staatliches-Regular", size: 25))
                                .padding(20)
                        }
                        .background(.white)
                            .cornerRadius(15)

                    }else{
                        ForEach(storeKit.storeProducts) {product in
                            if isPurchased {
                                VStack(alignment: .center){
                                    
                                    NavigationLink {
                                        MainContentView()
                                    } label: {
                                        
                                            Text("You are all set - Proceed")
                                                .font(.custom("Staatliches-Regular", size: 25))
                                                .padding(15)
                                       
                                        
                                    }.background(.white)
                                        .cornerRadius(15)
                                        .simultaneousGesture(TapGesture().onEnded{
                                            UserDefaults.standard.welcomescreenShown = true
                                        })
                                    
                                    HStack(alignment: .center){
                                        
                                                 Link(destination: URL(string: "https://www.weinteractive.online/privacy.html")!) {
                                                     
                                                    Text("Privacy Policy")
                                                 }
                                               
                                            Divider()
                                            Link(destination: URL(string: "https://www.weinteractive.online/terms.html")!) {
                                                
                                               Text("Terms of Use")
                                            }
                                        

                                    }.foregroundColor(.white)
                                        .font(.custom("Staatliches-Regular", size: 15))
                                        .padding(.top,5)
                                    
                                    
                                    HStack{
                                        
                                        Button("Restore Purchases", action: {
                                            Task {
                                                //This call displays a system prompt that asks users to authenticate with their App Store credentials.
                                                //Call this function only in response to an explicit user action, such as tapping a button.
                                                try? await AppStore.sync()
                                            }
                                        }).font(.custom("Staatliches-Regular", size: 15))
                                       
                                    }.padding(5)
                                }.frame(maxHeight:150)

                                
                                
                            }else{
                                VStack(alignment: .center){
                                    Button(action: {
                                        // purchase this product
                                        Task { try await storeKit.purchase(product)
                                        }
                                    }) {
                                        VStack(spacing: 10){
                                            Text("Subscribe - \(product.displayPrice) /month")
                                                
                                                .font(.custom("Staatliches-Regular", size: 25))
                                            Text("Monthly subscription")
                                                
                                                .font(.custom("Staatliches-Regular", size: 15))
                                        }.padding(10)
                                        
                                        
                                          
                                    }.background(.white)
                                        .cornerRadius(15)
                                   
                                   
                                    HStack(alignment: .center){
                                        
                                                 Link(destination: URL(string: "https://www.weinteractive.online/privacy.html")!) {
                                                     
                                                    Text("Privacy Policy")
                                                 }
                                               
                                            Divider()
                                            Link(destination: URL(string: "https://www.weinteractive.online/terms.html")!) {
                                                
                                               Text("Terms of Use")
                                            }
                                        

                                    }.foregroundColor(.white)
                                        .font(.custom("Staatliches-Regular", size: 15))
                                        .padding(.top,5)
                                    
                                    
                                    HStack{
                                        
                                        Button("Restore Purchases", action: {
                                            Task {
                                                //This call displays a system prompt that asks users to authenticate with their App Store credentials.
                                                //Call this function only in response to an explicit user action, such as tapping a button.
                                                try? await AppStore.sync()
                                            }
                                        }).font(.custom("Staatliches-Regular", size: 15))
                                       
                                    }.padding(5)
                                }
                                .frame(maxHeight: 150)
                                .onChange(of: storeKit.purchasedCourses) { course in
                                    Task {
                                        isPurchased = (try? await storeKit.isPurchased(product)) ?? false
                                    }
                                }
                            }
                            
                           
                            
                        }

                    }
                    
                Spacer().frame(minHeight: 20,maxHeight: 200)
                ZStack{
                   
                    
                    HStack{
                        Image("monkart4")
                            .resizable().scaledToFill()
                            .frame(minWidth: 150, maxWidth: 160, minHeight: 150,  maxHeight: 160)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    
                    Image("monkart3")
                        .resizable().scaledToFill()
                        .frame(idealWidth: 200, maxWidth: 250, idealHeight:200,  maxHeight: 250)
                        .zIndex(1)
                    HStack{
                        Spacer()
                        Image("monkart2")
                            .resizable().scaledToFill()
                            .frame(idealWidth: 120, maxWidth: 150, idealHeight: 120,  maxHeight: 150)
                       
                    }
                    
               }
                     }.font(.custom("Staatliches-Regular", size: 20))
         
                       
            
         
                
          
        }.ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        
    }
}



struct StorePage_Previews: PreviewProvider {
    static var previews: some View {
        StorePage()
    }
}
