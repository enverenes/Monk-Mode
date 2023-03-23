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

    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        
        ZStack{
            ContainerRelativeShape().fill()
            
            LazyVGrid(columns: columns,spacing: 5){
                ForEach(ActiveHabits.habits, id: \.self) { habit in
                    HStack{
                        Text(habit)
                        Spacer()
                        Image(systemName: "circle")
                    }.padding(.horizontal)
                }
            }.foregroundColor(.white)
        }
        .background(.indigo).grayscale(0.5)
        .background(.thickMaterial)
        
        
       
        
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
