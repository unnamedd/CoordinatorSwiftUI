import SwiftUI

struct PersonRowView: View {
    var person: Person
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(person.name)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)

                Spacer()
            }
            .padding(.vertical, 0)
            
            HStack(alignment: .top) {
                Text("Bio:  ").bold()
                +
                Text("\(person.biography)")
                    .font(.caption)
                    .fontWeight(.thin)
            }
        }
        .frame(alignment: .topLeading)
        .frame(height: 120)
    }
}

#if DEBUG
struct PersonRowView_Previews: PreviewProvider {
    static var previews: some View {
        let firstPerson = People.makeDummy[0]
        let secondPerson = People.makeDummy[3]
        
        return Group {
            PersonRowView(person: firstPerson)
            PersonRowView(person: secondPerson)
        }
    }
}
#endif
