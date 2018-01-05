//
//  ConstraintViewControllerDSL.swift
//  SnapKit
//
//  Created by Dylan Wang on 05/01/2018.
//

import SnapKit

public struct ConstraintViewControllerDSL {
    
    public var safeAreaTopLayoutGuide: ConstraintItem {
        if #available(iOS 11.0, *) {
            return viewController.view.safeAreaLayoutGuide.snp.top
        } else {
            return viewController.topLayoutGuide.snp.bottom
        }
    }
    
    public var safeAreaBottomLayoutGuide: ConstraintItem {
        if #available(iOS 11.0, *) {
            return viewController.view.safeAreaLayoutGuide.snp.bottom
        } else {
            return viewController.bottomLayoutGuide.snp.top
        }
    }
    
    internal let viewController: UIViewController
    
    internal init(target: UIViewController) {
        self.viewController = target
    }
}

extension UIViewController {
    public var snp: ConstraintViewControllerDSL {
        return ConstraintViewControllerDSL(target: self)
    }
}
