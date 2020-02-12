import SwiftUI

extension View {
    
    /// Convert any `View` into `AnyView`
    var any: AnyView {
        AnyView(self)
    }
}
