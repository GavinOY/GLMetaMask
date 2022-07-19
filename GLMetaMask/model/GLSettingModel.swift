//
//  GLSettingModel.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/17.
//

import Foundation

enum GLSettingType: Int,CaseIterable{
    case commonSetting
    case securityAndPrivate
    case highSetting
    case contactInfoSetting
    case networkSetting
    case testSetting
    case introduceInfoSetting
}

class GLSettingModel: NSObject { 
    var title: String?
    var contentTitle: String?
    let type: GLSettingType
    
    init(setType: GLSettingType) {
        type = setType
        switch self.type {
        case .commonSetting:
            title = "浏览器"
            contentTitle = "货币转换、主要货币，语言和搜索引擎"
        case .securityAndPrivate:
            title = "安全和隐私"
            contentTitle = "隐私设置、MetaMetrics、私钥和钱包助记词"
        case .highSetting:
            title = "高级"
            contentTitle = "访问开发人员功能、重置账户、设置测试网、状态日志、IPFS网光和自定义RPC"
        case .contactInfoSetting:
            title = "联系信息"
            contentTitle = "添加、编辑、删除和管理您的账户"
        case .networkSetting:
            title = "网络"
            contentTitle = "添加并编辑自定义RPC网络"
        case .testSetting:
            title = "实验"
            contentTitle = "WalletConnect及更多.."
        case .introduceInfoSetting:
            title = "MetaMask简介"
        }
    }
}
