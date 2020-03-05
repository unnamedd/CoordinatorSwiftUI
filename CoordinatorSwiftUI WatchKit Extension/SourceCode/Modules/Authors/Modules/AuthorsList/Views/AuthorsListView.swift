import SwiftUI

protocol AuthorsListViewDelegate: AnyObject {
    func authorsListViewDidFinishSession(_ view: AuthorsListView)
    func authorsListView<Label>(_ view: AuthorsListView, navigationLinkForAuthor author: Author, @ViewBuilder viewBuilder: () -> Label) -> NavigationLink<Label, AnyView> where Label: View
}

struct AuthorsListView: View {
    @EnvironmentObject
    private var authorsStore: AuthorsStore
    
    weak var delegate: AuthorsListViewDelegate?
    
    @ObservedObject
    private var viewModel: AuthorsListViewModel
    
    init(viewModel: AuthorsListViewModel) {
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
                    self.viewModel.loadAuthors()
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
            ForEach(self.viewModel.authors) { person in
                self.delegate?.authorsListView(self, navigationLinkForAuthor: person) {
                    AuthorRowView(
                        author: person
                    )
                }
            }
            .onDelete(
                perform: self.viewModel.deleteAuthor
            )
        }
    }
    
    var contextMenuView: some View {
        VStack {
            Button(action: { self.delegate?.authorsListViewDidFinishSession(self) }) {
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

final class AuthorsListViewDelegateMock: AuthorsListViewDelegate {
    private var isFinished = false
    
    func authorsListView<Label>(_ view: AuthorsListView, navigationLinkForAuthor author: Author, viewBuilder: () -> Label) -> NavigationLink<Label, AnyView> where Label : View {

        let authorsStore = AuthorsStore.makeDummyFilled
        
        let userProfileViewModel = AuthorProfileDetailViewModel(
            author: author,
            store: authorsStore
        )
        
        let userProfileView = AuthorProfileDetailView(
            viewModel: userProfileViewModel
        ).any
        
        let navigationLink = NavigationLink(
            destination: userProfileView,
            label: viewBuilder
        )
        
        return navigationLink
    }
    
    func authorsListViewDidFinishSession(_ view: AuthorsListView) {
        isFinished = true
    }
}

struct AuthorsListView_Previews: PreviewProvider {
    static var previews: some View {
        let delegateMock = AuthorsListViewDelegateMock()
        
        var successAuthorsListView = AuthorsListView(
            viewModel: AuthorsListViewModel.makeSuccessDummy
        )
        successAuthorsListView.delegate = delegateMock
        
        var failureAuthorsListView = AuthorsListView(
            viewModel: AuthorsListViewModel.makeFailureDummy
        )
        failureAuthorsListView.delegate = delegateMock
        
        return Group {
            successAuthorsListView
                .previewDisplayName("List View - Success")
            failureAuthorsListView
                .previewDisplayName("List View - Failure")
        }
    }
}

#endif
