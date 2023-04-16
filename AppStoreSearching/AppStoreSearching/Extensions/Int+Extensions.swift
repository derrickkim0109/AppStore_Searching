//
//  Int+Extensions.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/20.
//

extension Int {
    var formattedNumber: String {
        if self < 1000 {
            return String(self)
        } else if self < 10000 {
            let quotient = Double(self) / 1000

            let formatted = quotient.truncatingRemainder(dividingBy: 1) == 0 ?
            String(Int(quotient)) : String(format: "%.1f", quotient).replacingOccurrences(of: ".0", with: "")

            return formatted + "천"
        } else if self < 100000 {
            let quotient = Double(self) / 10000

            let formatted = quotient.truncatingRemainder(dividingBy: 1) == 0 ?
            String(Int(quotient)) : String(format: "%.1f", quotient).replacingOccurrences(of: ".0", with: "")

            return formatted + "만"
        } else {
            let quotient = Double(self) / 10000
            let formatted = String(Int(quotient.rounded(.toNearestOrAwayFromZero)))

            return formatted + "만"
        }
    }
}
