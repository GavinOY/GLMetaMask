//
//  GLLeftViewController.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/6/28.
//

import UIKit
import SideMenu
class GLLeftSideViewController: UIViewController {
    var present : GLLeftSideViewPresenter = GLLeftSideViewPresenter()
    var dataList :[NSArray] = [];
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configSubviews()
        // Do any additional setup after loading the view, typically from a nib.
        dataList = (present.fetchData() ) as! [NSArray]
        present.viewController = self
        navigationController?.setNavigationBarHidden(true, animated: false)
        guard let menu = navigationController as? SideMenuNavigationController, menu.blurEffectStyle == nil else {
            return
        }
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
        tableView.tableFooterView = UIView.init()
        tableView.register(GLLeftSideViewCell.classForCoder(), forCellReuseIdentifier: GLLeftSideViewCell.reuseIdentifier)
        tableView.register(GLLeftSideSendAndPayCell.classForCoder(), forCellReuseIdentifier: GLLeftSideSendAndPayCell.reuseIdentifier)
        self.view.addSubview(tableView)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        //TODO
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        ])
        
        let accountModel = GLUserModel.sharedInstance.accountModel!
        let header = GLLeftSideHeaderView(model: accountModel)
        header.backgroundColor = UIColor.init(red: 60/255, green: 60/255, blue: 60/255, alpha: 1)
    
        tableView.tableHeaderView = header
    }
    

    deinit {
       
    }
}

extension GLLeftSideViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataList[section].count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return GLLeftSideSendAndPayCell.cellHeight()
        }
        return GLLeftSideViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell:GLLeftSideSendAndPayCell = tableView.dequeueReusableCell(withIdentifier: GLLeftSideSendAndPayCell.reuseIdentifier) as! GLLeftSideSendAndPayCell
            return cell
        }
        let cell:GLLeftSideViewCell = tableView.dequeueReusableCell(withIdentifier: GLLeftSideViewCell.reuseIdentifier) as! GLLeftSideViewCell
        cell.configData(model: dataList[indexPath.section][indexPath.row] as! GLLeftViewModel, isHiddenLine: indexPath.row != 0)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.present.tableViewdidSelect(model: dataList[indexPath.section][indexPath.row] as! GLLeftViewModel)
    }
}

