//  Thanks Noah Gilmore for this protocol.
//  The original version is here:
//  https://gist.github.com/noahsark769/e83f0dc30aced4e805df5cacdb086dd5
//

protocol KeyPathUpdatable {}

extension KeyPathUpdatable {
    func updating<LeafType>(_ keyPath: WritableKeyPath<Self, LeafType>, to value: LeafType) -> Self {
        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }
}
