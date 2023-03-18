//
//  AnyCancellableTask.swift
//  KakaoBankSubject
//
//  Created by Derrick kim on 2023/03/18.
//

public protocol AnyCancellableTask {
    func cancel()
}

extension Task: AnyCancellableTask {}
