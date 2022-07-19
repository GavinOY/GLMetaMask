//
//  GLCoinModel.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/17.
//

import Foundation
import HandyJSON
class GLCoinModel:HandyJSON{
    var symbol: String?
    var address: String?
    var aggregators: [NSString]?
    var iconUrl: String?
    var decimals: Int?
    var occurrences: Int?
    var name: String?
    required init() {}
}
