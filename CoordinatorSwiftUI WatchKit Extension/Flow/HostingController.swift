import WatchKit
import Foundation
import SwiftUI

final class HostingController: WKHostingController<AnyView> {
    var coordinator: ApplicationCoordinator = ApplicationCoordinator()
    
    override var body: AnyView {
        return ApplicationView()
            .environmentObject(coordinator)
            .any
    }
}