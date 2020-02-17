import SwiftUI

protocol PeopleListViewDelegate: AnyObject {
    func peopleListViewDidFinishSession(_ view: PeopleListView)
    func peopleListView<Label>(_ view: PeopleListView, navigationLinkForPerson person: Person, @ViewBuilder viewBuilder: () -> Label) -> NavigationLink<Label, AnyView> where Label: View
}

struct PeopleListView: View {
    @EnvironmentObject
    private var peopleStore: PeopleStore
    
    weak var delegate: PeopleListViewDelegate?
    
    @ObservedObject
    private var viewModel: PeopleListViewModel
    
    init(viewModel: PeopleListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        contentView
            .navigationBarTitle(
                Text("Authors")
            )
            .edgesIgnoringSafeArea(
                [.leading, .bottom, .trailing]
            )
            .contextMenu {
                contextMenuView
            }
            .onAppear {
                if self.viewModel.state == .initial {
                    self.viewModel.loadPeople()
                }
            }
    }
    
    var contentView: some View {
        switch viewModel.state {
            case .loading, .error, .initial:
                return messageView.any
            
            case .list:
                return listView.any
        }
    }
    
    var listView: some View {
        return List {
            ForEach(self.viewModel.people) { person in
                self.delegate?.peopleListView(self, navigationLinkForPerson: person) {
                    PersonRowView(
                        person: person
                    )
                }
            }
            .onDelete(
                perform: self.viewModel.deletePerson
            )
        }
    }
    
    var contextMenuView: some View {
        VStack {
            Button(action: { self.delegate?.peopleListViewDidFinishSession(self) }) {
                LogoutButtonView()
            }
            
            Button(action: { self.viewModel.refreshList() }) {
                RefreshButtonView()
            }
        }
    }
    
    var messageView: some View {
        Text(viewModel.state.description)
    }
}

// MARK: - Dummy

#if DEBUG

final class PeopleListViewDelegateMock: PeopleListViewDelegate {
    private var isFinished = false
    
    func peopleListView<Label>(_ view: PeopleListView, navigationLinkForPerson person: Person, viewBuilder: () -> Label) -> NavigationLink<Label, AnyView> where Label : View {

        let peopleStore = PeopleStore.makeDummyFulfilled
        
        let userProfileViewModel = ProfileDetailViewModel(
            person: person,
            store: peopleStore
        )
        
        let userProfileView = ProfileDetailView(
            viewModel: userProfileViewModel
        ).any
        
        let navigationLink = NavigationLink(
            destination: userProfileView,
            label: viewBuilder
        )
        
        return navigationLink
    }
    
    func peopleListViewDidFinishSession(_ view: PeopleListView) {
        isFinished = true
    }
}

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        let delegateMock = PeopleListViewDelegateMock()
        
        var successPeopleListView = PeopleListView(
            viewModel: PeopleListViewModel.makeSuccessDummy
        )
        successPeopleListView.delegate = delegateMock
        
        var failurePeopleListView = PeopleListView(
            viewModel: PeopleListViewModel.makeFailureDummy
        )
        failurePeopleListView.delegate = delegateMock
        
        return Group {
            successPeopleListView
                .previewDisplayName("List View - Success")
            failurePeopleListView
                .previewDisplayName("List View - Failure")
        }
    }
}

#endif