//
//  GLSettingPresent.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/17.
//
import UIKit
import Foundation
class GLSettingPresent: NSObject {
    weak var viewController: UIViewController?
    
    func fetchData() ->NSArray{
        let sections = NSMutableArray.init()
        for type in GLSettingType.allCases {
//            print("show \(ie)")
            let model = GLSettingModel.init(setType: type)
            sections.add(model)
        }
        
        return sections
    }

    func tableViewdidSelect(model:GLSettingModel){
        switch model.type{
            case .commonSetting:
            break
            case .securityAndPrivate:
            break
            case .highSetting:
            break
            case .contactInfoSetting:
            break
            case .networkSetting:
            break
            case .testSetting:
            break
            case .introduceInfoSetting:
            break
        }
    }
    
}
