//
//  BaseProtocol.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/22.
//

protocol BaseViewControllerProtocol {
    associatedtype T
    init(viewModel: T)
    func setupDefault()
    func addUIComponents()
    func configureLayouts()
}

protocol BaseViewProtocol {
    init()
    func setupDefault()
    func addUIComponents()
    func configureLayouts()
}
