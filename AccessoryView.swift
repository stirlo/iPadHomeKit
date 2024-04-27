import SwiftUI
import HomeKit

struct AccessoryView: View {
    let accessory: HMAccessory
    @State private var isPresentingDetails = false

    var body: some View {
        VStack {
            iconForAccessory(accessory)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding()
            Text(accessory.name)
                .font(.caption)
        }
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
        .onTapGesture {
            // Implement accessory toggle functionality here
        }
        .onLongPressGesture {
            isPresentingDetails = true
        }
        .sheet(isPresented: $isPresentingDetails) {
            AccessoryDetailsView(accessory: accessory)
        }
    }

    private func iconForAccessory(_ accessory: HMAccessory) -> Image {
        let serviceTypes = accessory.services.map { $0.serviceType }
        return Image(systemName: iconMapping(serviceType: serviceTypes.first ?? ""))
    }

    private func iconMapping(serviceType: String) -> String {
        switch serviceType {
        case HMServiceTypeLightbulb:
            return "lightbulb"
        case HMServiceTypeSwitch:
            return "switch.2"
        case HMServiceTypeThermostat:
            return "thermometer"
        case HMServiceTypeSpeaker:
            return "speaker.wave.2"
        case HMServiceTypeGarageDoorOpener:
            return "garage"
        default:
            return "questionmark.circle"
        }
    }
}
