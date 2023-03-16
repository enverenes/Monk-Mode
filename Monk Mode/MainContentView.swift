//
//  MainContentView.swift
//  MonkMode
//
//  Created by Enver Enes Keskin on 19.02.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct MainContentView: View {
    @State var showTabBar : Bool = false
   
    @AppStorage("userLevel") var userLevel = "level1"
    @AppStorage("userPoints") var userPoints : Int = 0
    @AppStorage("openedFirstTime") var openedFirstTime : Bool = true
    
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
   
    @AppStorage("userLevelProgress") var userLevelProgress : Double = 0.0
    @State var progressData = 0
    @State var progressDataDict : [String: Int] = ["Exercise" : 0 ,"Meditation" : 0,"Reading" : 0,"Healthy Diet" : 0,"Work" : 0, "No Social Media" : 0, "No Smoking" : 0, "No Drugs" : 0 , "No Alcohol" : 0, "No Fap" : 0 ]
    
    
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
    
    
    func saveData(habit: String, habitStatus: Int) {
        let userId = Auth.auth().currentUser?.uid
        let date = Date().toString(format: "yyyy-MM-dd")
        let db = Firestore.firestore()
        
        let documentRef =  db.collection("user_data").document(userId!).collection(date).document("habitProgress")
        
        
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
        return levels.count  
    }
    
    var body: some View {
       var habitDetail : [String: String] = ["Exercise" : exerciseDetail, "Meditation" : meditationDetail, "Work" : workDetail, "Reading": readDetail, "Healthy Diet" : dietDetail]

        ZStack{
            
            if selectedTab == 1 {
                VStack{
                    
                    HStack{
                        Text("Routine")
                    }.frame(maxWidth: .infinity)
                        .background(AppColors.TopBar.topBarColor).padding(.bottom,5)
                        .foregroundColor(.white)
                        .font(.custom("MetalMania-Regular", size: 40))
                    
                ScrollView{
                    
                    
                    VStack(spacing: 7){
                        
                        
                        ForEach(habits, id: \.self) { habit in
                            let index = habits.firstIndex(of: habit) ?? 0
                            
                            
                            HStack{
                                
                                Button {
                                    withAnimation{
                                        selectedHabit = index
                                    }
                                } label: {
                                    if (selectedHabit == index){
                                        VStack(spacing: 5){
                                            HStack{
                                                if habitDetail.keys.contains(habit){
                                                    Text((habitDetail[habit] ?? "" == "") ? habit : habitDetail[habit] ?? "")
                                                        .foregroundColor(.white)
                                                        .padding(.leading,30).font(.custom("MetalMania-Regular", size: 30)).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                                                }else{
                                                    Text(habit)
                                                        .foregroundColor(.white)
                                                        .padding(.leading,30).font(.custom("MetalMania-Regular", size: 30)).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                                                }
                                                
                                                Spacer()
                                                Image(userLevel)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 70)
                                                    .padding(5)
                                                
                                                
                                            }
                                            
                                            HStack{
                                                Text("Streak").padding(.horizontal,7).background(AppColors.BarInside.barInsideColor)
                                                    .cornerRadius(25)
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text("3X Streak").padding(.horizontal,7)
                                            }
                                            .background(.white)
                                            .cornerRadius(25)
                                            
                                        }.background(AppColors.Inside.insideColor)
                                            .cornerRadius(25)
                                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                                    }
                                    else{
                                        
                                        
                                        ClosedHabit(habit: habit)
                                        
                                        
                                    }
                                    
                                }
                                
                                
                                
                                
                                Button {
                                    
                                    if progressDataDict[habit] == 2{
                                        progressDataDict[habit] = 1
                                        userPoints += 1
                                        print(userPoints)
                                        userLevel = "level" + String(getLevel(points: userPoints))

                                    }else if progressDataDict[habit] == 1{
                                        progressDataDict[habit]  = 2
                                       
                                        if (userPoints - 1) < 0 {
                                            userPoints = 0
                                        }else{
                                            userPoints -= 1
                                        }
                                        userLevel = "level" + String(getLevel(points: userPoints))

                                    }else{
                                        progressDataDict[habit] = 1
                                        userPoints += 1
                                        print(userPoints)
                                        userLevel = "level" + String(getLevel(points: userPoints))
                                    }
                                    
                                    saveData(habit: habit, habitStatus: progressDataDict[habit] ?? 0)
                                    
                                } label: {
                                    if progressDataDict[habit] == 0 {
                                        Image("circle")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.horizontal,10)
                                            .foregroundColor(.white)
                                    }else if progressDataDict[habit] == 1 {
                                        Image("checkmark")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.horizontal,10)
                                            .foregroundColor(.white)
                                        
                                    }else if progressDataDict[habit] == 2 {
                                        Image("xmark")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.horizontal,10)
                                            .foregroundColor(.white)
                                        
                                    }
                                    
                                    
                                }
                                
                                
                            }
                            
                         }
                        NavigationLink {
                            ChooseHabitsView()
                        } label: {
                            Image(systemName: "plus.circle").resizable().foregroundColor(.white)
                                .frame(width: 45, height: 45).padding()
                        }
                        
                        
                    }
                    Spacer().frame(height: 150)
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.custom("MetalMania-Regular", size: 25))
                    
                    Spacer().frame(height: 120)

            }.background(AppColors.Back.backgroundColor)
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
               
          
            
           
        }.onAppear{
           
            
            
            openedFirstTime = true
            if openedFirstTime{
                addToHabitArray(habitArray: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial])
                openedFirstTime = false
            }
            
              fetchData()
                
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                withAnimation{
                showTabBar = true
                    
                   
                }
                
            }
                   
                
        }
            .navigationBarBackButtonHidden(true)
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
                .cornerRadius(30)
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
    @AppStorage("userLevel") var userLevel = "level1"
    @State var habit : String
    var body: some View{
        VStack{
            
            HStack{
                Text(habit)
                    .foregroundColor(.white)
                    .padding(.leading,30).font(.custom("MetalMania-Regular", size: 30)).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                Spacer()
                Image(userLevel)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .padding(5)
                
            }.background(Color(hex: 0x231c15))
                .cornerRadius(25)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
            
            
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
