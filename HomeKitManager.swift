import Foundation
import HomeKit

class HomeKitManager: NSObject, ObservableObject, HMHomeManagerDelegate {
    var homeManager = HMHomeManager()
    @Published var accessories: [HMAccessory] = []
    @Published var hiddenAccessoryIDs: Set<UUID> = []

    override init() {
        super.init()
        homeManager.delegate = self
    }

    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        accessories = manager.homes.flatMap { $0.accessories }
    }

    func toggleVisibility(of accessory: HMAccessory) {
        if hiddenAccessoryIDs.contains(accessory.uniqueIdentifier) {
            hiddenAccessoryIDs.remove(accessory.uniqueIdentifier)
        } else {
            hiddenAccessoryIDs.insert(accessory.uniqueIdentifier)
        }
    }

    func isVisible(_ accessory: HMAccessory) -> Bool {
        !hiddenAccessoryIDs.contains(accessory.uniqueIdentifier)
    }
}
