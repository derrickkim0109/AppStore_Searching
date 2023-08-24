//
//  AnyCancellableTask.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

protocol AnyCancellableTask {
    func cancel()
}

extension Task: AnyCancellableTask {}
