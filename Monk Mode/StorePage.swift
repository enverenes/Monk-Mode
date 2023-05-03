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
                    Spacer().frame(height: 100)
                    
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
                        
                        
                    }.padding(.leading, 20)
                    Spacer()
                        
                            Divider()
                            ForEach(storeKit.storeProducts) {product in
                                if isPurchased {
                                    NavigationLink {
                                        MainContentView()
                                    } label: {
                                        Text("You are all set - Proceed").font(.custom("Staatliches-Regular", size: 25))
                                            .padding()
                                        
                                    }.background(.white)
                                        .cornerRadius(25)
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
                                            Text("Start - 3 days free trial")
                                                .font(.custom("Staatliches-Regular", size: 25))
                                                .padding()
                                            
                                              
                                        }.background(.white)
                                            .cornerRadius(25)
                                        //Text("then").foregroundColor(.white)
                                        HStack(alignment: .center){
                                            
                                            CourseItem(storeKit: storeKit, isPurchased: $isPurchased, product: product)
                                            

                                        }.foregroundColor(.white)
                                    }
                                }
                                
                               
                                
                            }
                            
                    
                       
                            
                    Spacer()
                    
                        
                    
                    
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
                        .zIndex(3)
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

struct CourseItem: View {
    @ObservedObject var storeKit : StoreKitManager
    @Binding var isPurchased: Bool
    var product: Product
    
    var body: some View {
        VStack {
            if isPurchased {
                VStack{
                    
                    

                }
               
            }else{
                Text("then  \(product.displayPrice) /month")
                    .padding(5)
            }
        }
        .onChange(of: storeKit.purchasedCourses) { course in
            Task {
                isPurchased = (try? await storeKit.isPurchased(product)) ?? false
            }
        }
    }
}

struct StorePage_Previews: PreviewProvider {
    static var previews: some View {
        StorePage()
    }
}
