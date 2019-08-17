import SwiftUI

struct ApplicationView: View {
    @ObservedObject var coordinator: ApplicationCoordinator
    
    var body: some View {
        coordinator.start()
    }
}

#if DEBUG
struct ApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationView(coordinator: ApplicationCoordinator())
    }
}
#endif
