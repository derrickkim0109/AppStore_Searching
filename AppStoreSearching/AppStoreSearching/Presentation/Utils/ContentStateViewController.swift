//
//  ContentStateViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

class ContentStateViewController: UIViewController {
    private var state: State?
    var presentingCurrentViewController: UIViewController?
    
    func transition(to newState: State) {
        presentingCurrentViewController?.remove()
        
        let viewController = presentViewController(by: newState)
        add(childViewController: viewController)
        
        presentingCurrentViewController = viewController
        state = newState
    }
}

private extension ContentStateViewController {
    func presentViewController(
        by state: State) -> UIViewController {
            switch state {
            case .render(let viewController):
                return viewController
            }
        }
}

extension ContentStateViewController {
    enum State {
        case render(UIViewController)
    }
}
