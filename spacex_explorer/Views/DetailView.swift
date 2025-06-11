import SwiftUI

struct DetailView: View {
    let launch: LaunchEntity
    @StateObject var viewModel: LaunchesViewModel
    @State private var rocketEntity: RocketEntity? = nil
    @State private var showRocketDetail = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
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
                Button(action: {
                    Task {
                        if let entity = await viewModel.fetchRocketDetail(rocketId: launch.rocketId) {
                            rocketEntity = entity
                            showRocketDetail = true
                        }
                    }
                }) {
                    HStack {
                        Text("🚀 Rocket Details >")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .font(.headline)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 8)
            }
            .padding()
        }
        .navigationTitle(launch.name)
        .sheet(isPresented: $showRocketDetail) {
            if let rocketEntity = rocketEntity {
                RocketDetailView(rocket: rocketEntity)
            }
        }
    }
    

} 
