//
//  Extensions.swift
//  MessangerApp
//
//  Created by 野澤拓己 on 2020/11/21.
//

import Foundation
import UIKit


public extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
}

public extension CALayer {
    enum Direction {
        case top
        case bottom
    }

    public func addShadow(direction: Direction){
        switch direction {
        case .top:
            self.shadowOffset = CGSize(width: 0.0, height: -1)
        case .bottom:
            self.shadowOffset = CGSize(width: 0.0, height: 1)
        }
        self.shadowRadius = 1.5
        self.shadowColor = UIColor.black.cgColor
        self.shadowOpacity = 0.5
    }
}



