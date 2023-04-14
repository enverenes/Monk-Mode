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
                Image("paper").resizable().scaledToFit()
                
                VStack{
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
                        Text("Get more points to levelup")
                        Spacer()
                    }
                   
                   
                }.font(.custom("Staatliches-Regular", size: 20))
                    .padding(.horizontal, 30)
                    .foregroundColor(.white)
            }
       
        
        Spacer()
    }.background(AppColors.Back.backgroundColor)
    }
}



