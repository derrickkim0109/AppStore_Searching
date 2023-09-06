//
//  ContentStateViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

class ContentStateViewController: UIViewController {
    private var state: State?
    private var presentingCurrentViewController: UIViewController?
    private let bag = AnyCancelTaskBag()

    func transition(to newState: State) {
        Task { [weak self] in
            await MainActor.run() {
                self?.presentingCurrentViewController?.remove()

                let viewController = self?.presentViewController(by: newState) ?? UIViewController()
                self?.add(childViewController: viewController)

                self?.presentingCurrentViewController = viewController
                self?.state = newState
            }
        }.store(in: bag)
    }
}

extension ContentStateViewController {
    enum State {
        case render(UIViewController?)
    }
}

private extension ContentStateViewController {
    func presentViewController(
        by state: State) -> UIViewController {
            switch state {
            case .render(let viewController):
                return viewController ?? UIViewController()
            }
        }
}
