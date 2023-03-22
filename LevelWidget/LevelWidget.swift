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

struct LevelWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
        var defaultData = UserDefaults(suiteName: "group.monkmode")
        ZStack{
            ContainerRelativeShape().fill(AppColors.TopBar.topBarColor)
            
            VStack{
                Text(defaultData?.string(forKey: "userLevel") ?? "")
                Image("level1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            }
            
        }
        
    }
}

struct LevelWidget: Widget {
    let kind: String = "LevelWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LevelWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct LevelWidget_Previews: PreviewProvider {
    static var previews: some View {
        LevelWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
