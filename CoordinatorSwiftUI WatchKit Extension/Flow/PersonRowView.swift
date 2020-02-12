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
            
            Divider().frame(height: 1)
            
            HStack(alignment: .top) {
                Text("Bio: ").bold()
                +
                Text("\(person.biography)")
                    .font(.caption)
                    .fontWeight(.thin)
            }
        }
        .padding(.vertical, 5)
    }
}

// MARK: - Dummy

#if DEBUG

struct PersonRowView_Previews: PreviewProvider {
    static var previews: some View {
        let people = People.makeDummy
        
        return List(0..<5) { index in
            PersonRowView(person: people[index])
        }
    }
}

#endif
