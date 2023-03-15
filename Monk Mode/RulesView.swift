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
            Text("Rules").font(.custom("MetalMania-Regular", size: 30)).foregroundColor(.white)
            .padding()
        Image("paper").resizable().scaledToFit()
        
        Spacer()
    }.background(AppColors.Back.backgroundColor)
    }
}



