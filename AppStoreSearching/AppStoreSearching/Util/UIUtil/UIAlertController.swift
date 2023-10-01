//
//  UIAlertController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/10/01.
//

import UIKit

extension UIAlertController {

    /// 파라미터를 기반으로 `UIAlertController`에 `UIAlertAction`을 추가한 후 반환합니다.
    ///
    /// 사용법
    /// ```
    /// let alertController = UIAlertController(...)
    ///     .appendingAction(...)
    ///     .appendingAction(...)
    ///     .appendingAction(...)
    /// ```
    func appendingAction(
        title: String?,
        style: UIAlertAction.Style = .default,
        handler: (() -> Void)? = nil
    ) -> Self {
        let alertAction = UIAlertAction(
            title: title,
            style: style
        ) {_ in
            handler?()
        }

        self.addAction(alertAction)
        return self
    }

    func appendingCancel() -> Self {
        return self.appendingAction(
            title: "취소",
            style: .cancel
        )
    }
}
