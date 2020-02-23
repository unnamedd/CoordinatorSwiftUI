import SwiftUI

open class Coordinator {
    
    weak var parent: Coordinator?
    private(set) var children: Set<Coordinator>
    
    init() {
        children = Set()
    }
    
    final func addChild(_ coordinator: Coordinator) {
        coordinator.parent = self
        children.insert(coordinator)
    }
    
    final func removeChild(_ coordinator: Coordinator) {
        children.remove(coordinator)
    }
    
    final func removeAllChildren() {
        children.removeAll()
    }
    
    open func start() -> AnyView {
        fatalError("Subclasses must implement \(#function)")
    }
}

extension Coordinator: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
}

extension Coordinator: Equatable {
    public static func ==(lhs: Coordinator, rhs: Coordinator) -> Bool {
       return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
