import SwiftUI

struct LiveCIPreview: View {
    let label: LiveCILabel
    let placement: LiveCIPlacement

    private static let notchWidth: CGFloat = 30
    private static let notchHeight: CGFloat = 32

    private var live: LiveCI {
        var pr = PullRequest.sample
        pr.checks = CheckProgress(done: 2, total: 3)
        var live = LiveCI(pr: pr, othersRunning: 0, label: label)
        live.placement = placement
        return live
    }

    var body: some View {
        let live = live
        let size = live.closedSize(around: CGSize(width: Self.notchWidth, height: Self.notchHeight))
        ZStack(alignment: .top) {
            PreviewWallpaper()
            VStack(spacing: 0) {
                switch placement {
                case .beside:
                    LiveCIView(live: live, notchWidth: Self.notchWidth)
                        .frame(height: Self.notchHeight)
                case .below:
                    Color.clear.frame(height: Self.notchHeight)
                    LiveCIView(live: live, notchWidth: Self.notchWidth)
                        .frame(height: LiveCI.dropHeight)
                }
            }
            .frame(width: size.width, height: size.height)
            .background(NotchShape(topRadius: 6, bottomRadius: 12).fill(Color.black))
            .scaleEffect(0.7, anchor: .top)
        }
    }
}
