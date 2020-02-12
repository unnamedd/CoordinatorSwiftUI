import WatchKit
import SwiftUI

final class HostingController: WKHostingController<ApplicationView> {
    var coordinator: ApplicationCoordinator = ApplicationCoordinator()
    
    override var body: ApplicationView {
        ApplicationView(
            coordinator: coordinator
        )
    }
}
