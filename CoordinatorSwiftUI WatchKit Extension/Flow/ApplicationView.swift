import SwiftUI

struct ApplicationView: View {
    @ObservedObject var coordinator: ApplicationCoordinator
    
    var body: some View {
        coordinator.start()
    }
}

// MARK: - Dummy

#if DEBUG

struct ApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationView(
            coordinator: ApplicationCoordinator.makeDummy()
        )
    }
}

#endif
