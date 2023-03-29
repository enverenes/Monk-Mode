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
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily{
            case .accessoryInline:
                Gauge(value: 0.7) {
                    Text(entry.date, style: .time)
                }
            case . accessoryCircular:
                Gauge(value: 0.7) {
                    Text(entry.date, style: .time)
                }.gaugeStyle(.accessoryCircular)
            case .accessoryRectangular:
                Text("sa")
            
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
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.accessoryInline, .accessoryCircular, .accessoryRectangular])
    }
}

struct LockScreenWidget_Previews: PreviewProvider {
    static var previews: some View {
        LockScreenWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .accessoryInline))
            .previewDisplayName("Inline")
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("Circular")
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
            .previewDisplayName("Rectangular")
    }
}
