//
//  GLLeftViewPresenter.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/11.
//

import Foundation
import UIKit
import SideMenu

class GLLeftSideViewPresenter: NSObject {
    weak var viewController: UIViewController?
    weak var rootController: UIViewController?
    func fetchData() ->NSArray{
        let section1 = [GLLeftViewModel.init(setType: .browser)]
        
        let section2 = [GLLeftViewModel.init(setType: .browser),GLLeftViewModel.init(setType: .wallet),GLLeftViewModel.init(setType: .activity)]
        let section3 = [GLLeftViewModel.init(setType: .shareMyCommonAddress),GLLeftViewModel.init(setType: .checkForEtherscan)]
        let section4 = [GLLeftViewModel.init(setType: .setting),GLLeftViewModel.init(setType: .help),GLLeftViewModel.init(setType: .requestFunction),GLLeftViewModel.init(setType: .logout)]
        return [section1,section2,section3,section4]
    }
    
    func tableViewdidSelect(model:GLLeftViewModel){
        switch model.type{
            case .browser:
            break
            case .setting:
              guard let viewController = viewController else { return }
            let  vc = GLSettingViewController()
            let nav = UINavigationController.init(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
              viewController.present(nav, animated: true)
//            viewController.dismiss(animated: true, completion: {
//                let  vc = GLSettingViewController()
//                let nav = UINavigationController.init(rootViewController: vc)
//                nav.modalPresentationStyle = .fullScreen
//                  viewController.present(nav, animated: true)
//             })
            break
            case .wallet:
            break
            case .activity:
            break
            case .shareMyCommonAddress:
            break
            case .checkForEtherscan:
            break
            case .help:
            break
            case .requestFunction:
            break
            case .logout:
            break
        }
    }
    
}
