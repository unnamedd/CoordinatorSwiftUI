import WatchKit
import Foundation
import SwiftUI

final class HostingController: WKHostingController<ContentView> {
    var coordinator: ApplicationCoordinator = ApplicationCoordinator()
    
    override var body: ContentView {
        ContentView(coordinator: coordinator)
    }
}
