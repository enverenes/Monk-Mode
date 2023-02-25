//
//  SpecifyhabitsView.swift
//  MonkMode
//
//  Created by Enver Enes Keskin on 20.02.2023.
//

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}


import SwiftUI



struct SpecifyhabitsView: View {
    
    
    @State var showPop : Bool = false
    
    @AppStorage("exerciseDetail") var exerciseDetail: String = ""
    @AppStorage("meditationDetail") var meditationDetail : String = ""
    @AppStorage("readDetail") var readDetail : String = ""
    @AppStorage("workDetail") var workDetail : String = ""
    @AppStorage("dietDetail") var dietDetail : String = ""
    
    
    @AppStorage("nosocial") var nosocial : Bool = false
    @AppStorage("noalcohol") var noalcohol : Bool = false
    @AppStorage("nosmoke") var nosmoke : Bool = false
    @AppStorage("nodrugs") var nodrugs : Bool = false
    @AppStorage("nofap") var nofap : Bool = false
    @AppStorage("exercise") var exercise : Bool = false
    @AppStorage("meditation") var meditation : Bool = false
    @AppStorage("read") var read : Bool = false
    @AppStorage("work") var work : Bool = false
    @AppStorage("diet") var diet : Bool = false
    
    
    @State var habits : [String] = []
    @State var customizableHabits : [String] = ["Exercise","Meditation","Reading","Healthy Diet","Work"]
    
    @State var habitDetail : String = ""
    
    func getHabitExample(habit: String) -> String{
        
        switch habit {
            case "Exercise":
                return "ex. Daily Gym"
            case "Meditation":
                return "ex. 5 Minute Meditation"
            case "Reading":
                return  "ex. Read 10 Pages"
            case "Healthy Diet":
                return "ex. Stick to Keto Diet"
            case "Work":
                return "ex. Learn Programming for 1 Hour"
            default:
                return  ""
        }
        
        
        
    }
    
    func getHabitDetail(habit: String)-> Binding<String>{
        
        switch habit{
            case "Exercise":
                return Binding(
                    get: { self.exerciseDetail },
                    set: { self.exerciseDetail = $0 }
                )
                
            case "Meditation":
                return Binding(
                    get: { self.meditationDetail },
                    set: { self.meditationDetail = $0 }
                )
            case "Reading":
                return Binding(
                    get: { self.readDetail },
                    set: { self.readDetail = $0 }
                )
            case "Healthy Diet":
                return Binding(
                    get: { self.dietDetail },
                    set: { self.dietDetail = $0 }
                )
            case "Work":
                return Binding(
                    get: { self.workDetail },
                    set: { self.workDetail = $0 }
                )
                
            default:
                
                return Binding(
                    get: { self.habitDetail },
                    set: { self.habitDetail = $0 }
                )
        }
    }
    
    func getHabitDetailPlaceholder(habit: String)-> String{
        
        switch habit{
            case "Exercise":
               return exerciseDetail
                
            case "Meditation":
                return meditationDetail
            case "Reading":
                return readDetail
            case "Healthy Diet":
                return dietDetail
            case "Work":
                return workDetail
                
            default:
                
                return habitDetail
        }
    }
        
        func addToHabitArray(habitArray : [Bool]){
            
            if(exercise){
                habits.append("Exercise")
            }
            
            if(meditation){
                habits.append("Meditation")
            }
            if(work){
                habits.append("Work")
            }
            
            if(read){
                habits.append("Reading")
            }
            if(diet){
                habits.append("Healthy Diet")
            }
            if(nosocial){
                habits.append("No Social Media")
            }
            if(nosmoke){
                habits.append("No Smoking")
            }
            if(nodrugs){
                habits.append("No Drugs")
            }
            if(noalcohol){
                habits.append("No Alcohol")
            }
            if(nofap){
                habits.append("No Fap")
            }
            
        }
        
        var body: some View {
            ZStack{
                
                
                
               // LinearGradient(gradient: Gradient(colors: [Color(hex: 0x6743CE), Color(hex: 0x6F1D1D, opacity: 1)]), startPoint: .top, endPoint: .bottom)
                
                Color(hex: 0x000000)
                
                ScrollView{
                    
                    
                    Spacer().frame(height: 50)
                    
                    Text("CUSTOMIZE YOUR HABITS").foregroundColor(.white)
                    
    
                        .padding()
                    Spacer()
                    
                    
                    VStack{
                        
                        ForEach(habits, id: \.self) { habit in
                            VStack{
                                
                                HStack{
                                    Text(habit) .font(.custom("MetalMania-Regular", size: 25))
                                    
                                }
                                if(customizableHabits.contains(habit)){
                                    TextField("", text: getHabitDetail(habit: habit))
                                        .autocapitalization(.sentences)
                                        .placeholder(when: getHabitDetailPlaceholder(habit: habit).isEmpty) {
                                            Text(getHabitExample(habit: habit)).foregroundColor(.white).padding(8)
                                        }
                                        .border(.white).cornerRadius(5).foregroundColor(Color(.white)).padding()
                                }
                                
                                
                            }.frame(width: 300)
                                .padding()
                                .foregroundColor(Color(.systemOrange))
                                .background(.black)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color(hex: 0xffffff), lineWidth: 5))
                                .cornerRadius(5)
                                .shadow(color: Color(hex: 0xffffff), radius: 1, x: -4, y: 4)
                                .padding(4)
                                .onAppear{
                                    getHabitDetail(habit: habit)
                                }
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                    Spacer().frame(height: 70)
                    
                    NavigationLink {
                       MainContentView()
                    } label: {
                        Text("Proceed")
                        
                            .frame(width: 200)
                            .padding()
                            .foregroundColor(Color(.systemBackground))
                            .background(.orange)
                            .overlay( /// apply a rounded border
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.blue, lineWidth: 5))
                            .cornerRadius(5)
                        
                            .shadow(color: Color(.systemBlue), radius: 1, x: -4, y: 4)
                        
                        
                    }
                    Spacer()
                    
                    
                    
                }.blur(radius: (showPop) ? 15:0 )
                    .font(.custom("MetalMania-Regular", size: 25))
                
                
                
            }.font(.system(size: 20))
            
                .background().ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
                .onAppear{
                    
                    addToHabitArray(habitArray: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial])
                }
            
        }
    
}

struct SpecifyhabitsView_Previews: PreviewProvider {
    static var previews: some View {
        SpecifyhabitsView()
    }
}