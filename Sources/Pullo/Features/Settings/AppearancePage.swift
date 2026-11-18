import SwiftUI

struct AppearancePage: View {
    @Environment(AppSettings.self) private var settings

    var body: some View {
        @Bindable var settings = settings
        Form {
            if PanelStyle.glassIsAvailable {
                Section {
                    PreviewPicker(options: PanelStyle.allCases, selection: $settings.panelStyle, title: \.title) { style in
                        PanelStylePreview(style: style)
                    }
                } header: {
                    Text("Style")
                } footer: {
                    Text("Glass follows your Liquid Glass setting, and turns solid when Reduce transparency is on.")
                }
            }
            Section {
                Toggle("Show CI progress on the notch", isOn: $settings.showsLiveCI)
                    .toggleStyle(.switch)
                if settings.showsLiveCI {
                    PreviewPicker(options: LiveCIPlacement.allCases, selection: $settings.liveCIPlacement, title: \.title) { placement in
                        LiveCIPreview(label: settings.liveCILabel, placement: placement)
                    }
                    PreviewPicker(options: LiveCILabel.allCases, selection: $settings.liveCILabel, title: \.title) { label in
                        LiveCIPreview(label: label, placement: settings.liveCIPlacement)
                    }
                }
            } footer: {
                Text(
                    "While checks run on your pull requests, the notch shows their progress. Below the notch keeps the menu bar icons beside it visible."
                )
            }
        }
    }
}
