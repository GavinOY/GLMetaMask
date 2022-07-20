//
//  GLSwapViewController.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/18.
//

import UIKit
class GLSwapViewController: UIViewController {
    lazy var headerView: GLSwapHeaderView = {
        let headerView = GLSwapHeaderView()
        return headerView
    }()
    
    lazy var numberInputView: GLSwapNumberInputView = {
        let numberInputView = GLSwapNumberInputView()
        return numberInputView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swap"
        edgesForExtendedLayout = .bottom
        self.view.backgroundColor = UIColor.commonBackgroundColor()
        // Do any additional setup after loading the view.
    
        setupNavigation()
        
        self.setupCustomView()
    }
    
    func setupNavigation(){
        let  closeBtn = UIButton.init()
        closeBtn.setTitle("取消", for: .normal)
        closeBtn.setTitleColor(UIColor.commonBackgroundBlueColor(), for: .normal)
        closeBtn.addTarget(self, action: #selector(onClickedCloseButton), for: .touchUpInside)
        closeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        let closeButtonItem = UIBarButtonItem.init(customView: closeBtn)
        navigationItem.rightBarButtonItem = closeButtonItem
       
        if #available(iOS 13.0, *){
           let barApp =  UINavigationBarAppearance.init()
            barApp.backgroundColor = UIColor.commonBackgroundColor()
            barApp.shadowColor = UIColor.commonBackgroundColor()
            barApp.backgroundEffect = nil
            barApp.titleTextAttributes  = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                           NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18)]
            self.navigationController?.navigationBar.scrollEdgeAppearance = barApp;
            self.navigationController?.navigationBar.standardAppearance = barApp;
        }
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.commonBackgroundBlueColor()
    }
    
    func setupCustomView(){
        self.edgesForExtendedLayout = .bottom
        self.view.addSubview(headerView)
        headerView.delegate = self
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
        ])
        
        numberInputView.delegate = self
        let numberInputViewHeight:CGFloat  = 4 * 40 + 3 * 5
        self.view.addSubview(numberInputView)
        numberInputView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberInputView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            numberInputView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            numberInputView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 10),
            numberInputView.heightAnchor.constraint(equalToConstant: numberInputViewHeight)
        ])
    }
    @objc func onClickedCloseButton(){
        self.dismiss(animated: true)
    }
}

extension GLSwapViewController:GLSwapHeaderViewDelegate{
    func onClickedSwapCoin(){
        print("onClickedSwapCoin")
        //搜索
        let vc = GLSwapSearchViewController.init()
        vc.delegate = self
        let nav = UINavigationController.init(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}

extension GLSwapViewController:GLSwapNumberInputViewDelegate{
    func onClickedSwapNumbersButton(type:GLSwapButtonType,title:String){
        headerView.updateChangeCount(type: type, title: title)
    }
}

extension GLSwapViewController:GLSwapSearchViewControllerDelegate{
    func didSelecSwapCoinModel(model:GLCoinModel){
        headerView.updateSwapCoinView(model: model)
    }
}

