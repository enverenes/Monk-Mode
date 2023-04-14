//
//  SplashScreenView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 29.01.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SplashScreenView: View {
   
    
    @State private var isActive = false
    @State private var logoSize = 0.8
    @State private var logoOp = 0.5
    
    
    
    @AppStorage("progress") var progress: Double = 0.0
    @AppStorage("daysPassed") var daysPassed: Double = 0.0
    @AppStorage("totalDays") var totalDays: Double = 3.0
    @AppStorage("startDateString") var startDateString: String = "01-01-2023"
    
    let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd-MM-yyyy"
           return formatter
       }()
    
    func saveDataCycles(day : Int, progress: Double){
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser!.uid
        let docRef = db.collection("user_data").document(userId).collection("cycle").document("cycleinfo").setData([ "completed": true, "day": day , "progress" : progress], merge: false)
        
    }
    
    func countDays(dateString : String) -> Double{
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
        
        return progress
       }
    
    var body: some View {
        
        NavigationStack{
            if(isActive){
                if(UserDefaults.standard.welcomescreenShown){
                    
                    if countDays(dateString: startDateString) >= 1.0 {
                        CycleCompleteView()
                    }else{
                        MainContentView()
                    }
                        
                    
                   }else{
                       OnboardingView()
                   }
            }
            else{
                VStack{
                    VStack{
                        Image("logo")
                        Text("Monk Mode").font(.custom("MetalMania-Regular", size: 40))
                    }.scaleEffect(logoSize)
                    .opacity(logoOp).onAppear(){
                       withAnimation(.easeIn(duration: 1.2)){
                            self.logoOp = 1.0
                            self.logoSize = 1.0
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.white).onAppear(){
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.8){
                        withAnimation(.easeInOut){
                            isActive = true
                        }
                        
                    }
            }
           
            }
               
        }.navigationViewStyle(.stack)
      
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

