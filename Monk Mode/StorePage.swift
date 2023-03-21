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

    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [AppColors.BarInside.barInsideColor, AppColors.Back.backgroundColor]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.vertical)
            VStack(alignment: .center) {
                Spacer()
                
                        Text("We Make You a Monk in 6 Months")
                    .foregroundColor(.white)
                    .font(.custom("MetalMania-Regular", size: 25))
                            .bold()
                Spacer().frame(height: 40)
                
                VStack(spacing:10){
                    HStack{
                        Image(systemName: "checkmark.circle.fill")
                        Text("Choose your habits")
                        Spacer()
                    }.foregroundColor(.white)
                    HStack{
                        Image(systemName: "checkmark.circle.fill")
                        Text("Track your progress")
                        Spacer()
                    }.foregroundColor(.white)
                    HStack{
                        Image(systemName: "checkmark.circle.fill")
                        Text("Level Up and Share your Progress")
                        Spacer()
                    }
                    .foregroundColor(.white)
                    
                    
                }.padding(.leading, 20)
                Spacer().frame(height: 40)
                    
                        Divider()
                        ForEach(storeKit.storeProducts) {product in
                            if isPurchased {
                                NavigationLink {
                                    ChooseHabitsView()
                                } label: {
                                    Text("You are all set - Proceed").font(.custom("MetalMania-Regular", size: 25))
                                        .padding()
                                    
                                }.background(.white)
                                    .cornerRadius(25)
                                
                            }else{
                                VStack {
                                    Button(action: {
                                        // purchase this product
                                        Task { try await storeKit.purchase(product)
                                        }
                                    }) {
                                        Text("Start - 3 days free trial")
                                            .font(.custom("MetalMania-Regular", size: 25))
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
                NavigationLink {
                    MainContentView().onAppear{
                        UserDefaults.standard.welcomescreenShown = true
                    }
                } label: {
                    Text("Admin bypass").font(.custom("MetalMania-Regular", size: 15))
                        .padding(5)
                    
                }.background(.white)
                    .cornerRadius(25)
                
                Image("monkart1")
                    .resizable().scaledToFit()
                    .frame(width: 300, height: 300)
                
                    }.font(.custom("MetalMania-Regular", size: 20))
                    .padding()
        }.ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        
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
