//
//  mianHeaderView.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/17.
//

import UIKit

enum GLMainHeaderButtonType: Int{
    case receive
    case buy
    case sending
    case change
}

protocol GLMainHeaderViewDelegate: AnyObject {
    func onClickedButton(type: GLMainHeaderButtonType)
}


class GLMainHeaderView: UIView {
    var avatarImageView: UIImageView!
    var accountLabel: UILabel!
    var moneyLabel: UILabel!
    var publicAddressLabel: UILabel!
    
    var model: GLAccountModel?
    weak var delegate:GLMainHeaderViewDelegate?
    lazy var stackView: UIStackView = {
        let iconList = ["app_images_transactionicons_receive","app_images_selectedwalleticon","app_images_transactionicons_send","app_images_transactionicons_interaction"]
        let titleList = ["接受","购买","发送","交换"]
        var subViewList = NSMutableArray.init()
        for index in 0..<4 {
            let button = GLButton.init(type: .custom)
            button.setTitle(titleList[index], for: .normal)
            button.setImage(UIImage.init(named: iconList[index]), for: .normal)
            button.setTitleColor(UIColor.commonBackgroundBlueColor(), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.tag = index
            button.addTarget(self, action: #selector(onClickedButton(button:)), for: .touchUpInside)
            subViewList.add(button)
            button.translatesAutoresizingMaskIntoConstraints = false
    
            button.imagePosition(style: .top, spacing: 10)
        }
        let stackView = UIStackView(arrangedSubviews:subViewList as! [UIView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    @objc func onClickedButton(button:UIButton)  {
        let type: GLMainHeaderButtonType = GLMainHeaderButtonType(rawValue: button.tag) ?? .receive
        print(type)
        self.delegate?.onClickedButton(type: type)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        avatarImageView = UIImageView(frame: CGRect.zero)
        avatarImageView.contentMode = UIView.ContentMode.scaleAspectFit
        avatarImageView.image = UIImage(named: "default_avatar")
        avatarImageView.layer.borderWidth = 3.0;
        avatarImageView.layer.borderColor = UIColor.commonBackgroundBlueColor().cgColor
        avatarImageView.layer.masksToBounds = true;
        
        accountLabel = UILabel(frame: CGRect.zero)
        accountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        accountLabel.textColor = UIColor.white
        accountLabel.textAlignment = NSTextAlignment.center
        
        moneyLabel = UILabel(frame: CGRect.zero)
        moneyLabel.font = UIFont.systemFont(ofSize: 15)
        moneyLabel.textColor = UIColor.white
        moneyLabel.textAlignment = NSTextAlignment.center

        publicAddressLabel = UILabel(frame: CGRect.zero)
        publicAddressLabel.font = UIFont.systemFont(ofSize: 11)
        publicAddressLabel.textColor = UIColor.white
        publicAddressLabel.lineBreakMode = NSLineBreakMode.byTruncatingMiddle
        publicAddressLabel.textAlignment = NSTextAlignment.center
        publicAddressLabel.backgroundColor = UIColor.init(red: 33/255, green: 150/255, blue: 243/255, alpha: 0.3)
        publicAddressLabel.layer.masksToBounds = true
        publicAddressLabel.layer.cornerRadius = 10
        
        self.addSubview(avatarImageView)
        self.addSubview(accountLabel)
        self.addSubview(moneyLabel)
        self.addSubview(publicAddressLabel)
        self.addSubview(stackView)
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configConstraints() {
        //imageView约束
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        let avatarWidth = 40.0
        let maxWidth = 100.0
        avatarImageView.layer.cornerRadius = avatarWidth/2
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarWidth),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarWidth),
            avatarImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accountLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 15),
            accountLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            accountLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor)
        ])
        
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moneyLabel.topAnchor.constraint(equalTo: accountLabel.bottomAnchor, constant: 8),
            moneyLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            moneyLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
        ])
        
        publicAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            publicAddressLabel.topAnchor.constraint(equalTo: moneyLabel.bottomAnchor, constant: 8),
            publicAddressLabel.widthAnchor.constraint(equalToConstant: maxWidth),
            publicAddressLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            publicAddressLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: publicAddressLabel.bottomAnchor,constant: 10),
            stackView.heightAnchor.constraint(equalToConstant: 80),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10)
        ])
    }
    
    func configData(model: GLAccountModel){
        self.model = model
        
        accountLabel.text = model.account;
        moneyLabel.text = "$" + (model.money ?? "")
        publicAddressLabel.text = model.publicAddress;
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for subView in stackView.subviews {
            let button = subView as! GLButton
            button.imagePosition(style: .top, spacing: 10)
        }
    }
}
