import Foundation



struct ActiveHabits {
     var progressDataDict : [String: Int] = ["Exercise" : 0 ,"Meditation" : 0,"Reading" : 0,"Healthy Diet" : 0,"Work" : 0, "No Social Media" : 0, "No Smoking" : 0, "No Drugs" : 0 , "No Alcohol" : 0, "No Fap" : 0 ]
    
    
    static var habitList: [String] = []
    
    static var habits: [String] {
        self.init()
        return self.habitList
    }
    
func getActiveHabits() -> [String]{
        var defaults = UserDefaults(suiteName: "group.monkmode")
    if let data = defaults!.data(forKey: "habitsActive") {
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([String].self, from: data) {
           return decoded
        }else{
            return [""]
        }
    }else {
        return [""]
    }
    }
    
    
    func getProgress() ->[String : Int] {
        var defaults = UserDefaults(suiteName: "group.monkmode")
        if let data = defaults!.data(forKey: "progressData") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([String:Int].self, from: data) {
               return decoded
            }else{
                return ["" : 0]
            }
        }else {
            return ["" : 0]
        }
    }
   
    
}



extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
