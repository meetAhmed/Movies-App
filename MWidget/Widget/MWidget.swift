//
//  MWidget.swift
//  MWidget
//
//  Created by Ahmed Ali on 23/09/2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    let movieService = MoviesNetworkingServiceImpl()
    
    func placeholder(in context: Context) -> MEntry {
        MEntry(date: Date(), title: DeveloperPreview.instance.movie.title, image: UIImage(systemName: "photo.fill"))
    }

    func getSnapshot(in context: Context, completion: @escaping (MEntry) -> ()) {
        completion(MEntry(date: Date(), title: DeveloperPreview.instance.movie.title, image: UIImage(systemName: "photo.fill")))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            do {
                let response: MovieApiResponse = try await movieService.fetchData(api: APIConstructor(endpoint: .trending)).decode()
                guard let randomMovie = response.results.randomElement() else { return }
               
                // download image
                let imageData = try await movieService.fetchData(api: .init(endpoint: .custom(randomMovie.imageFullPath(type: .poster, baseUrl: Endpoint.widgetImageBaseUrl))))
                guard let image = UIImage(data: imageData) else { return }
                
                // create entry
                let entry = MEntry(date: Date(), title: randomMovie.title, image: image)
                let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: Date())
                let timeline = Timeline(entries: [entry], policy: .after(refreshDate!))
                completion(timeline)
            } catch {
                print("MWidget", error)
            }
        }
    }
}

struct MWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            if let image = entry.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            Text(entry.title)
                .poppins(.bold, 12)
        }
    }
}

struct MWidget: Widget {
    let kind: String = "MWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("MoviesApp Widget")
        .description("This widget shows a trending Movie.")
    }
}

#Preview(as: .systemSmall) {
    MWidget()
} timeline: {
    MEntry(date: Date(), title: DeveloperPreview.instance.movie.title, image: UIImage(systemName: "photo.fill"))
}
