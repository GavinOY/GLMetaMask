//
//  GLSwapPresent.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/19.
//

import Foundation
class GLSwapPresent: NSObject {
    
    func fetchCoinList() ->[GLCoinModel]?{
        // coin
        guard let path = Bundle.main.path(forResource: "coinsConfig", ofType: "json") else { return nil}
        let localData = NSData.init(contentsOfFile: path)! as Data
        let jsonString: String? = NSString.init(data: localData, encoding: String.Encoding.utf8.rawValue) as String?
        guard let modelList =  [GLCoinModel].deserialize(from: jsonString) else {
            return nil
        }
        
        return modelList as? [GLCoinModel]
    }
}
