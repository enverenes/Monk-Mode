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
                    Image(systemName: "xmark").resizable().scaledToFit().frame(width: 25)
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
                        Text("Rule1: Do the habit +2 points")
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Text("Rule2: If you fail -1 points")
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Text("Rule3: Get more points to levelup")
                        Spacer()
                    }
                   
                   
                }.font(.custom("Staatliches-Regular", size: 15))
                    .padding(.horizontal, 30)
                    .foregroundColor(.white)
            }
       
        
        Spacer()
    }.background(AppColors.Back.backgroundColor)
    }
}



