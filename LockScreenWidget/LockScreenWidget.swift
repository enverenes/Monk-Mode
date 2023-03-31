//
//  LockScreenWidget.swift
//  LockScreenWidget
//
//  Created by Enver Enes Keskin on 2023-03-28.
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

struct LockScreenWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    @AppStorage("userLevelProgress", store: UserDefaults(suiteName: "group.monkmode")) var userLevelProgress : Double = 0.0
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily{
           
               
            case . accessoryCircular:
                Gauge(value: userLevelProgress) {
                    Image("level1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }.gaugeStyle(.accessoryCircular)
            case .accessoryRectangular:
                Gauge(value: userLevelProgress) {
                    Text(entry.date, style: .time)
                }.gaugeStyle(.accessoryLinear)
            
            default:
                Text("Not to implement")
        }
    }
}

struct LockScreenWidget: Widget {
    let kind: String = "LockScreenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LockScreenWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Level tracker")
        .description("Track your level easily.")
        .supportedFamilies([.accessoryInline, .accessoryCircular, .accessoryRectangular])
    }
}

struct LockScreenWidget_Previews: PreviewProvider {
    static var previews: some View {
        LockScreenWidgetEntryView(entry: SimpleEntry(date: Date()))
           
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("Circular")
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
            .previewDisplayName("Rectangular")
    }
}
