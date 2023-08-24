//
//  ReusableCells.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/19.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(
            T.self,
            forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(
        forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
            guard let cell = dequeueReusableCell(
                withIdentifier: T.reuseIdentifier,
                for: indexPath) as? T else {
                fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
            }

            return cell
        }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(
        _: T.Type) where T: ReusableView {
            register(
                T.self,
                forCellWithReuseIdentifier: T.reuseIdentifier)
        }

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
}
