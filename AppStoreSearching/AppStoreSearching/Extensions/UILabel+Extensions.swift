//
//  UILabel+Extensions.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

import UIKit

extension UILabel {
    func wrap(_ word: String) {
        self.text = word
        let words = word.split(separator: " ")
        let attributedString = NSMutableAttributedString(string: word)

        words.indices.forEach { index in
            if index > 0 {
                let prevIndex = words.index(before: index)
                if words[prevIndex].count > 1 && words[index].count > 1 {
                    let start = word.distance(
                        from: word.startIndex,
                        to: words[prevIndex].endIndex)
                    let end = word.distance(
                        from: word.startIndex,
                        to: words[index].startIndex)
                    let range = NSRange(
                        location: start,
                        length: end - start)
                    attributedString.addAttribute(
                        .paragraphStyle,
                        value: NSParagraphStyle.default,
                        range: range)
                }
            }
        }

        self.attributedText = attributedString
        self.sizeToFit()
    }
}
