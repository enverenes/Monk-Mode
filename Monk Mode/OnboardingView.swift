//
//  OnboardingView.swift
//  MonkMode
//
//  Created by Enver Enes Keskin on 19.02.2023.
//

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: .top,
                endPoint: .bottom)
        )
            .mask(self)
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

import SwiftUI
import FirebaseAuth

struct OnboardingView: View {
    @AppStorage("userLevel", store: UserDefaults(suiteName: "group.monkmode")) var userLevel = "level1"
    func login(){
        Auth.auth().signInAnonymously() { (authResult, error) in
         
            print(authResult?.user.uid ?? "No user")
        }
        
    }
    
    
    
    var body: some View {
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [ Color(hex: 0x000000, opacity: 1.0),Color(hex: 0x220329, opacity: 1.0)]), startPoint: .top, endPoint: .bottom)
            
            VStack{
                
                Spacer().frame(height: 150)
                
                HStack{
                    Spacer()
                    Text("Do you have the power to start this journey?")
                        .gradientForeground(colors: [Color(white: 1.0, opacity: 0.4), Color(white: 1.0, opacity: 1)])
                        .padding().font(.custom("Staatliches-Regular", size: 45))
                        .frame(width: 250)
                        .minimumScaleFactor(0.4)
                    Spacer()
                }
               
                
                
                Spacer()
                
                NavigationLink {
                        ChooseHabitsView()
                } label: {
                    Text("Proceed")
                        .font(.custom("Staatliches-Regular", size: 27))
                        .frame(width: 200)
                        .padding(10)
                        .foregroundColor(Color(.systemBlue))
                        .background(.black)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.blue, lineWidth: 5))
                        .cornerRadius(5)
                    
                        .shadow(color: Color(.systemBlue), radius: 1, x: -4, y: 4)
                    
                    
                }
                Spacer()
                
                Image("dede1").resizable().frame(width: 350, height: 350)
                
            }
            
        }.background().ignoresSafeArea()
            .onAppear{
                login()
                userLevel = "level1"
                UserDefaults.standard.set(Date(), forKey: "launchDate")
            }
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
