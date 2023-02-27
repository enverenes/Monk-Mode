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
            let date = Date().toString(format: "yyyy-MM-dd") // Use an extension to format the date as a string
            let db = Firestore.firestore()
            
        let documentRef =  db.collection("user_data").document(userId!).collection(date).document("habitProgress")
        documentRef.setData([habit : habitStatus])
        { error in
                if let error = error {
                    print("Error saving data: \(error.localizedDescription)")
                } else {
                    print("Data saved successfully")
                }
            }
        }
    
    var body: some View {
       var habitDetail : [String: String] = ["Exercise" : exerciseDetail, "Meditation" : meditationDetail, "Work" : workDetail, "Reading": readDetail, "Healthy Diet" : dietDetail]

        ZStack{
            
            if selectedTab == 1 {
                ScrollView{
                    
                        
                    VStack(spacing: 7){
                        HStack{
                            Text("Routine")
                        }.frame(maxWidth: .infinity)
                            .background(Color(hex: 0xd76103)).padding(.vertical)
                            .foregroundColor(.white)
                            .font(.custom("MetalMania-Regular", size: 40))
                        ForEach(habits, id: \.self) { habit in

                        
                        HStack{
                            VStack(spacing: 5){
                                HStack{
                                    if habitDetail.keys.contains(habit){
                                        Text(habitDetail[habit] ?? "")
                                            .foregroundColor(.white)
                                            .padding(.leading,30).font(.custom("MetalMania-Regular", size: 30)).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                                    }else{
                                        Text(habit)
                                            .foregroundColor(.white)
                                            .padding(.leading,30).font(.custom("MetalMania-Regular", size: 30)).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                                    }
                                    
                                    Spacer()
                                    Image("level1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 70)
                                        .padding(5)
                                        
                                    
                                }
                                
                                HStack{
                                    Text("Streak").padding(.horizontal,7).background(Color(hex: 0x005f95))
                                        .cornerRadius(25)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text("3X Streak").padding(.horizontal,7)
                                }
                                 .background(.white)
                                    .cornerRadius(25)
                                
                            }.background(Color(hex: 0x231c15))
                                .cornerRadius(25)
                                .padding()
                            
                            
                            Button {
                                saveData(habit: habit, habitStatus: 0)
                            } label: {
                                
                            Image(systemName: "circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .padding(.trailing,40)
                                    .foregroundColor(.white)
                            }

                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                        NavigationLink {
                            AddHabitView()
                        } label: {
                            Image(systemName: "plus.circle").resizable().foregroundColor(.white)
                                .frame(width: 45, height: 45).padding()
                        }

                       
                }
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.custom("MetalMania-Regular", size: 25))
                    .background(Color(hex: 0x131771))
            }
            else if selectedTab == 0
            {
                HistoryView()
            }
            else if selectedTab == 2
            {
                SettingsView()
            }
            
            TabBar(selectedTab:  $selectedTab)
           
        }.onAppear{
            openedFirstTime = true
            if openedFirstTime{
                addToHabitArray(habitArray: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial])
                openedFirstTime = true
            }
           
        }
            .navigationBarBackButtonHidden(true)
    }
}

struct TabBar: View{
    @Binding var selectedTab : Int
    var body: some View{
        
            VStack{
                Spacer()
                HStack(spacing: 80){
                    Button {
                        selectedTab = 0
                    } label: {
                        Image(systemName: "clock.arrow.circlepath").resizable().frame(width: 40,height: 40)
                    }
                    
                        Button {
                            selectedTab = 1
                        } label: {
                            Image(systemName: "house").resizable().frame(width: 40,height: 40)
                        }
                    
                    Button {
                        selectedTab = 2
                    } label: {
                        Image(systemName: "gearshape").resizable().frame(width: 40,height: 40)
                    }
                    
                }
                .padding(.vertical, 10)
                .padding(.horizontal,15)
                .background()
                .cornerRadius(20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity).foregroundColor(.black).padding(.horizontal, 8).padding(.vertical,0)
            
                
        
       
        
        
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
