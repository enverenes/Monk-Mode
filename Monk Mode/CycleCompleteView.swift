//
//  CycleCompleteView.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 2023-03-27.
//

import SwiftUI

struct CycleCompleteView: View {
    @State var cyclecomplete: Double = 0.0
    @AppStorage("totalDays") var totalDays: Double = 3.0

    var body: some View {
        
        ZStack{
            Color.black

            VStack{
                Spacer()
                Text("MONK MODE \n CYCLE COMPLETED!")
                    .font(.custom("Staatliches-Regular", size: 30))
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 50)
                ZStack{
                    Circle()
                        .stroke(
                            Color(.systemRed).opacity(0.5),
                            lineWidth: 25
                        )
                    Circle()
                        .trim(from: 0, to: cyclecomplete)
                        .stroke(
                            Color(.systemRed),
                            style: StrokeStyle(
                                lineWidth: 25,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(.degrees(-90))
                        .animation(.easeOut(duration: 2.0), value: cyclecomplete)
                    
                    Text("\(Int(totalDays)) Days")
                        .font(.custom("Staatliches-Regular", size: 25))
                       
                    
                   
                }.frame(width: 200.0, height: 200.0)
                    .onAppear{
                        DispatchQueue.main.asyncAfter( deadline: .now() + .milliseconds(500)) {
                            withAnimation{
                                cyclecomplete = 1.0
                            }
                           
                               }
                    }
                Spacer().frame(height: 100)
                
                NavigationLink {
                    ChooseHabitsView()
                  
                } label: {
                    Text("Start a New Cycle")
                        .font(.custom("Staatliches-Regular", size: 20))
                        .frame(width: 200)
                        .padding()
                        .foregroundColor(Color(.systemBackground))
                        .background(Color(hex: 0x131771))
                        
                        .cornerRadius(5)
                    
                        .shadow(color: .white, radius: 2, x: 0, y: 2)
                    
                    
                } .simultaneousGesture(TapGesture().onEnded{
                    UserDefaults.standard.isRestarting = true
                })
                Spacer()
                
            }.foregroundColor(.white)
        }.ignoresSafeArea()
    }
}

struct CycleCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        CycleCompleteView()
    }
}
