import SwiftUI

struct DetailView: View {
    let launch: LaunchEntity
    @StateObject var viewModel: LaunchesViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(launch.name)
                    .font(.title)
                    .bold()
                Text("Date: \(viewModel.formattedDate(launch.dateUTC))")
                if let success = launch.success {
                    Text("Status: \(success ? "Success" : "Failure")")
                        .foregroundColor(success ? .green : .red)
                }
                if let details = launch.details {
                    Text(details)
                        .padding(.top)
                }
                if let webcast = launch.webcast, let url = URL(string: webcast) {
                    Link("Webcast", destination: url)
                }
                if let article = launch.article, let url = URL(string: article) {
                    Link("Article", destination: url)
                }
                if let presskit = launch.presskit, let url = URL(string: presskit) {
                    Link("Press Kit", destination: url)
                }
            }
            .padding()
        }
        .navigationTitle(launch.name)
    }
    

} 
