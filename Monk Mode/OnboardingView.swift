//
//  OnboardingView.swift
//  MonkMode
//
//  Created by Enver Enes Keskin on 19.02.2023.
//


extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x6743CE), Color(hex: 0x6F1D1D, opacity: 1)]), startPoint: .top, endPoint: .bottom)
            
            VStack{
                
                Spacer().frame(height: 120)
                
                Text("Do you have the power to start this journey?").padding().font(.custom("Futura", size: 35))
                Spacer()
                
                NavigationLink {
                    ChooseHabitsView()
                } label: {
                    Text("Go on")
                    
                        .frame(width: 200)
                        .padding()
                        .foregroundColor(Color(.systemBlue))
                        .background(.black)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.blue, lineWidth: 5))
                        .cornerRadius(5)
                    
                        .shadow(color: Color(.systemBlue), radius: 1, x: -4, y: 4)
                    
                    
                }
                Spacer()
                
                
                
            }
            
        }.background().ignoresSafeArea()
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
