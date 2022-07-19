//
//  ViewController.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/6/28.
//

import UIKit
import SideMenu
import HandyJSON
class MainViewController: UIViewController {
    lazy var headerView: GLMainHeaderView = {
        let headerView = GLMainHeaderView()
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.commonBackgroundColor()
        setupNavigation();
        setupSideMenu()
        setupCustomView()
    }
    
    func setupCustomView(){
        self.edgesForExtendedLayout = .bottom
        
        let accountModel = GLUserModel.sharedInstance.accountModel!
        headerView.configData(model: accountModel)
        self.view.addSubview(headerView)
        headerView.delegate = self
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
        ])

    }
    
    func setupNavigation(){
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationItem.title = "钱包"
        
        let  scanBtn = UIButton.init(type: .system)
        let scanImage : UIImage! = UIImage.init(named: "app_images_scan")
        scanImage.withRenderingMode(.alwaysTemplate)
        scanBtn.setImage(scanImage, for: .normal)
        scanBtn.tintColor = UIColor.commonBackgroundBlueColor()
        scanBtn.addTarget(self, action: #selector(clickedScanButton), for: .touchUpInside)
        let scanBtnItem = UIBarButtonItem.init(customView: scanBtn)
        navigationItem.rightBarButtonItem = scanBtnItem
        
        let  leftMoreBtn = UIButton.init(type: .system)
        let leftMoreImage : UIImage! = UIImage.init(named: "app_images_list")
        leftMoreImage.withRenderingMode(.alwaysTemplate)
        leftMoreBtn.setImage(leftMoreImage, for: .normal)
        leftMoreBtn.tintColor = UIColor.commonBackgroundBlueColor()
        leftMoreBtn.addTarget(self, action: #selector(clickedleftMoreBtn), for: .touchUpInside)
        let leftMoreBtnItem = UIBarButtonItem.init(customView: leftMoreBtn)
        navigationItem.leftBarButtonItem = leftMoreBtnItem
        
        if #available(iOS 13.0, *){
           let barApp =  UINavigationBarAppearance.init()
            barApp.backgroundColor = UIColor.commonBackgroundColor()
            barApp.shadowColor = UIColor.commonBackgroundColor()
            barApp.backgroundEffect = nil
            barApp.titleTextAttributes  = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                           NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 18)]
            self.navigationController?.navigationBar.scrollEdgeAppearance = barApp;
            self.navigationController?.navigationBar.standardAppearance = barApp;
        }
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.commonBackgroundBlueColor()
    }
    
    private func setupSideMenu() {
        // Define the menus
        let vc = GLLeftSideViewController()
        vc.present.rootController = self
        SideMenuManager.default.leftMenuNavigationController =  SideMenuNavigationController.init(rootViewController: vc)
        SideMenuManager.default.leftMenuNavigationController?.leftSide = true
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
        
        let settings = makeSettings()
        SideMenuManager.default.leftMenuNavigationController?.settings = settings
    }
    
    private func makeSettings() -> SideMenuSettings {
        let presentationStyle = SideMenuPresentationStyle.viewSlideOut
        presentationStyle.menuOnTop = false
        presentationStyle.menuStartAlpha = 1
        presentationStyle.menuScaleFactor = 1
        presentationStyle.onTopShadowOpacity = 0
        presentationStyle.presentingEndAlpha = 1
        presentationStyle.presentingScaleFactor = 1
        
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = min(view.frame.width, view.frame.height) * 0.8
        settings.blurEffectStyle =  .none
        settings.statusBarEndAlpha = 0
        
        return settings
    }
    
    @objc func clickedScanButton(){
        debugPrint("Camera Clicked")
        
    }
    
    @objc func clickedleftMoreBtn(){
        guard let sideMenuNavigationController = SideMenuManager.default.leftMenuNavigationController else { return }
        
        sideMenuNavigationController.settings = makeSettings()
        self.present(sideMenuNavigationController, animated: true, completion: nil)
    }
}

extension MainViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}

extension MainViewController:GLMainHeaderViewDelegate{
    func onClickedButton(type: GLMainHeaderButtonType){
        let  vc = GLSwapViewController()
        let nav = UINavigationController.init(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}
