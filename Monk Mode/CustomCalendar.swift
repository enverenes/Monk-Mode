import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct CustomCalendar: View {
    
    @State var week = 0
    @Binding var selectedDate: Date
    
    @State var daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    func getToday(day : String) ->Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        let dayOfWeek = dateFormatter.string(from: Date()) // get the abbreviated day of the week for the current date
        
        return(day == dayOfWeek)
        // output: "Tue" (for Tuesday)

    }
    
    func getDaysOfMonth(week :Int) -> [Int] {
        var days : [Int] = []
        let calendar = Calendar.current
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        let dayOfWeek = dateFormatter.string(from: Date())
        
        let dayIndex = daysOfWeek.firstIndex(of: dayOfWeek) ?? 0
        var dateComponents = DateComponents()
        
        
        
        for (i, _) in daysOfWeek.enumerated() {
            
                dateComponents.day = (i-dayIndex) - week
                let otherDay = calendar.date(byAdding: dateComponents, to: Date()) ?? Date()
                let dayOfMonth = calendar.component(.day, from: otherDay)
                days.append(dayOfMonth)
           
        }
        
        
        return days
    }

    func getProgressfortheDay(day: Date) -> [Double]{
       
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser!.uid 
        let date = day.toString(format: "yyyy-MM-dd")
        
      let docRef = db.collection("user_data").document(userId).collection(date).document("habitProgress")
            docRef.getDocument {(document, error) in
            if let document = document, document.exists {
                      let data = document.data()
                      if let data = data {
                          print("data", data)
                          for item in data {
                              print(item.key,item.value)
                              
                          }
                        
                      }
            }else{
                print("Document doesn't exists")
                
            }
          
        }
        
        return [1.0]
    }


    
    var body: some View {
        VStack{
            
          
            HStack{
                Spacer()
                Button {
                    week += 7
                } label: {
                    Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                            .foregroundColor(.white)
                }
                Spacer()
                ForEach(Array(getDaysOfMonth(week: week).enumerated()), id: \.offset) { index , day in
                    
                    VStack{
                        Text(daysOfWeek[index])
                            .foregroundColor(.white)
                            .font(.custom("MetalMania-Regular", size: 20))
                        Text(String(day))
                            .foregroundColor(.white)
                            .font(.custom("MetalMania-Regular", size: 20))
                        
                    }
                    
                }
                Spacer()
                Button {
                    if(week - 7 >= 0){
                        week -= 7
                    }
                    
                } label: {
                    Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                }
                Spacer()
               
            }
                .padding(.horizontal,5)
            
           
            
            
                  
            
            
            
        }
    }
}

