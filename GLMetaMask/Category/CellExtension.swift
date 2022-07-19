//
//  CellExtension.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/11.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
