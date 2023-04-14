//
//  ChooseTimeView.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 7.03.2023.
//

import SwiftUI

struct ChooseTimeView: View {
    @State var sliderValue = 30.0
    @AppStorage("daysPassed") var daysPassed: Double = 0.0

   
    
    let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd-MM-yyyy"
           return formatter
       }()
    
    @AppStorage("startDateString") var startDateString: String = "01-01-2023"
    
    func setStartDate(){
        
        startDateString = dateFormatter.string(from: Date())
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

      var btnBack : some View { Button(action: {
          self.presentationMode.wrappedValue.dismiss()
          }) {
              HStack {
                  Image("backbutton").resizable().scaledToFit().frame(width: 30, height: 30)
                  .aspectRatio(contentMode: .fit)
                  .foregroundColor(.white)
                  
              }
          }
      }
    
    var body: some View {
          ZStack{
            
              
              Color(hex: 0x2e55dd, opacity: 1)
            
            VStack{
                
                
               
               
                Spacer()
                Text("Choose your cycle duration")
                    .foregroundColor(.white)
                    .padding(.horizontal,60).font(.custom("Staatliches-Regular", size: 45))
                
                
                Spacer()
                CircularSlider(value: $sliderValue, minimumValue: 3, maximumValue: 180)
                Spacer()
                
                NavigationLink {
                    if UserDefaults.standard.isRestarting{
                        MainContentView()
                    }else{
                        StorePage()
                    }
                    
                    
                } label: {
                    Text("Proceed")
                        .font(.custom("Staatliches-Regular", size: 20))
                        .frame(width: 200)
                        .padding()
                        .foregroundColor(Color(.white))
                        .background(.red)
                        .cornerRadius(5)
                        .shadow(color: Color(.black), radius: 1, x: -4, y: 4)
                    
                    
                }.simultaneousGesture(TapGesture().onEnded{
                    
                    daysPassed = 0.0
                    
                })
                Spacer()
                
            }
            
        }.background().ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
            .onAppear{
                setStartDate()
                UserDefaults.standard.addingHabit = false
            }
            .navigationViewStyle(.stack)
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
                .foregroundColor(fillColor)
                .frame(width: 30, height: 30)
                .offset(x: 150, y: 0)
                .rotationEffect(.degrees(valueToProgress(value: value) * 360 - 90))
            
            Circle()
                .trim(from: 0, to: CGFloat(valueToProgress(value: value)))
                .stroke(fillColor
                        ,
                        style: StrokeStyle(
                            lineWidth: 20,
                            lineCap: .round
                        ))
                .rotationEffect(.degrees(-90))
                .frame(width: 300, height: 300)
                .gesture(DragGesture()
                    .onChanged({ value in
                        self.value = progressToValue(progress: progressForGesture(value: value.location))
                        totalDays = (self.value)
                    })
                )
            
           
            
            
            
            Text("\(Int(value)) days")
                .font(.custom("Staatliches-Regular", size: 45))
                .foregroundColor(.white)
                .font(.headline)
        }.onAppear{
            totalDays = 30
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
        let dy = Double(value.y -  CGFloat(centerY))
        let angle = atan2(dy, dx) + .pi/2 // add a 90-degree offset to account for the starting position of the slider
        var progress = angle / (2 * .pi)
        if progress < 0 {
            progress += 1
        }
        return progress
    }

}
