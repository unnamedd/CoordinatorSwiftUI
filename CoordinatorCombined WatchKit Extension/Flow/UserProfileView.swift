import SwiftUI

struct UserProfileView: View {
    var person: Person
    
    var body: some View {
        VStack {
            Text(person.name)
            Text("Age: \(person.age)")
        }
    }
}
