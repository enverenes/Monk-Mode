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

struct HistoryView: View {
    @State var selectedDate: Date = Date()
    var body: some View {
        VStack{
            VStack() {
                HStack{
                    Text("Progress")
                }.frame(maxWidth: .infinity)
                    .background(Color(hex: 0xd76103)).padding(.vertical)
                    .foregroundColor(.white)
                    .font(.custom("MetalMania-Regular", size: 40))
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                    
                    .padding(.horizontal)
                    .datePickerStyle(.graphical)
                    .colorScheme(.dark)
                    
                
                Divider()
            }
            .padding(.vertical, 20)
            
            
           Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: 0x131771))
       
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
