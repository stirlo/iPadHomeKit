import SwiftUI

struct SettingsView: View {
    @ObservedObject var homeKitManager: HomeKitManager

    var body: some View {
        NavigationView {
            List {
                ForEach(homeKitManager.accessories, id: \.uniqueIdentifier) { accessory in
                    HStack {
                        Text(accessory.name)
                        Spacer()
                        if homeKitManager.hiddenAccessoryIDs.contains(accessory.uniqueIdentifier) {
                            Button("Show") {
                                homeKitManager.toggleVisibility(of: accessory)
                            }
                        } else {
                            Button("Hide") {
                                homeKitManager.toggleVisibility(of: accessory)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Manage Accessories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        // Close settings
                    }
                }
            }
        }
    }
}
