//
//  GLSwapHeaderView.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/18.
//
import UIKit
import Kingfisher
class GLCoinView: UIView {
    var model:GLCoinModel?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.text = "ETH"
        return label
    }()

    lazy var coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "app_images_ethlogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "app_images_arrowDown")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configData(title:String, iconUrl:String){
        self.titleLabel.text = title
        let url = URL(string:iconUrl)
        coinImageView.kf.setImage(with: url, placeholder: UIImage.init(named: "defaultCoin"), options: nil, completionHandler: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        self.layer.masksToBounds = true
        self.addSubview(titleLabel)
        self.addSubview(coinImageView)
        self.addSubview(arrowImageView)
        
        coinImageView.layer.masksToBounds = true
        let imageWidth:CGFloat = 14
        coinImageView.layer.cornerRadius = imageWidth/2
        NSLayoutConstraint.activate([
            coinImageView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 8),
            coinImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            coinImageView.heightAnchor.constraint(equalToConstant: imageWidth)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: coinImageView.rightAnchor,constant: 4),
            titleLabel.centerYAnchor.constraint(equalTo: coinImageView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            arrowImageView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor,constant: 4),
            arrowImageView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -8),
            arrowImageView.centerYAnchor.constraint(equalTo: coinImageView.centerYAnchor),
//            arrowImageView.widthAnchor.constraint(equalToConstant: 16),
//            arrowImageView.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
}

protocol GLSwapHeaderViewDelegate: AnyObject {
    func onClickedSwapCoin()
}

class GLSwapHeaderView: UIView {
    weak var delegate:GLSwapHeaderViewDelegate?
    var sourceCoinView:GLCoinView = GLCoinView()
    var targetCoinView:GLCoinView = GLCoinView()
    lazy var swapLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingMiddle
        label.text = "0"
        return label
    }()
    
    lazy var swapTipsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.text = "0 LINK可供交换"
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onClickedSwapCoin(){
        self.delegate?.onClickedSwapCoin()
    }
    
    func updateChangeCount(type:GLSwapButtonType,title:String){
        let countString:String = swapLabel.text ?? ""
        switch type {
        case .number:
            if countString == "0"{
                swapLabel.text = title
            }else{
                swapLabel.text  = countString + title
            }
        case .dot:
            swapLabel.text = countString + title
        case .delete:
            if countString.count <= 1 {
                swapLabel.text = "0"
            }else{
                swapLabel.text?.removeLast()
            }
           
        }
    }
    
    func updateSwapCoinView(model:GLCoinModel){
        targetCoinView.configData(title: model.symbol ?? "", iconUrl: model.iconUrl ?? "")
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.addSubview(sourceCoinView)
        self.addSubview(swapLabel)
        self.addSubview(swapTipsLabel)
        self.addSubview(targetCoinView)
        
        targetCoinView.configData(title: "BTMC", iconUrl: "https://assets.coingecko.com/coins/images/6177/thumb/9ecCxf_s_400x400.jpg?1547042203")
        
        let bgTap = UITapGestureRecognizer(target: self, action: #selector(onClickedSwapCoin))
        targetCoinView.addGestureRecognizer(bgTap)
        
        setupContraint()
    }
    
    func setupContraint(){
        let image : UIImage! = UIImage.init(named: "app_images_arrowDown_hollow")
        image.withRenderingMode(.alwaysTemplate)
        let arrowImageView = UIImageView.init(image: image)
        arrowImageView.tintColor = UIColor.commonBackgroundBlueColor()
        self.addSubview(arrowImageView)
        
        let leftLine = UIView.init()
        leftLine.backgroundColor = UIColor.lineColor()
        
        let rightLine = UIView.init()
        rightLine.backgroundColor = UIColor.lineColor()
        self.addSubview(leftLine)
        self.addSubview(rightLine)
        
        sourceCoinView.translatesAutoresizingMaskIntoConstraints = false
        sourceCoinView.layer.cornerRadius = 13
        NSLayoutConstraint.activate([
            sourceCoinView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            sourceCoinView.heightAnchor.constraint(equalToConstant: 26),
            sourceCoinView.topAnchor.constraint(equalTo: self.topAnchor,constant: 15),
        ])
        
        NSLayoutConstraint.activate([
            swapLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            swapLabel.topAnchor.constraint(equalTo: sourceCoinView.bottomAnchor,constant: 15),
            swapLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            swapTipsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            swapTipsLabel.topAnchor.constraint(equalTo: swapLabel.bottomAnchor,constant: 8),
            swapTipsLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            arrowImageView.topAnchor.constraint(equalTo: swapTipsLabel.bottomAnchor,constant: 10),
        ])
        
        leftLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftLine.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            leftLine.centerYAnchor.constraint(equalTo: arrowImageView.centerYAnchor),
            leftLine.heightAnchor.constraint(equalToConstant: 0.5),
            leftLine.rightAnchor.constraint(equalTo: arrowImageView.leftAnchor,constant: -2)
        ])
        
        rightLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightLine.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20),
            rightLine.centerYAnchor.constraint(equalTo: arrowImageView.centerYAnchor),
            rightLine.heightAnchor.constraint(equalTo: leftLine.heightAnchor),
            rightLine.leftAnchor.constraint(equalTo: arrowImageView.rightAnchor,constant: -2)
        ])
        
        
        targetCoinView.translatesAutoresizingMaskIntoConstraints = false
        targetCoinView.layer.cornerRadius = 13
        NSLayoutConstraint.activate([
            targetCoinView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            targetCoinView.heightAnchor.constraint(equalToConstant: 26),
            targetCoinView.topAnchor.constraint(equalTo: arrowImageView.bottomAnchor,constant: 20),
            targetCoinView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10)
        ])
    }
}
