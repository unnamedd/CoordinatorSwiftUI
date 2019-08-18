import SwiftUI

struct ApplicationView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator
    
    var body: some View {
        coordinator.start()
    }
}

#if DEBUG
struct ApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationView().environmentObject(ApplicationCoordinator())
    }
}
#endif
