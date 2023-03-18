//
//  AppDIContainer.swift
//  KakaoBankSubject
//
//  Created by Derrick kim on 2023/03/18.
//

import Foundation

final class AppDIContainer {
    lazy var appConfiguration = AppConfiguration()

    lazy var apiDataTransferService: DataTransferService = {
        let configuration = ApiDataNetworkConfiguration(
            baseURL: URL(string: appConfiguration.apiBaseURL)!)

        let apiDataNetwork = DefaultNetworkService(
            config: configuration)
        return DefaultDataTransferService(
            with: apiDataNetwork)
    }()

    func makeAppStoreSceneDIContainer() -> AppStoreSceneDIContainer {
        let dependencies = AppStoreSceneDIContainer.Dependencies(
            apiDataTransferService: apiDataTransferService)
        return AppStoreSceneDIContainer(
            dependencies: dependencies)
    }
}
