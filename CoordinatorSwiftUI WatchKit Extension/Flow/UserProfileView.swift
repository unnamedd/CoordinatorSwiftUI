import SwiftUI

struct UserProfileView: View {
    var person: Person
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(person.name)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .bold()
                    .lineLimit(1)
            }
            
            Text("Age: ")
                .bold()
                .foregroundColor(Color.gray)
            +
            Text("\(person.age)")
                .font(.caption)
            
            Divider()
            
            Text("Bio: ")
                .bold()
                .foregroundColor(Color.gray)
            +
            Text("\(person.biography)")
                .font(.caption)
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
