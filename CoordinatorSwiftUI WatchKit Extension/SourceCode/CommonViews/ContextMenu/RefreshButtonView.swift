import SwiftUI

struct RefreshButtonView: View {
    var body: some View {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large)
        let compose = UIImage(systemName: "arrow.counterclockwise.circle", withConfiguration: configuration)!
        
        return ZStack {
            Image(uiImage: compose)
            Text("Refresh")
                .fontWeight(.bold)
        }
    }
}

struct RefreshButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshButtonView()
    }
}
