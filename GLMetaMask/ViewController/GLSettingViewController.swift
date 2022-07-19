//
//  GLSettingViewController.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/13.
//

import UIKit
class GLSettingViewController: UIViewController {
    var dataList :[GLSettingModel] = [];
    var tableView:UITableView!
    var present : GLSettingPresent = GLSettingPresent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        edgesForExtendedLayout = .bottom
        self.view.backgroundColor = UIColor.commonBackgroundColor()
        // Do any additional setup after loading the view.
        
//        navigationController?.setNavigationBarHidden(false, animated: false)
        setupNavigation()
        configSubviews()
        dataList = (present.fetchData() ) as! [GLSettingModel]
        present.viewController = self
    }
    
    func setupNavigation(){
        let  closeBtn = UIButton.init()
        closeBtn.setTitle("关闭", for: .normal)
        closeBtn.setTitleColor(UIColor.commonBackgroundBlueColor(), for: .normal)
        closeBtn.addTarget(self, action: #selector(onClickedCloseButton), for: .touchUpInside)
        closeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        let closeButtonItem = UIBarButtonItem.init(customView: closeBtn)
        navigationItem.leftBarButtonItem = closeButtonItem
       
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
    
    @objc func onClickedCloseButton(){
        self.dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func configSubviews() {
        self.view.backgroundColor =  UIColor.commonBackgroundColor()
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view.bounds.height) , style:.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.commonBackgroundColor()
        tableView.register(GLSettingCell.classForCoder(), forCellReuseIdentifier: GLSettingCell.reuseIdentifier)
        self.view.addSubview(tableView)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
       
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        ])
    }
    

    
    deinit {
        print( NSStringFromClass(self.classForCoder) + " ----> 销毁了")
    }
}

extension GLSettingViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataList.count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GLSettingCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:GLSettingCell = tableView.dequeueReusableCell(withIdentifier: GLSettingCell.reuseIdentifier) as! GLSettingCell
        cell.configData(model:dataList[indexPath.row] )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.present.tableViewdidSelect(model: dataList[indexPath.row] )
    }
}
