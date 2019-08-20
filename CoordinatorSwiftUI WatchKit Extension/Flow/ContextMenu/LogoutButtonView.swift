import SwiftUI

struct LogoutButtonView: View {
    var body: some View {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large)
        let compose = UIImage(systemName: "square.and.pencil", withConfiguration: configuration)!
        
        return ZStack {
            Image(uiImage: compose)
            Text("Logout")
                .fontWeight(.bold)
        }
    }
}

struct LogoutButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButtonView()
    }
}
