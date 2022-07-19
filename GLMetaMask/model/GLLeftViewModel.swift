//
//  GLLeftViewModel.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/11.
//

import Foundation
enum GLLeftViewCellType: Int{
    case browser
    case wallet
    case activity
    case shareMyCommonAddress
    case checkForEtherscan
    case setting
    case help
    case requestFunction
    case logout
}

class GLLeftViewModel: NSObject {
    let imageName: String?
    let title: String?
    let type: GLLeftViewCellType
    
    init(setType: GLLeftViewCellType) {
        type = setType

        switch self.type {
        case .browser:
            imageName = "app_images_selectedwalleticon"
            title = "浏览器"
        case .wallet:
            imageName = "app_images_selectedwalleticon"
            title = "钱包"
        case .activity:
            imageName = "app_images_selectedwalleticon"
            title = "活动"
        case .shareMyCommonAddress:
            imageName = "app_images_selectedwalleticon"
            title = "共享我的公共地址"
        case .checkForEtherscan:
            imageName = "app_images_selectedwalleticon"
            title = "在Etherscan 上查看"
        case .setting:
            imageName = "app_images_selectedwalleticon"
            title = "设置"
        case .help:
            imageName = "app_images_selectedwalleticon"
            title = "获取帮助"
        case .requestFunction:
            imageName = "app_images_selectedwalleticon"
            title = "请求功能"
        case .logout:
            imageName = "app_images_selectedwalleticon"
            title = "注销"
        }
    }
}
