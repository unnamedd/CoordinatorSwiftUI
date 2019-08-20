import SwiftUI

struct UserProfileView: View {
    var person: Person
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(person.name)
            Text("Age: \(person.age)")
            
            Divider()
            
            Text(person.biography)
        }
    }
}

#if DEBUG
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let firstPerson = People.makeDummy[0]
        let secondPerson = People.makeDummy[1]
        
        return Group {
            UserProfileView(person: firstPerson)
            UserProfileView(person: secondPerson)
        }
    }
}
#endif
