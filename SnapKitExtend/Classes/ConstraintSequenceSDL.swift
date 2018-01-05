//
//  ConstraintSequenceSDL.swift
//  Pods-SnapKitExtend_Example
//
//  Created by Dylan Wang on 05/01/2018.
//

import SnapKit

public enum AxisType {
    case horizontal
    case vertical
}

public struct ConstraintSequenceSDL {
    
    public func makeConstraints(_ closure: (ConstraintMaker) -> Void) {
        for view in array {
            view.snp.makeConstraints(closure)
        }
    }
    
    public func updateConstraints(_ closure: (ConstraintMaker) -> Void) {
        for view in array {
            view.snp.updateConstraints(closure)
        }
    }
    
    public func remakeConstraints(_ closure: (ConstraintMaker) -> Void) {
        for view in array {
            view.snp.remakeConstraints(closure)
        }
    }
    
    public func distributeViewsAlong(axis: AxisType, fixedSpacing: CGFloat, leadSpacing: CGFloat = 0, tailSpacing: CGFloat = 0, closure: ((ConstraintMaker) -> Void)? = nil) {
        guard array.count > 1 else {
            fatalError("views to distribute need to bigger than one")
        }
        
        let tempSuperview = commonSuperviewOfViews()
        if axis == .horizontal {
            var prev: UIView?
            for (index, view) in array.enumerated() {
                view.snp.makeConstraints { make in
                    if let prev = prev {
                        make.width.equalTo(prev)
                        make.left.equalTo(prev.snp.right).offset(fixedSpacing)
                        if index == array.count - 1 {
                            make.right.equalTo(tempSuperview).offset(-tailSpacing)
                        }
                    } else {
                        make.left.equalTo(tempSuperview).offset(leadSpacing)
                    }
                    closure?(make)
                }
                prev = view
            }
        } else {
            var prev: UIView?
            for (index, view) in array.enumerated() {
                view.snp.makeConstraints { make in
                    if let prev = prev {
                        make.height.equalTo(prev)
                        make.top.equalTo(prev.snp.bottom).offset(fixedSpacing)
                        if index == array.count - 1 {
                            make.bottom.equalTo(tempSuperview).offset(-tailSpacing)
                        }
                    } else {
                        make.top.equalTo(tempSuperview).offset(leadSpacing)
                    }
                    closure?(make)
                }
                prev = view
            }
        }
    }
    
    public func distributeViewsAlong(axis: AxisType, fixedItemLength: CGFloat, leadSpacing: CGFloat = 0, tailSpacing: CGFloat = 0, closure: ((ConstraintMaker) -> Void)? = nil) {
        guard array.count > 1 else {
            fatalError("views to distribute need to bigger than one")
        }
        
        let tempSuperview = commonSuperviewOfViews()
        let spaceCount = CGFloat(array.count - 1)
        if axis == .horizontal {
            var prev: UIView?
            for (index, view) in array.enumerated() {
                view.snp.makeConstraints { make in
                    make.width.equalTo(fixedItemLength)
                    if let _ = prev {
                        if index == array.count - 1 {
                            make.right.equalTo(tempSuperview).offset(-tailSpacing)
                        } else {
                            let offset = CGFloat(1 - CGFloat(index) / spaceCount) * CGFloat(fixedItemLength + leadSpacing) - CGFloat(index) * tailSpacing / spaceCount
                            make.right.equalTo(tempSuperview).multipliedBy(CGFloat(index) / spaceCount).offset(offset)
                        }
                    } else {
                        make.left.equalTo(tempSuperview).offset(leadSpacing)
                    }
                    closure?(make)
                }
                prev = view
            }
        } else {
            var prev: UIView?
            for (index, view) in array.enumerated() {
                view.snp.makeConstraints { make in
                    make.height.equalTo(fixedItemLength)
                    if let _ = prev {
                        if index == array.count - 1 {
                            make.bottom.equalTo(tempSuperview).offset(-tailSpacing)
                        } else {
                            let offset = CGFloat(1 - CGFloat(index) / spaceCount) * CGFloat(fixedItemLength + leadSpacing) - CGFloat(index) * tailSpacing / spaceCount
                            make.bottom.equalTo(tempSuperview).multipliedBy(CGFloat(index) / spaceCount).offset(offset)
                        }
                    } else {
                        make.top.equalTo(tempSuperview).offset(leadSpacing)
                    }
                    closure?(make)
                }
                prev = view
            }
        }
    }
    
    private func commonSuperviewOfViews() -> UIView {
        var commonSuperview: UIView?
        for view in array {
            guard let superview = view.superview else {
                fatalError("view must have superview")
            }
            if commonSuperview == nil {
                commonSuperview = superview
            } else if commonSuperview != superview {
                fatalError("views must have same superview")
            }
        }
        return commonSuperview!
    }
    
    internal var array: [UIView]
    internal init(array: [UIView]) {
        self.array = array
    }
}

extension Array where Element == UIView {
    
    public var snp: ConstraintSequenceSDL {
        return ConstraintSequenceSDL(array: self)
    }
}
