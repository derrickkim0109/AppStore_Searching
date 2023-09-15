//
//  String.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import Foundation

extension String {
    func getLastReleasedDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        guard let date = dateFormatter.date(from: self) else {
            return nil
        }

        let calendar = Calendar.current
        let currentDate = Date()

        let components = calendar.dateComponents([.year, .month, .weekOfYear, .day, .hour], from: date, to: currentDate)

        if let year = components.year, year > 0 {
            return "\(year)년 전"
        } else if let month = components.month, month > 0 {
            return "\(month)개월 전"
        } else if let week = components.weekOfYear, week > 0 {
            return "\(week)주 전"
        } else if let day = components.day, day > 0 {
            return "\(day)일 전"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour)시간 전"
        } else {
            return "방금"
        }
    }

    func getMB() -> String {
        guard let sizeInBytes = Int(self) else {
            return self
        }

        let sizeInMB = Double(sizeInBytes) / (1024 * 1024)
        let formattedSize = String(format: "%.1f", sizeInMB) + "MB"
        return formattedSize
    }

    func getFormattedDeviceName() -> String {
        let trimmedDevice = self.replacingOccurrences(of: " ", with: "")
        let formattedDevice = trimmedDevice + "-" + trimmedDevice
        return formattedDevice
    }

    func hasCaseInsensitivePrefix(
        _ string: String
    ) -> Bool {
        return prefix(string.count)
            .caseInsensitiveCompare(string) == .orderedSame
    }

    // 한글 1~10자까지만 허용
    //
    func validateKeyword() -> Bool {
        return NSPredicate(
            format: "SELF MATCHES %@",
            "[가-힣\\s]{1,10}$"
        ).evaluate(with: self)
    }
}
