//
//  AppConfiguration.swift
//  KakaoBankSubject
//
//  Created by Derrick kim on 2023/03/18.
//

import Foundation

final class AppConfiguration {
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(
            forInfoDictionaryKey: "APIBaseURL") as? String else {
            fatalError("APIBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
}
