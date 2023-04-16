//
//  HabitsWidget.swift
//  HabitsWidget
//
//  Created by Enver Enes Keskin on 2023-03-22.
//

import WidgetKit
import SwiftUI
import FirebaseAuth

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
        
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct HabitsWidgetEntryView : View {
    var entry: Provider.Entry
    var active = ActiveHabits()
    let columns = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
    
   
    var body: some View {
        
        
        
        ZStack {
            ContainerRelativeShape().fill(Color(hex: 0x13005A))
            VStack{
                
               
                
                
                LazyVGrid(columns: columns, spacing: 5) {
                    
                    ForEach(active.getActiveHabits(), id: \.self) { habit in
                        
                        
                        HStack {
                            Spacer()
                            Text(habit)
                                .scaledToFit()
                                .padding(2)
                            Spacer()
                       }.background(active.getProgress()[habit]  == 1 ?  Color(.systemGreen):Color(.systemRed))
                            .cornerRadius(5)
                            .padding(.horizontal,5)
                        
                            
                        
                    }
                        
                        
                   
                    Spacer()
                }
                .cornerRadius(5)
                .foregroundColor(.white)
                
                
                
               
                
            }
           
        }
        .font(.custom("Impact", size: active.getActiveHabits().count > 8 ? 10 : 15))
        
        
        
        
       
        
    }
}

struct HabitsWidget: Widget {
    let kind: String = "HabitsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HabitsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Habit Table")
        .description("Track your active habits with this table.")
        .supportedFamilies([.systemMedium])
    }
}

struct HabitsWidget_Previews: PreviewProvider {
    static var previews: some View {
        HabitsWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}


extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
