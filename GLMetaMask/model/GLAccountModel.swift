//
//  GLAccountModel.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/6/28.
//

import UIKit

class GLAccountModel: NSObject {
    var avatarUrl: String?
    var account: String?
    var money: String?
    var publicAddress: String?
}


class GLUserModel: NSObject {
    var accountModel:GLAccountModel!
    static let sharedInstance = GLUserModel()
    override init() {
        super.init()
        ///TODO 改成网络获取
        accountModel = GLAccountModel()
        accountModel.account = "account1";
        accountModel.money = "123";
        accountModel.publicAddress = "sdfdsakaslkjaslfkjjkfadfkladjfaslkfdjasdlfjasadflkjasdkl"
    }
}
