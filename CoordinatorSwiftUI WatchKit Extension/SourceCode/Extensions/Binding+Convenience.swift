import SwiftUI

extension Binding {
    init<Object>(_ object: Object, keyPath: ReferenceWritableKeyPath<Object, Value>) {
        self.init(get: { object[keyPath: keyPath] }) { newValue in
            object[keyPath: keyPath] = newValue
        }
    }
}
