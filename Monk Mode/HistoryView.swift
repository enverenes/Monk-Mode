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
import FirebaseAuth
import FirebaseFirestore


struct HistoryView: View {
    @AppStorage("userLevel") var userLevel = "level1"
    var levels = ["level1" : "Young Blood", "level2" : "Seasoned Warrior", "level3" : "Elite Guardian", "level4": "Master Slayer", "level5" : "Legendary Hero", "level6" : "Demigod of War", "level7" : "Immortal Champion", "level8" : "Divine Avatar", "level9" : "Titan of Power", "level10" : "God of Thunder"]
    @State var selectedDate: Date = Date()
    @State var daysOfWeek = [ "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    
    @State var levelTransitionAnim = false
    @State var showWeek = false
    @State var showWeekOP = false
    @State var week : Int = 0
    @State var percentageForTheWeek : [Double] = []
    @State var daysOfWeekasDate: [Date] = []
    
    @State var isPresented :  Bool = false
    
    func getProgressfortheWeek(days: [Date], completion: @escaping ([Double]) -> Void) {
        var percentages = Array(repeating: 0.0, count: days.count)
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser!.uid
        
        let dispatchGroup = DispatchGroup()
        
        for (index, day) in days.enumerated() {
            dispatchGroup.enter()
            let date = day.toString(format: "yyyy-MM-dd")
            let finalDoc = db.collection("user_data").document(userId).collection(date).document("habitProgress")
            finalDoc.getDocument {(document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    if let data = data {
                        var x = 0.0
                        var y = 0.0
                        var z = 0.0
                        for item in data {
                            switch (item.value as? Int){
                                case 0:
                                    z += 1.0
                                    break
                                case 1:
                                    x += 1.0
                                    break
                                case 2:
                                    y += 1.0
                                    break
                                case .none:
                                    break
                                case .some(_):
                                    break
                            }
                        }
                        percentages[index] = (x)/(x+y+z)
                    }
                } else {
                    percentages.append(0.0)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(percentages)
        }
    }
    
    func getDaysforPrg(week :Int) -> [Date]{
        var daysOfWeekasDate : [Date] = []
        let calendar = Calendar.current
       
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "E"
        let dayOfWeek = dateFormatter.string(from: Date())
        print(dayOfWeek)
        let dayIndex = daysOfWeek.firstIndex(of: dayOfWeek) ?? 0
        var dateComponents = DateComponents()
        
        for (i, _) in daysOfWeek.enumerated() {
            
                dateComponents.day = (i-dayIndex) - week
                let otherDay = calendar.date(byAdding: dateComponents, to: Date()) ?? Date()
                daysOfWeekasDate.append(otherDay)
        }
        return daysOfWeekasDate
    }
    
    
    
    
    var body: some View {
        VStack{
            VStack{
                ZStack{
                   
                    
                    HStack{
                       Spacer()
                        
                        Text("Progress")
                        Spacer()
                        

                    }.frame(maxWidth: .infinity)
                        .background(AppColors.TopBar.topBarColor).padding(.bottom,5)
                        .foregroundColor(.white)
                        .font(.custom("MetalMania-Regular", size: 40))
                    
                    HStack{
                        Button {
                            withAnimation{
                                isPresented = true
                            }
                        
                        } label: {
                         Text("Rules").font(.custom("MetalMania-Regular", size: 20))
                        }.padding(.horizontal)
                       
                        Spacer()
                        

                    }.frame(maxWidth: .infinity)
                     .padding(.bottom, 5)
                    .foregroundColor(.white)
                    .font(.custom("MetalMania-Regular", size: 40))
                }
               
                    
            }
            
            TabView{
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
                
                PreviousCycles()
                
                
            }.frame(height: 200)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
                
            
            Spacer().frame(height: 10)
            
            Divider().background(Color(.systemGray))
            if showWeek{
                VStack{
                    CustomCalendar(week: $week, selectedDate: $selectedDate, percentageForTheWeek: $percentageForTheWeek)
                    
                }.opacity(showWeekOP ? 1.0 : 0.0)
                .padding(5)
                
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
        .background(AppColors.Back.backgroundColor)
        .onAppear{
             
            getProgressfortheWeek(days: getDaysforPrg(week: week)){ percentages in
                percentageForTheWeek.removeAll()
                percentageForTheWeek = percentages
            }
        }
        .sheet(isPresented: $isPresented) {
                    BottomSheetView(isPresented: $isPresented)
                       
                }
       
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
    
    
    func saveDataCycles(day : Int, progress: Double){
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser!.uid
        let docRef = db.collection("user_data").document(userId).collection("cycle").document("cycleinfo").setData([ "completed": true, "day": day , "progress" : progress], merge: false)
        
    }
    
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
            saveDataCycles(day: Int(totalDays), progress: progress)
            
        }else{
            progress = Double(daysPassed / totalDays)
        }
      
        
        
        }
        
    @State private var moveRight = false
    
    var body: some View {
        
        ZStack{
            HStack{
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white).padding(.trailing,20)
                    .offset(x: moveRight ? 0 : -10)
                    .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: true))
                                .onAppear {
                                    self.moveRight.toggle()
                                }
            }
            ZStack{
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
    }


struct CycleInfo: Hashable {
    var completed: Bool
    var days: Int
    var progress: Double
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(completed)
        hasher.combine(days)
        hasher.combine(progress)
    }
    
    static func == (lhs: CycleInfo, rhs: CycleInfo) -> Bool {
        return lhs.completed == rhs.completed && lhs.days == rhs.days && lhs.progress == rhs.progress
    }
}


struct PreviousCycles: View{
    
    
    @State var cycleInfos = [CycleInfo]()
    
    let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        
    ]
    
    

    func fetchDataCycles(completion: @escaping ([CycleInfo]) -> Void) {
        var cycles: [CycleInfo] = []
        
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser!.uid
        let docRef = db.collection("user_data").document(userId).collection("cycle").whereField("completed", isEqualTo: true)
        
        docRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion([])
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let cycle = CycleInfo(completed: (data["completed"] != nil), days: data["days"] as? Int ?? 3, progress: data["progress"] as? Double ?? 1.0 )
                    cycles.append(cycle)
                }
                completion(cycles)
            }
        }
    }

    
    
    
    
    
    
    var body: some View{
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 16) {
                ForEach(cycleInfos, id: \.self) { item in
                    VStack{
                        ZStack() {
                            Circle()
                                .stroke(
                                    Color(.systemRed).opacity(0.5),
                                    lineWidth: 10
                                )
                            Circle()
                                .trim(from: 0, to: 1.0)
                                .stroke(
                                    Color(.systemRed),
                                    style: StrokeStyle(
                                        lineWidth: 10,
                                        lineCap: .round
                                    )
                                )
                                .rotationEffect(.degrees(-90))
                                .animation(.easeOut, value: 1.0)
                            
                            
                        }.frame(width: 50.0, height: 50.0)
                        
                        Text("Completed %100")
                        Text("\(cycleInfos[0].days) days")
                    }
                    
                }
            }.font(.custom("MetalMania-Regular", size: 15))
            .foregroundColor(.white)
            .padding()
        }.onAppear{
            fetchDataCycles { fetchedCycles in
                    cycleInfos = fetchedCycles
                    print(cycleInfos)
                }
        }
    }
}

struct Level: View{
    var levels = ["level1" : "Young Blood", "level2" : "Seasoned Warrior", "level3" : "Elite Guardian", "level4": "Master Slayer", "level5" : "Legendary Hero", "level6" : "Demigod of War", "level7" : "Immortal Champion", "level8" : "Divine Avatar", "level9" : "Titan of Power", "level91" : "God of Thunder"]

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
            ScrollViewReader { proxy in
            HStack{
                
                ForEach(Array(levels.keys).sorted(by: <), id: \.self){ level in
                    if userLevel == level {
                        
                        CurrentLevel(levelTransitionAnim: $levelTransitionAnim)
                        
                    }
                    else{
                        GeometryReader{ proxy in
                            VStack{
                                Text("\(levels[level]!)")
                                    .font(.custom("MetalMania-Regular", size: 20))
                                    .foregroundColor(.white).padding(.horizontal)
                                    .padding(.top)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                                Image("\(level)").resizable().scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .padding(.horizontal, 20)
                                    .padding(.bottom)
                                Spacer()
                            }
                            
                            
                        }.frame(width: 120, height: 180)
                            .background(.black)
                            .cornerRadius(20)
                        
                        
                    }
                    
                }
                
            }.padding(.horizontal)
            .onAppear {
                                    constantColorCh()
                                    // Scroll to the current level on appear
                                    withAnimation {
                                        proxy.scrollTo(userLevel, anchor: .center)
                                    }
                                }
        }
        }
    
        
    }
}

struct CurrentLevel: View{
    var levels = ["level1" : "Young Blood", "level2" : "Seasoned Warrior", "level3" : "Elite Guardian", "level4": "Master Slayer", "level5" : "Legendary Hero", "level6" : "Demigod of War", "level7" : "Immortal Champion", "level8" : "Divine Avatar", "level9" : "Titan of Power", "level10" : "God of Thunder"]
    
    @AppStorage("userLevel") var userLevel = "level1"
    @AppStorage("userPoints") var userPoints : Int = 0
    @AppStorage("userLevelProgress") var userLevelProgress : Double = 0.0
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
    
    func getLevel(points: Int) -> Int {
        let levels = [3, 9, 18, 30, 45, 63, 84, 108, 135, 165]
        for i in 0..<levels.count {
            if points < levels[i] {
                userLevelProgress = Double(points) / Double(levels[i])
                return i + 1
            }
        }
        return levels.count  // If the number is greater than the maximum in the array, return the last index + 2 (which represents a hypothetical level 11)
    }

    
    var body: some View {
        HStack{
            
            ForEach(Array(levels.keys), id: \.self){ level in
                if userLevel == level {
                    
                    GeometryReader{ proxy in
                        Button {
                            animateLevelTransition()
                        } label: {
                            VStack{
                                Text("\(levels[level]!)")
                                    .font(.custom("MetalMania-Regular", size: 20))
                                    .foregroundColor(.white).padding(.horizontal)
                                    .padding(.top)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                                Image("\(level)").resizable().scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .padding(.horizontal, 20)
                                   
                                Spacer()
                                ProgressBar(progressValue: $userLevelProgress).frame(width: 100, height: 10)
                                Spacer()
                                // error
                                
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
                   userLevel = "level" + String(getLevel(points: userPoints))
                }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
