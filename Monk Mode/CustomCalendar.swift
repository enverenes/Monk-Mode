import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct CustomCalendar: View {
    
    @Binding var week : Int
    @Binding var selectedDate: Date
    
    
    @State var daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    @Binding var percentageForTheWeek : [Double]

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
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
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
        //print(dayOfWeek)
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
            
          
            HStack{
                Spacer()
                Button {
                    
                    week += 7
                getProgressfortheWeek(days: getDaysforPrg(week: week)){ percentages in
                    percentageForTheWeek.removeAll()
                    percentageForTheWeek = percentages
                }
                    print(percentageForTheWeek)
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
                            .font(.custom("Staatliches-Regular", size: 20))
                        ZStack{
                            Circle()
                                .stroke(
                                    Color(.systemRed).opacity(0.5),
                                    lineWidth: 5
                                )
                                .frame(width: 20.0, height: 20.0)
                            Circle()
                                .trim(from: 0, to: percentageForTheWeek[index])
                                .stroke(
                                    Color(.systemGreen),
                                    style: StrokeStyle(
                                        lineWidth: 5,
                                        lineCap: .round
                                    )
                                )
                                .frame(width: 20.0, height: 20.0)
                                .rotationEffect(.degrees(-90))
                                .animation(.easeOut, value: percentageForTheWeek[index])
                            
                            Text(String(day))
                                .foregroundColor(.white)
                                .font(.custom("Staatliches-Regular", size: 15))
                        }
                        
                        
                    }
                    
                }
                Spacer()
                Button {
                    if(week - 7 >= 0){
                        
                        week -= 7
                        getProgressfortheWeek(days: getDaysforPrg(week: week)){ percentages in
                            percentageForTheWeek.removeAll()
                            percentageForTheWeek = percentages
                        }

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
            
           
            
            
                  
            
            
            
        }.onAppear{
            
            
            
        }
    }
}

