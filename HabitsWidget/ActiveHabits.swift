import Foundation
import FirebaseFirestore


struct ActiveHabits {
    static var progressDataDict : [String: Int] = ["Exercise" : 0 ,"Meditation" : 0,"Reading" : 0,"Healthy Diet" : 0,"Work" : 0, "No Social Media" : 0, "No Smoking" : 0, "No Drugs" : 0 , "No Alcohol" : 0, "No Fap" : 0 ]
    
    
    static var habitList: [String] = []
    
    static var habits: [String] {
        self.init()
        return self.habitList
    }
    
init(){
        var defaults = UserDefaults(suiteName: "group.monkmode")
        var exercise = defaults?.bool(forKey: "exercise") ?? false
        var meditation = defaults?.bool(forKey: "meditation") ?? false
        var work = defaults?.bool(forKey: "work") ?? false
        var read = defaults?.bool(forKey: "read") ?? false
        var diet = defaults?.bool(forKey: "diet") ?? false
        var nosocial = defaults?.bool(forKey: "nosocial") ?? false
        var nosmoke = defaults?.bool(forKey: "nosmoke") ?? false
        var nodrugs = defaults?.bool(forKey: "nodurgs") ?? false
        var noalcohol = defaults?.bool(forKey: "noalcohol") ?? false
        var nofap = defaults?.bool(forKey: "nofap") ?? false
        
        if(exercise){
            ActiveHabits.habitList.append("Exercise")
        }
        
        if(meditation){
            ActiveHabits.habitList.append("Meditation")
        }
        if(work){
            ActiveHabits.habitList.append("Work")
        }
        
        if(read){
            ActiveHabits.habitList.append("Reading")
        }
        if(diet){
            ActiveHabits.habitList.append("Healthy Diet")
        }
        if(nosocial){
            ActiveHabits.habitList.append("No Social Media")
        }
        if(nosmoke){
            ActiveHabits.habitList.append("No Smoking")
        }
        if(nodrugs){
            ActiveHabits.habitList.append("No Drugs")
        }
        if(noalcohol){
            ActiveHabits.habitList.append("No Alcohol")
        }
        if(nofap){
            ActiveHabits.habitList.append("No Fap")
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
                withAnimation{
                    isDataFetchingCompleted = true
                }
               
        }
       
        
    }
    
}

