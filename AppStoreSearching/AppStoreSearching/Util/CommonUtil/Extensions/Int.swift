//
//  Int.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import Foundation

extension Int {
    // 값이 축약된 "14만"과 "2.8만"으로 형태로 변환되기 때문에 "abbreviated"라는 단어를 사용
    func convertToAbbreviatedString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        if self >= 100000 {
            let value = self / 10000

            return "\(formatter.string(for: value) ?? "")만"

        } else if self >= 10000 {
            let value = Double(self) / 10000
            let roundedValue = (value * 10).rounded() / 10

            return "\(formatter.string(for: roundedValue) ?? "")만"

        } else if self >= 1000 {
            let value = Double(self) / 1000
            let roundedValue = (value * 10).rounded() / 10

            return "\(formatter.string(for: roundedValue) ?? "")천"

        } else {
            return "\(self)"
        }
    }
}
