//
//  AddHabitView.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 25.02.2023.
//

import SwiftUI

struct AddHabitView: View {
    @State var read = false

    var body: some View {
        VStack{
            Button{
                    read.toggle()
                
                 
            } label: {
                            switch read {
                                case true:
                                    Image("readbubble").resizable()
                                        .scaledToFit()
                                        .frame(width: 200,height: 200)
                                case false:
                                    Image("readbubblex").resizable()
                                        .scaledToFit()
                                        .frame(width: 200,height: 200)
                            }
                 }
            
            
            
            
            Spacer()
            Image("dede2")
                .resizable()
                .scaledToFit()
                .frame(width: 300,height: 300)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: 0x131771))
       
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView()
    }
}
