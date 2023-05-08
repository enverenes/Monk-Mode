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
                  Image("backbutton").resizable().scaledToFit().frame(width: 30, height: 30)
                  .aspectRatio(contentMode: .fit)
                  .foregroundColor(.white)
                  
              }
          }
      }

    var body: some View {
        
        ZStack{
           // LinearGradient(gradient: Gradient(colors: [AppColors.BarInside.barInsideColor, AppColors.Back.backgroundColor]), startPoint: .top, endPoint: .bottom)
                       // .edgesIgnoringSafeArea(.vertical)
            
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x00000), Color(hex: 0x962b08)]), startPoint: .center, endPoint: .zero)
                       .edgesIgnoringSafeArea(.vertical)
            
           
                VStack(alignment: .center) {
                    Spacer().frame(minHeight: 70)
                    
                    Text("We Make You a Monk in 6 Months").minimumScaleFactor(0.8)
                        .foregroundColor(.white)
                        .font(.custom("Staatliches-Regular", size: 30))
                                .bold()
                    Spacer()
                    
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
                            Text("3 Days free trial")
                            Spacer()
                        }
                        .foregroundColor(.white)
                        
                     
                    }.padding(.leading, 20)
                    Spacer().frame(minHeight: 50)
                        
                            
                    
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
                                
                            }else{
                                VStack {
                                    Button(action: {
                                        // purchase this product
                                        Task { try await storeKit.purchase(product)
                                        }
                                    }) {
                                        Text("\(product.displayPrice) /month")
                                            .padding(20)
                                            .font(.custom("Staatliches-Regular", size: 25))
                                        
                                          
                                    }.background(.white)
                                        .cornerRadius(15)
                                    //Text("then").foregroundColor(.white)
                                    HStack(alignment: .center){
                                        
                                        Text("Monk Mode Temple Entry")
                                            .padding(5)
                                            .font(.custom("Staatliches-Regular", size: 15))
                                        

                                    }.foregroundColor(.white)
                                    
                                    HStack{
                                        
                                        Button("Restore Purchases", action: {
                                            Task {
                                                //This call displays a system prompt that asks users to authenticate with their App Store credentials.
                                                //Call this function only in response to an explicit user action, such as tapping a button.
                                                try? await AppStore.sync()
                                            }
                                        }).font(.custom("Staatliches-Regular", size: 15))
                                       
                                    }.padding(5)
                                }.onChange(of: storeKit.purchasedCourses) { course in
                                    Task {
                                        isPurchased = (try? await storeKit.isPurchased(product)) ?? false
                                    }
                                }
                            }
                            
                           
                            
                        }

                    }
                    
                    Spacer().frame(minHeight: 20)
                    
                        }.font(.custom("Staatliches-Regular", size: 20))
                        .padding(.bottom, 300)
            
           
                
            VStack{
                Spacer()
                ZStack{
                   
                    
                    HStack{
                        Image("monkart4")
                            .resizable().scaledToFill()
                            .frame(width: 200, height: 200)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    
                    Image("monkart3")
                        .resizable().scaledToFill()
                        .frame(width: 300, height: 280)
                        .zIndex(1)
                    HStack{
                        Spacer()
                        Image("monkart2")
                            .resizable().scaledToFill()
                            .frame(width: 200, height: 200)
                       
                    }
                    
                    
                    
                    
                    
                }.frame(maxWidth: .infinity)
                    .ignoresSafeArea()
            }
        }.edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        
    }
}



struct StorePage_Previews: PreviewProvider {
    static var previews: some View {
        StorePage()
    }
}
