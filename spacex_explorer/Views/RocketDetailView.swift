import SwiftUI

struct RocketDetailView: View {
    let rocket: RocketEntity
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(rocket.name)
                    .font(.title)
                    .bold()
                if let desc = rocket.descriptionText {
                    Text(desc)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                if let height = rocket.height {
                    Text("Height: \(height, specifier: "%.1f") m")
                }
                if let diameter = rocket.diameter {
                    Text("Diameter: \(diameter, specifier: "%.1f") m")
                }
                if let mass = rocket.mass {
                    Text("Mass: \(mass) kg")
                }
                if let firstFlight = rocket.firstFlight {
                    Text("First Flight: \(firstFlight)")
                }
                if let success = rocket.successRatePct {
                    Text("Success Rate: \(success)%")
                }
                if let active = rocket.active {
                    Text("Active: \(active ? "Yes" : "No")")
                        .foregroundColor(active ? .green : .red)
                }
                if let cost = rocket.costPerLaunch {
                    Text("Cost per Launch: $\(cost)")
                }
            }
            .padding()
        }
        .navigationTitle(rocket.name)
    }
} 