//
//  Array.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import Foundation

extension Array where Element: Equatable {
    mutating func move(_ element: Element, to newIndex: Index) {
        if let oldIndex: Int = self.firstIndex(of: element) {
            self.move(from: oldIndex, to: newIndex)
        }
    }
}

extension Array {
    mutating func move(from oldIndex: Index, to newIndex: Index) {
        if oldIndex == newIndex { return }
        if abs(newIndex - oldIndex) == 1 { return self.swapAt(oldIndex, newIndex) }
        self.insert(self.remove(at: oldIndex), at: newIndex)
    }
}
