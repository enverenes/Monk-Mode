//
//  LevelWidget.swift
//  LevelWidget
//
//  Created by Enver Enes Keskin on 2023-03-21.
//

import WidgetKit
import SwiftUI

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

struct LevelWidgetEntryView : View {
    var entry: Provider.Entry
    @State var levels = ["level1" : "Young Blood", "level2" : "Seasoned Warrior", "level3" : "Elite Guardian", "level4": "Master Slayer", "level5" : "Legendary Hero", "level6" : "Demigod of War", "level7" : "Immortal Champion", "level8" : "Divine Avatar", "level9" : "Titan of Power", "level99" : "God of Thunder"]

    @State var value: Double = 0.3
    @AppStorage("userLevelProgress", store: UserDefaults(suiteName: "group.monkmode")) var userLevelProgress : Double = 0.0

    var body: some View {
        
        var defaultData = UserDefaults(suiteName: "group.monkmode")
        ZStack{
            ContainerRelativeShape().fill(AppColors.TopBar.topBarColor).opacity(0.80)
            
            
           
            
            VStack(spacing: 2){
                Text(levels[defaultData?.string(forKey: "userLevel") ?? ""] ?? "").font(.custom(
                    "Futura",
                    fixedSize: 15))
                
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.white)
                
                
                Image(defaultData?.string(forKey: "userLevel") ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                
               
                    ZStack(alignment: .leading) {
                        Rectangle().frame(width: 100 , height: 15)
                            .opacity(0.8)
                            .foregroundColor(Color(UIColor.white))
                        
                        Rectangle().frame(width: 100 * (userLevelProgress) , height: 15)
                            .foregroundColor(Color(UIColor.systemCyan))
                            .animation(.linear)
                    }.cornerRadius(45.0)
                
            }.padding(5)
            
        }.opacity(0.90)
        
    }
}

struct LevelWidget: Widget {
    let kind: String = "LevelWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LevelWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Level Widget")
        .description("Simple widget to track your level.")
        .supportedFamilies([.systemSmall])
    }
}

struct LevelWidget_Previews: PreviewProvider {
    static var previews: some View {
        LevelWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
