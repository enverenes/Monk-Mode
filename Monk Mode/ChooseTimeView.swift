//
//  ChooseTimeView.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 7.03.2023.
//

import SwiftUI

struct ChooseTimeView: View {
    @State var sliderValue = 30.0
    
    let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd-MM-yyyy"
           return formatter
       }()
    
    @AppStorage("startDateString") var startDateString: String = "01-01-2023"
    
    func setStartDate(){
        
        startDateString = dateFormatter.string(from: Date())
    }
    
    var body: some View {
          ZStack{
            
            LinearGradient(gradient: Gradient(colors: [ Color(hex: 0x000000, opacity: 1.0),Color(hex: 0x740329, opacity: 1.0)]), startPoint: .top, endPoint: .bottom)
            
            VStack{
                
                Spacer().frame(height: 120)
                
                Text("Choose your cycle duration")
                    .gradientForeground(colors: [Color(white: 1.0, opacity: 0.4), Color(white: 1.0, opacity: 1)])
                    .padding(.horizontal,60).font(.custom("MetalMania-Regular", size: 45))
                
                
                Spacer()
                CircularSlider(value: $sliderValue, minimumValue: 3, maximumValue: 180)
                Spacer()
                
                NavigationLink {
                    MainContentView()
                } label: {
                    Text("Proceed")
                        .font(.custom("MetalMania-Regular", size: 35))
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
            .navigationBarBackButtonHidden(true)
            .onAppear{
                setStartDate()
            }
    }
}

struct ChooseTimeView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseTimeView()
    }
}


struct CircularSlider: View {
    @AppStorage("totalDays") var totalDays: Double = 3.0

    @Binding var value: Double
    var minimumValue: Double
    var maximumValue: Double
    
    private let trackColor = Color.gray.opacity(0.3)
    private let fillColor = Color.blue
    private let thumbColor = Color.white
    
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(trackColor)
                .frame(width: 300, height: 300)
            
            Circle()
                .trim(from: 0, to: CGFloat(valueToProgress(value: value)))
                .stroke(fillColor, lineWidth: 20)
                .rotationEffect(.degrees(-90))
                .frame(width: 300, height: 300)
                .gesture(DragGesture()
                            .onChanged({ value in
                                self.value = progressToValue(progress: progressForGesture(value: value.location))
                                totalDays = (self.value)
                            })
                )
            
            Circle()
                            .foregroundColor(thumbColor)
                            .frame(width: 30, height: 30)
                            .offset(x: 150, y: 0)
                            .rotationEffect(.degrees(valueToProgress(value: value) * 360 - 90))
            
            
            Text("\(Int(value)) days")
                .font(.custom("MetalMania-Regular", size: 45))
                .foregroundColor(.white)
                .font(.headline)
        }
    }
    
    private func progressToValue(progress: Double) -> Double {
        let range = maximumValue - minimumValue
        return minimumValue + progress * range
    }
    
    private func valueToProgress(value: Double) -> Double {
        let range = maximumValue - minimumValue
        return (value - minimumValue) / range
    }
    
    private func progressForGesture(value: CGPoint) -> Double {
        let centerX = UIScreen.main.bounds.width / 2
        let centerY = 200 / 2
        let dx = Double(value.x - centerX)
        let dy = Double(value.y - CGFloat(centerY))
        let angle = atan2(dy, dx)
        var progress = angle / (2 * .pi)
        if progress < 0 {
            progress += 1
        }
        return progress
    }
}
