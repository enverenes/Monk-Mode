//
//  HistoryView.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 25.02.2023.
//

extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}


import SwiftUI


struct HistoryView: View {
    @AppStorage("userLevel") var userLevel = "level1"
    var levels = ["level1" : "Young Blood", "level2" : "Seasoned Warrior", "level3" : "Elite Guardian", "level4": "Guard dog"]
    @State var selectedDate: Date = Date()
    @State var daysOfWeek = [ "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
   
    @State var levelTransitionAnim = false
    @State var showWeek = false
    @State var showWeekOP = false
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("Progress")
                }.frame(maxWidth: .infinity)
                    .background(Color(hex: 0xd76103)).padding(.vertical)
                    .foregroundColor(.white)
                    .font(.custom("MetalMania-Regular", size: 40))
                    
            }
            Button {
                withAnimation{
                    showWeek.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200), execute: {
                               withAnimation(.easeIn){
                                   showWeekOP.toggle()
                               }
                           })
                }
            } label: {
                Cycle()
            }
            Spacer().frame(height: 30)
            
            Divider().background(Color(.systemGray))
            if showWeek{
                VStack{
                    CustomCalendar(selectedDate: $selectedDate)
                    
                }.opacity(showWeekOP ? 1.0 : 0.0)
                .padding()
                
            }
           

            Spacer().frame(height: 30)
            Text("Levels")
                .foregroundColor(.white)
                .font(.custom("MetalMania-Regular", size: 30))
                .padding()
           
                Level(levelTransitionAnim: $levelTransitionAnim)
           
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: 0x131771))
       
    }
}

struct Cycle: View {
    
    let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd-MM-yyyy"
           return formatter
       }()
    
    @AppStorage("progress") var progress: Double = 0.0
    @AppStorage("daysPassed") var daysPassed: Double = 0.0
    @AppStorage("totalDays") var totalDays: Double = 3.0
    
    
    @AppStorage("startDateString") var startDateString: String = "01-01-2023"
    
    
    func countDays(dateString : String) {
        var startDate: Date = Date()
        let currentDate = Date()
               
                startDate = dateFormatter.date(from: dateString)!
                let calendar = Calendar.current
                let startOfDay = calendar.startOfDay(for: startDate)
                let endOfDay = calendar.startOfDay(for: currentDate)
                let components = calendar.dateComponents([.day], from: startOfDay, to: endOfDay)
        daysPassed = Double(components.day ?? 0)
            
        if (Double(daysPassed / totalDays) >= 1){
            progress = 1.0
        }else{
            progress = Double(daysPassed / totalDays)
        }
      
        
        
        }
        

    var body: some View {
        
        ZStack() {
            Circle()
                .stroke(
                    Color(.systemRed).opacity(0.5),
                    lineWidth: 20
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color(.systemRed),
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            
            Text((progress < 1.0) ? "Day \(Int(daysPassed))" : "Cycle Completed")
                .font(.custom("MetalMania-Regular", size: 25))
                .foregroundColor(.white)
        }.frame(width: 150.0, height: 150.0)
            .onAppear{
                countDays(dateString: startDateString)
            }
    }
        
    }

struct Level: View{
    var levels = ["level1" : "Young Blood", "level2" : "Seasoned Warrior", "level3" : "Elite Guardian", "level4": "Guard dog"]
    
    @AppStorage("userLevel") var userLevel = "level1"
    @State var levelAnim = false
   
    @Binding var levelTransitionAnim : Bool
    
    func constantColorCh(){
      
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                       // Back to normal with ease animation
                       withAnimation(.easeIn){
                           levelAnim.toggle()
                       }
                   })
        
    
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
               
                    ForEach(levels.keys.sorted(), id: \.self){ level in
                if userLevel == level {
                            
                    CurrentLevel(levelTransitionAnim: $levelTransitionAnim)
                            
                        }
                        else{
                            GeometryReader{ proxy in
                            VStack{
                                Text("\(levels[level]!)")
                                    .font(.custom("MetalMania-Regular", size: 20))
                                    .foregroundColor(.white).padding()
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                                Image("\(level)").resizable().scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .padding(.horizontal, 20)
                                    .padding(.bottom)
                            }
                           
                                
                        }.frame(width: 120, height: 180)
                                .background(.black)
                                .cornerRadius(20)
                                
                      
                        }
                        
                          }
               
            }.padding(.horizontal)
            
        } .onAppear{
            constantColorCh()
       }
        
    }
}



struct CurrentLevel: View{
    var levels = ["level1" : "Young Blood", "level2" : "Seasoned Warrior", "level3" : "Elite Guardian", "level4": "Guard dog"]
    
    @AppStorage("userLevel") var userLevel = "level1"
    @State var levelAnim = false
    @Binding var levelTransitionAnim : Bool
        
    
    func constantColorCh(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            // Back to normal with ease animation
            withAnimation(.easeIn){
                levelAnim.toggle()
            }
        })
        
        
    }
    
    func animateLevelTransition(){
        withAnimation{
            levelTransitionAnim.toggle()
            
        }
    }
    
    var body: some View {
        HStack{
            
            ForEach(levels.keys.sorted(), id: \.self){ level in
                if userLevel == level {
                    
                    GeometryReader{ proxy in
                        Button {
                            animateLevelTransition()
                        } label: {
                            VStack{
                                Text("\(levels[level]!)")
                                    .font(.custom("MetalMania-Regular", size: 20))
                                    .foregroundColor(.white).padding()
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                                Image("\(level)").resizable().scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .padding(.horizontal, 20)
                                    .padding(.bottom)
                            }
                        }
                        
                    }
                    .frame(width: 120, height: 180)
                    .background(self.levelAnim ? .green :.black)
                    .cornerRadius(20)
                    .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: levelAnim)
                   
                   
                    
                    
                }}
           
           
        }
        .onAppear{
                    constantColorCh()
                }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
