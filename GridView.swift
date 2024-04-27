import SwiftUI

struct GridView: View {
    @ObservedObject var homeKitManager = HomeKitManager()
    @State private var showingSettings = false

    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(homeKitManager.accessories.filter(homeKitManager.isVisible), id: \.uniqueIdentifier) { accessory in
                        AccessoryView(accessory: accessory)
                            .contextMenu {
                                Button("Hide", action: { homeKitManager.toggleVisibility(of: accessory) })
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("HomeKit Accessories")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingSettings.toggle() }) {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView(homeKitManager: homeKitManager)
            }
        }
    }
}
