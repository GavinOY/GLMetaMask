//
//  GLSwapSearchViewController.swift
//  GLMetaMask
//
//  Created by  Gavin on 2022/7/19.
//

import Foundation
import UIKit
protocol GLSwapSearchViewControllerDelegate : AnyObject {
    func didSelecSwapCoinModel(model:GLCoinModel)
}

class GLSwapSearchViewController: UIViewController
{
    weak var delegate:GLSwapSearchViewControllerDelegate?
    var dataList:[GLCoinModel]? = nil
    var searchArray:[GLCoinModel] = [GLCoinModel](){
        didSet  {self.tableView.reloadData()}
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        dataList =  GLSwapPresent().fetchCoinList()!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // tableView
    let tableView: UITableView =
    {
        let table = UITableView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width,
                                              height: UIScreen.main.bounds.size.height-20), style: .plain)
        table.register(GLSwapSearchCell.self, forCellReuseIdentifier:GLSwapSearchCell.reuseIdentifier)
        return table
    }()
    
    let swapSearchController: UISearchController =
    {
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = false
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.sizeToFit()
        return controller
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        /// 设置UI
        setupUI()
        setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
    
    /// 设置UI
    func setupUI()
    {
        self.title = "转化为"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.backgroundColor = UIColor.commonBackgroundColor()
        self.tableView.backgroundColor = UIColor.commonBackgroundColor()
        self.tableView.tableHeaderView = self.swapSearchController.searchBar
        self.swapSearchController.searchResultsUpdater = self
        self.swapSearchController.searchBar.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
        ])
    }
    
    func setupNavigation(){
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
}

extension GLSwapSearchViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.swapSearchController.isActive {
            return self.searchArray.count
        } else {
            return self.dataList!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell :GLSwapSearchCell = tableView.dequeueReusableCell(withIdentifier: GLSwapSearchCell.reuseIdentifier,
                                                                   for: indexPath) as! GLSwapSearchCell
        
        if self.swapSearchController.isActive {
            let model = self.searchArray[indexPath.row]
            cell.configData(model: model)
            return cell
        } else {
            let model = self.dataList![indexPath.row]
            cell.configData(model: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var model:GLCoinModel
        if self.swapSearchController.isActive {
            model = self.searchArray[indexPath.row]
        } else {
            model = self.dataList![indexPath.row]
        }
        //通知外部
        self.delegate?.didSelecSwapCoinModel(model: model)
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GLSwapSearchCell.cellHeight()
    }
    
}


extension GLSwapSearchViewController: UISearchResultsUpdating
{
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController)
    {
        
        self.searchArray =  self.dataList!.filter({ model -> Bool in
            guard let inputText:String = searchController.searchBar.text,inputText.count >= 1 else{
                return true
            }
            
            guard let name:String = model.symbol else{
                return false
            }
            return name.contains(inputText)
        })
    }
}

extension GLSwapSearchViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true)
    }
}

