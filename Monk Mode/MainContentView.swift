//
//  MainContentView.swift
//  MonkMode
//
//  Created by Enver Enes Keskin on 19.02.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import AVFoundation
import SSSwiftUIGIFView
import WidgetKit


struct MainContentView: View {
    
    @Environment (\.requestReview) var requestReview
    
   
   
    @AppStorage("userLevel", store: UserDefaults(suiteName: "group.monkmode")) var userLevel = "level1"
    @AppStorage("userPoints") var userPoints : Int = 0
    @AppStorage("openedFirstTime") var openedFirstTime : Bool = true
    @AppStorage("rated") var rated : Bool = false
    
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
    
   
    @State var selectedTab : Int = 1
    @State var habits : [String] = []
    @State var selectedHabit : Int = 0
    
    
    @State var selectedHabitforalert : String = ""
   
    @AppStorage("userLevelProgress") var userLevelProgress : Double = 0.0
    @State var progressData = 0
    @State var progressDataDict : [String: Int] = ["Exercise" : 0 ,"Meditation" : 0,"Reading" : 0,"Healthy Diet" : 0,"Work" : 0, "No Social Media" : 0, "No Smoking" : 0, "No Drugs" : 0 , "No Alcohol" : 0, "No Fap" : 0 ]
    
    @State var animDict : [String: Bool] = ["Exercise" : false ,"Meditation" : false,"Reading" : false,"Healthy Diet" : false,"Work" : false, "No Social Media" : false, "No Smoking" : false, "No Drugs" : false , "No Alcohol" : false ,"No Fap" : false ]
    
    @State var streakDict : [String: Int] = ["Exercise" : 0 ,"Meditation" : 0,"Reading" : 0,"Healthy Diet" : 0,"Work" : 0, "No Social Media" : 0, "No Smoking" : 0, "No Drugs" : 0 , "No Alcohol" : 0 ,"No Fap" : 0 ]
    
    @State var levels = ["level1" : "Young Blood", "level2" : "Seasoned Warrior", "level3" : "Elite Guardian", "level4": "Master Slayer", "level5" : "Legendary Hero", "level6" : "Demigod of War", "level7" : "Immortal Champion", "level8" : "Divine Avatar", "level9" : "Titan of Power", "level99" : "God of Thunder"]
    
    @State var levelUp : Bool = false
    @State private var scale = 0.1
    @State private var showAlert = false
    @State private var levelUpLightningAnim : Bool = true
    @State private var readMoreExpanded : Bool = false
    @State var showTabBar : Bool = false
    @State private var showRatingPrompt = false
    @State var player: AVAudioPlayer?
    
    
    func getStreak(streakDict : [String : Int]) -> [String : Int]{
        
            var newStreakDict = streakDict
                var defaults = UserDefaults(suiteName: "group.monkmode")
            if let data = defaults!.data(forKey: "streakDict") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([String: Int].self, from: data) {
                    decoded.forEach { key, value in
                        newStreakDict[key] = decoded[key]
                    }
                   return newStreakDict
                }else{
                    return newStreakDict
                }
            }else {
                return newStreakDict
            }
            }
    
    
    func setStreak(streakDict : [String:Int]){
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(streakDict) {
            UserDefaults(suiteName: "group.monkmode")!.set(encoded, forKey: "streakDict")
                        }
        
    }

    func loadSound(click : Bool) {
        if let soundURL = Bundle.main.url(forResource: click ? "mouseclick" : "levelup_eff1", withExtension: ".wav") {
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
            } catch {
                print("Error loading sound file: \(error.localizedDescription)")
            }
        }
    }
    func playSound() {
           player?.play()
       }

    
    func addToHabitArray(habitArray : [Bool]){
        
        if(exercise && !habits.contains("Exercise")){
            habits.append("Exercise")
        }
        
        if(meditation && !habits.contains("Meditation")){
            habits.append("Meditation")
        }
        if(work && !habits.contains("Work")){
            habits.append("Work")
        }
        
        if(read && !habits.contains("Reading")){
            habits.append("Reading")
        }
        if(diet && !habits.contains("Healthy Diet")){
            habits.append("Healthy Diet")
        }
        if(nosocial && !habits.contains("No Social Media")){
            habits.append("No Social Media")
        }
        if(nosmoke && !habits.contains("No Smoking")){
            habits.append("No Smoking")
        }
        if(nodrugs && !habits.contains("No Drugs")){
            habits.append("No Drugs")
        }
        if(noalcohol && !habits.contains("No Alcohol")){
            habits.append("No Alcohol")
        }
        if(nofap && !habits.contains("No Fap")){
            habits.append("No Fap")
        }
        
    
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(habits) {
            UserDefaults(suiteName: "group.monkmode")!.set(encoded, forKey: "habitsActive")
                        }
    }
    
    
    
    
    func saveData(habit: String, habitStatus: Int) {
        let userId = Auth.auth().currentUser?.uid
        let date = Date().toString(format: "yyyy-MM-dd")
        let db = Firestore.firestore()
        
    
        
        let documentRef =  db.collection("user_data").document(userId!).collection(date).document("habitProgress")
        
        
        print(Auth.auth().currentUser!.uid)
        
        documentRef.getDocument {(document, error) in
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    if data.keys.contains(habit){
                        
                        documentRef.updateData([habit : habitStatus])
                        { error in
                            if let error = error {
                                print("Error saving data: \(error.localizedDescription)")
                            } else {
                                print("Data updated successfully")
                            }
                        }
                        
                    }else{
                        
                        documentRef.setData([habit : habitStatus], merge: true)  //THIS IS REWRITING THE FIELDS!!
                        { error in
                            if let error = error {
                                print("Error saving data: \(error.localizedDescription)")
                            } else {
                                print("Data saved successfully")
                            }
                        }
                    }
                    
                }
            }else{
                documentRef.setData([habit : habitStatus], merge: true)  //THIS IS REWRITING THE FIELDS!!
                { error in
                    if let error = error {
                        print("Error saving data: \(error.localizedDescription)")
                    } else {
                        print("Data saved successfully")
                    }
                }
                
            }
        }
    }
    
   @State var isDataFetchingCompleted = false
    
    func fetchData(){
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser!.uid // Assumes user is signed in
        let date = Date().toString(format: "yyyy-MM-dd")
        
        

        
      let docRef = db.collection("user_data").document(userId).collection(date).document("habitProgress")
            docRef.getDocument {(document, error) in
            if let document = document, document.exists {
                      let data = document.data()
                      if let data = data {
                          print("data", data)
                          for habit in habits {
                              progressDataDict[habit] = data[habit] as? Int ?? 0
                          }
                        
                      }
            }else{
                print("Document doesn't exists")
                
            }
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(progressDataDict) {
                    UserDefaults(suiteName: "group.monkmode")!.set(encoded, forKey: "progressData")
                                }
                withAnimation{
                    isDataFetchingCompleted = true
                }
               
        }
       
        
    }
    
    func getLevel(points: Int) -> Int {
        let levels = [3, 9, 18, 30, 45, 63, 84, 108, 135, 165]
        for i in 0..<levels.count {
            if points < levels[i] {
                if i == 0{
                    userLevelProgress = Double(points) / (Double(levels[i]))
                }else{
                    userLevelProgress = Double(points) / (Double(levels[i]) - Double(levels[i-1]))
                }
                
               
                return i + 1
            }
        }
        return levels.count  
    }
    
    func compareLevel(firstLevel : Int, secondLevel : Int) -> Bool {
        var levelUp = false
        
        if secondLevel > firstLevel {
            levelUp = true
            return levelUp
            
        }else{
            levelUp = false
            return levelUp
        }
    }
    
    
    func checkAskRequest(){
        if !rated {
            let launchDate = UserDefaults.standard.object(forKey: "launchDate") as? Date ?? Date()
            let daysSinceLaunch = Calendar.current.dateComponents([.day], from: launchDate, to: Date()).day

               if daysSinceLaunch == 1 {
                   DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                       showRatingPrompt = true
                       
                   }
                  
               }
        }
   
    }
    
   
    
    var body: some View {
        let habitDetail : [String: String] = ["Exercise" : exerciseDetail, "Meditation" : meditationDetail, "Work" : workDetail, "Reading": readDetail, "Healthy Diet" : dietDetail]

        ZStack{
            if selectedTab == 1 {
                VStack{
                    
                    HStack{
                        Text("Routine")
                    }.frame(maxWidth: .infinity)
                        .background(AppColors.TopBar.topBarColor).padding(.bottom,5)
                        .foregroundColor(.white)
                        .font(.custom("Staatliches-Regular", size: 40))
                        .blur(radius: levelUp ? 40 : 0)
                    
                ScrollView{
                    
                    
                    VStack(spacing: 7){
                        
                        
                        ForEach(habits, id: \.self) { habit in
                            let index = habits.firstIndex(of: habit) ?? 0
                            
                            
                            HStack{
                                
                                Button {
                                  
                                } label: {
                                    if (selectedHabit == index){
                                        VStack(spacing: 5){
                                            HStack{
                                                if habitDetail.keys.contains(habit){
                                                    Text((habitDetail[habit] ?? "" == "") ? habit : habitDetail[habit] ?? "")
                                                        .foregroundColor(.white)
                                                        .padding(.leading,30).font(.custom("Staatliches-Regular", size: 30)).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                                                }else{
                                                    Text(habit)
                                                        .foregroundColor(.white)
                                                        .padding(.leading,30).font(.custom("Staatliches-Regular", size: 30)).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                                                }
                                                
                                                Spacer()
                                                Image(userLevel)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 70)
                                                    .padding(5)
                                                
                                                
                                            }
                                            Streak(habit: habit, streakDict: $streakDict)
                                           
                                            
                                        }.background(animDict[habit]! ? .white : AppColors.Inside.insideColor)
                                            .cornerRadius(25)
                                            .animation(.easeInOut(duration: 0.5))
                                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                                                .scaleEffect(animDict[habit]! ? 1.2 : 1.0)
                                    }
                                    else{
                                        ClosedHabit(habit: habit, animDict: $animDict)
                                   }
                                    
                                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    withAnimation{
                                        selectedHabit = index
                                    }
                                })
                                .disabled(levelUp)
                                
                                Button {
                                    loadSound(click: true)
                                    playSound()
                                    
                                    print(progressDataDict)
                                    
                                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                        impactMed.impactOccurred()
                                    
                                    if progressDataDict[habit] == 2{
                                       
                                        streakDict[habit]! += 1
                                        setStreak(streakDict: streakDict)
                                        progressDataDict[habit] = 1
                                        
                                        userPoints += 1
                                        let firstLevel = getLevel(points: userPoints - 1)
                                        let secondLevel = getLevel(points: userPoints)
                                      
                                        userLevel = "level" + String(secondLevel)
                                        
                                        withAnimation {
                                            levelUp = compareLevel(firstLevel: firstLevel, secondLevel: secondLevel)
                                            animDict[habit]!.toggle()
                                            
                                            let deadline = DispatchTime.now() + .milliseconds(100)
                                            DispatchQueue.main.asyncAfter( deadline: deadline) {
                                                withAnimation{
                                                    animDict[habit]!.toggle()
                                                }
                                               
                                                   }
                                        }

                                    }else if progressDataDict[habit] == 1{
                                        showAlert = true
                                        selectedHabitforalert = habit

                                    }else{
                                        if streakDict[habit] != nil {
                                            streakDict[habit]! += 1
                                            setStreak(streakDict: streakDict)
                                        }
                                         
                                        
                                        progressDataDict[habit] = 1
                                        let firstLevel = getLevel(points: userPoints)
                                        userPoints += 1
                                        let secondLevel = getLevel(points: userPoints)
                                       
                                        userLevel = "level" + String(secondLevel)
                                        
                                        withAnimation {
                                            levelUp = compareLevel(firstLevel: firstLevel, secondLevel: secondLevel)
                                            animDict[habit]!.toggle()
                                            let deadline = DispatchTime.now() + .milliseconds(100)
                                            DispatchQueue.main.asyncAfter( deadline: deadline) {
                                                withAnimation{
                                                    animDict[habit]!.toggle()
                                                }
                                               
                                                   }
                                            
                                        }
                                    }
                                    
                                    saveData(habit: habit, habitStatus: progressDataDict[habit] ?? 0)
                                    WidgetCenter.shared.reloadAllTimelines()
                                } label: {
                                    if progressDataDict[habit] == 0 {
                                        
                                            Image("circle_test")
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                                .padding(20)
                                                .foregroundColor(.white)
                                       
                                       
                                    }else if progressDataDict[habit] == 1 {
                                        Image("checkmark_test")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .padding(20)
                                            .foregroundColor(.white)
                                        
                                    }else if progressDataDict[habit] == 2 {
                                        Image("xmark_test")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .padding(20)
                                            .foregroundColor(.white)
                                        
                                    }else{
                                        Image("circle_test")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.horizontal,10)
                                            .foregroundColor(.white)
                                    }
                                    
                                    
                                }.alert(isPresented: $showAlert) {
                                    Alert(title: Text("Uncheck Alert"), message: Text("Are you sure you want to uncheck?"), primaryButton: .default(Text("Yes"), action: {
                                    
                                        progressDataDict[selectedHabitforalert]  = 2
                                       
                                        if (userPoints - 1) < 0 {
                                            userPoints = 0
                                        }else{
                                            userPoints -= 1
                                        }
                                        userLevel = "level" + String(getLevel(points: userPoints))
                                        
                                        saveData(habit: selectedHabitforalert, habitStatus: progressDataDict[selectedHabitforalert] ?? 0)
                                       
                                        streakDict[selectedHabitforalert] = 0
                                        setStreak(streakDict: streakDict)
                                    }), secondaryButton: .cancel(Text("Cancel")))
                                        }
                                .disabled(levelUp)
                                
                            }
                            
                         }
                        NavigationLink {
                            ChooseHabitsView()
                        } label: {
                            Image(systemName: "plus.circle").resizable().foregroundColor(.white)
                                .frame(width: 45, height: 45).padding()
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            UserDefaults.standard.isRestarting = false
                            UserDefaults.standard.addingHabit = true
                                    })
                        .disabled(levelUp)
                        
                    }
                    Spacer().frame(height: 150)
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.custom("Staatliches-Regular", size: 25))
                    .blur(radius: levelUp ? 40 : 0)
                    
                    
                    Spacer().frame(height: 120)
                        
                }
                .background(AppColors.Back.backgroundColor)
                   
            }
            else if selectedTab == 0
            {
                HistoryView()
            }
            else if selectedTab == 2
            {
                SettingsView()
            }
           
            TabBar(selectedTab:  $selectedTab).opacity(showTabBar ? 1.0 : 0.0)
                .disabled(levelUp)
                .blur(radius: levelUp ? 15 : 0)
            
               
          
            if levelUp {
                ZStack{
                    
                    if levelUpLightningAnim{
                        VStack{
                            SwiftUIGIFPlayerView(gifName: "levelup")
                                
                        }
                        .scaledToFill()
                        .onAppear{
                            loadSound(click: false)
                            playSound()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                levelUpLightningAnim = false
                                
                            }
                        }
                    }else{
                        VStack{
                            Spacer()
                           
                            
                            Text("Level Up!").foregroundColor(.white)
                                .font(.custom("Staatliches-Regular", size: 40))
                            
                            VStack{
                                Text("\(levels[userLevel]!)")
                                    .font(.custom("Staatliches-Regular", size: 20))
                                    .foregroundColor(.white).padding(.horizontal)
                                    .padding(.top)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                                Image("\(userLevel)").resizable().scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .padding(.horizontal, 20)
                                   
                                Spacer()
                                
                                
                            }.frame(width: 120, height: 180)
                                .background(Color(hex: 0x32a852))
                                .cornerRadius(20)
                                .scaleEffect(scale)
                                .animation(.linear(duration: 0.7), value: scale)
                                        .onAppear{
                                            withAnimation{
                                                scale = 1.0
                                            }
                                        }
                            
                            Spacer()
                            VStack{
                                Text(readMoreExpanded ? DisciplineLevels(level: userLevel).getParagraph()[0] : "Read More..").font(.custom("Staatliches-Regular", size: 25))
                                    .padding(20)
                                    .foregroundColor(.white)
                                    .minimumScaleFactor(0.2)
                                
                            }.background(.black)
                                .cornerRadius(25)
                                .padding()
                                .onTapGesture {
                                    withAnimation{
                                        readMoreExpanded.toggle()
                                    }
                                    
                                }
                                
                           
                            Spacer()
                            HStack{
                                Button {
                                    withAnimation{
                                        levelUp = false
                                        levelUpLightningAnim = true
                                    }
                                    scale = 0.1
                                } label: {
                                    Text("Proceed")
                                        .font(.custom("Staatliches-Regular", size: 27))
                                        .frame(width: 200)
                                        .padding(10)
                                        .foregroundColor(Color(.systemGreen))
                                        .background(.black)
                                         .cornerRadius(5)
                                    
                                        
                                           

                                }

                               
                            }.frame(width: 300).padding()
                            
                            
                        }
                    }
                   
                    
                    
                    
                }
               
            }
            
           
            if !isDataFetchingCompleted{
                LoadingView()
            }
            
        }
        .onAppear{
            
            
            streakDict = getStreak(streakDict: streakDict)
            loadSound(click: true)
             addToHabitArray(habitArray: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial])
             fetchData()
            
            checkAskRequest()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                withAnimation{
                showTabBar = true
                }
                
            }
               
            UserDefaults.standard.welcomescreenShown = true
         
                
        }
       /* .alert(isPresented: $showRatingPrompt) {
            Alert(title: Text("Enjoying the app?"), message: Text("Please take a moment to rate it."), primaryButton: .default(Text("Rate App"), action: {
                requestReview()
                rated = true
            }), secondaryButton: .cancel())
        }*/
       
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(.stack)
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}

struct TabBar: View{
    @Binding var selectedTab : Int
    @State var tabAnim = false
    var body: some View{
        ZStack{
            VStack{
                Spacer()
                HStack(spacing: 30){
                    Image("s").resizable().frame(width: 70,height: 70)
                    Image("s").resizable().frame(width: 70,height: 70)
                    Image("s").resizable().frame(width: 70,height: 70)
                }
                .padding(0)
                .background(Color(.systemGray))
                .cornerRadius(35)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .foregroundColor(.black).padding(1)
            
            
            VStack{
                
            
                Spacer()
                HStack(spacing: 30){
                    ZStack{
                        
                        Circle()
                            .foregroundColor((selectedTab == 0) ? Color(hex: 0xd76103) :Color(.systemGray6))
                           .frame(width: 70, height: 70)
                        
                        Button {
                            withAnimation{
                                selectedTab = 0
                            }
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                        } label: {
                            Image("gong").resizable().frame(width: 60,height: 60)
                        }
                        
                       
                    }.offset(y: (selectedTab == 0) ? -20 : 0)
                   
                    ZStack{
                        
                        Circle()
                            .foregroundColor((selectedTab == 1) ? Color(hex: 0xd76103) :Color(.systemGray6))
                           .frame(width: 70, height: 70)
                    
                        Button {
                            withAnimation{
                                selectedTab = 1
                            }
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                        } label: {
                            
                            Image("map").resizable().frame(width: 60,height: 60)
                        }
                        }
                    .offset(y: (selectedTab == 1) ? -20 : 0)

                    ZStack{
                        Circle()
                            .foregroundColor((selectedTab == 2) ? Color(hex: 0xd76103) :Color(.systemGray6))
                           .frame(width: 70, height: 70)
                    Button {
                        withAnimation{
                            selectedTab = 2
                        }
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                    } label: {
                        Image("settings").resizable().frame(width: 60,height: 60)
                    }
                    }
                    .offset(y: (selectedTab == 2) ? -20 : 0)

                    
                }
                .padding(0)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .foregroundColor(.black).padding(1)
            
    
                
        
       
        }
        
    }
}

struct ClosedHabit: View{
    @AppStorage("userLevel", store: UserDefaults(suiteName: "group.monkmode")) var userLevel = "level1"
    @State var habit : String
    @Binding var animDict : [String : Bool]
    var body: some View{
        VStack{
            
            HStack{
                Text(habit)
                    .foregroundColor(.white)
                    .padding(.leading,30).font(.custom("Staatliches-Regular", size: 30)).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                Spacer()
                Image(userLevel)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .padding(5)
                
            }.background(animDict[habit]! ? .white : Color(hex: 0x231c15))
                    .cornerRadius(25)
                    .animation(.easeInOut(duration: 0.5))
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                    .scaleEffect(animDict[habit]! ? 1.2 : 1.0)
                   
            
            
        }
        
    }}

struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

struct Streak : View{
    @State var habit : String
    @Binding var streakDict : [String : Int]
    
    var body: some View{
        HStack{
            Text("Streak").padding(.horizontal,7).background(AppColors.BarInside.barInsideColor)
                .cornerRadius(25)
                .foregroundColor(.white)
            Spacer()
            Text((streakDict[habit] == 0) ? "No Streak" : "\(streakDict[habit] ?? 1)X Streak").padding(.horizontal,7)
        }
        .background(.white)
        .cornerRadius(25)
        .onAppear{
            print(streakDict, "oc")
        }
        
    }
}
