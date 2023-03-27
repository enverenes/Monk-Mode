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
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
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
    
    

    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        
        ZStack {
            ContainerRelativeShape().fill(Color(hex: 0x000000))
            VStack{
                Text("Active Habits")
                    .scaledToFill()
                    .font(.custom("Futura", size: 20))
                    .foregroundColor(Color(hex: 0xF6F1F1))
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(active.getActiveHabits(), id: \.self) { habit in
                        HStack {
                            Text(habit)
                                .scaledToFit()
                                .padding(.leading).padding(.vertical, 2)
                            Spacer()
                            
                            VStack{
                                if active.getProgress()[habit]  == 0 {
                                    Image(systemName: "circle")
                                        
                                        .foregroundColor(.white)
                                }else if active.getProgress()[habit]  == 1 {
                                    Image(systemName: "checkmark")
                                       
                                        .foregroundColor(.green)
                                    
                                }else if active.getProgress()[habit]  == 2 {
                                    Image(systemName:"xmark")
                                       
                                        .foregroundColor(.red)
                                    
                                }else{
                                    Image(systemName: "circle")
                                        
                                        .foregroundColor(.white)
                                }
                            }.padding(.trailing,5)
                          
                        }
                            
                        
                    }
                    
                }.background(Color(hex: 0x000000))
                    .cornerRadius(7)
                .foregroundColor(Color(hex: 0xF6F1F1))
            }
           
        }
        .font(.custom("Futura", size: active.getActiveHabits().count > 8 ? 10 : 15))
        
        
       
        
    }
}

struct HabitsWidget: Widget {
    let kind: String = "HabitsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HabitsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
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
