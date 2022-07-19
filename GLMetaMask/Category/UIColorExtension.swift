//
//  UIColorExtension.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/11.
//

import Foundation
import UIKit

extension UIColor {
    class func commonBackgroundColor() ->UIColor {
        return UIColor(red: 36/255, green: 39/255, blue: 42/255, alpha: 1.0)
    }
    
    class func commonBackgroundBlueColor() ->UIColor {
        return UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0)
    }
    class func secondTitleColor() ->UIColor {
        return UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0)
    }
    
    class func lineColor() ->UIColor {
        return UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 0.7)
    }
    
}
