//
//  BaseView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/22.
//

import UIKit

class BaseView: UIView, BaseViewProtocol {
    required init() {
        super.init(frame: .zero)

        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setupDefault()
        addUIComponents()
        configureLayouts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setupDefault() { }
    func addUIComponents() { }
    func configureLayouts() { }
}
