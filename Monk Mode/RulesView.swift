//
//  RulesView.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 2023-03-15.
//

import SwiftUI



struct BottomSheetView: View {
    @Binding var isPresented :  Bool
 var body: some View {
        VStack{
            HStack{
                Button {
                    withAnimation{
                        isPresented = false
                    }
                } label: {
                    Image(systemName: "xmark").resizable().scaledToFit().frame(width: 25).bold()
                }.padding(25)
                Spacer()
            }
            Text("Rules").font(.custom("Staatliches-Regular", size: 30)).foregroundColor(.white)
            .padding()
            
            
                ZStack{
                    GeometryReader{ geo in
                        Image("paper")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            
                        
                        VStack{
                            Spacer().frame(height: geo.size.height * 0.2)
                            ScrollView{
                                Spacer().frame(height: 20)
                                HStack{
                                    Spacer()
                                    Image("checkmark_test")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    Text(" +2 points")
                                    Spacer()
                                }
                                HStack{
                                    Spacer()
                                    Image("xmark_test")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                    Text(" -1 points")
                                    Spacer()
                                }
                                
                                Spacer().frame(height: 50)
                                HStack{
                                    Spacer()
                                    Text("Earn more points to level up").minimumScaleFactor(0.2)
                                    Spacer()
                                }.frame(width: 200)
                               
                               
                            }.font(.custom("Staatliches-Regular", size: 20))
                                .foregroundColor(.white)
                                .scaledToFit()
                    }.frame(maxWidth: .infinity)
                   
                    }
                   
                        
                }
            
            
       
        
        Spacer()
    }.background(AppColors.Back.backgroundColor)
    }
}



