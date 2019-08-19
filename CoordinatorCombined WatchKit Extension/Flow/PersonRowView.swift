import SwiftUI

struct PersonRowView: View {
    var person: Person
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(person.name)
                    .font(.subheadline)
                    .bold()
                    .padding(.bottom, 4)
                    .lineLimit(2)
                
                Spacer()
            }
            
            HStack(alignment: .top) {
                Text("Bio:  ").bold()
                +
                Text("\(person.biography)")
                    .font(.caption)
                    .fontWeight(.thin)
            }
        }
        .frame(height: 250)
    }
}

#if DEBUG
struct PersonRowView_Previews: PreviewProvider {
    static var previews: some View {
        let firstPerson = People.makeDummy[0]
        let secondPerson = People.makeDummy[1]
        
        return Group {
            PersonRowView(person: firstPerson)
            PersonRowView(person: secondPerson)
        }
    }
}
#endif
