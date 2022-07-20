//
//  GLLeftHeaderView.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/6/28.
//

import UIKit

class GLLeftSideHeaderView: UIView {
    var logoImageView: UIImageView!
    var appLogoLabel: UILabel!
    var avatarImageView: UIImageView!
    var accountLabel: UILabel!
    var moneyLabel: UILabel!
    var publicAddressLabel: UILabel!
    
    var model: GLAccountModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        logoImageView = UIImageView(frame: CGRect.zero)
        logoImageView.contentMode = UIView.ContentMode.scaleAspectFit
        logoImageView.image = UIImage(named: "logo")
        
        appLogoLabel = UILabel(frame: CGRect.zero)
        appLogoLabel.font = UIFont.systemFont(ofSize: 18)
        appLogoLabel.textColor = UIColor.white
        appLogoLabel.text = "METAMASK"
        appLogoLabel.textAlignment = NSTextAlignment.left
        
        avatarImageView = UIImageView(frame: CGRect.zero)
        avatarImageView.contentMode = UIView.ContentMode.scaleAspectFit
        avatarImageView.image = UIImage(named: "default_avatar")
        avatarImageView.layer.borderWidth = 3.0;
        avatarImageView.layer.borderColor = UIColor.commonBackgroundBlueColor().cgColor
        avatarImageView.layer.masksToBounds = true;
        
        accountLabel = UILabel(frame: CGRect.zero)
        accountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        accountLabel.textColor = UIColor.white
        accountLabel.textAlignment = NSTextAlignment.left
        
        moneyLabel = UILabel(frame: CGRect.zero)
        moneyLabel.font = UIFont.systemFont(ofSize: 15)
        moneyLabel.textColor = UIColor.white
        moneyLabel.textAlignment = NSTextAlignment.left

        publicAddressLabel = UILabel(frame: CGRect.zero)
        publicAddressLabel.font = UIFont.systemFont(ofSize: 11)
        publicAddressLabel.textColor = UIColor.white
        publicAddressLabel.lineBreakMode = NSLineBreakMode.byTruncatingMiddle
        publicAddressLabel.textAlignment = NSTextAlignment.left
        
        self.addSubview(logoImageView)
        self.addSubview(appLogoLabel)
        self.addSubview(avatarImageView)
        self.addSubview(accountLabel)
        self.addSubview(moneyLabel)
        self.addSubview(publicAddressLabel)
        
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 35),
            logoImageView.heightAnchor.constraint(equalToConstant: 20),
            logoImageView.widthAnchor.constraint(equalToConstant: 20),
            logoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
        ])
        
        appLogoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appLogoLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            appLogoLabel.leftAnchor.constraint(equalTo: logoImageView.rightAnchor,constant:10)
        ])
        
        //imageView约束
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        let avatarWidth = 60.0
        let maxWidth = 100.0
        avatarImageView.layer.cornerRadius = avatarWidth/2
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarWidth),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarWidth),
            avatarImageView.leftAnchor.constraint(equalTo: self.logoImageView.leftAnchor)
        ])
        
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accountLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 15),
            accountLabel.widthAnchor.constraint(equalToConstant: maxWidth),
            accountLabel.leftAnchor.constraint(equalTo: avatarImageView.leftAnchor)
        ])
        
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moneyLabel.topAnchor.constraint(equalTo: accountLabel.bottomAnchor, constant: 10),
            moneyLabel.widthAnchor.constraint(equalToConstant: maxWidth),
            moneyLabel.leftAnchor.constraint(equalTo: accountLabel.leftAnchor),
        ])
        
        publicAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            publicAddressLabel.topAnchor.constraint(equalTo: moneyLabel.bottomAnchor, constant: 10),
            publicAddressLabel.widthAnchor.constraint(equalToConstant: maxWidth),
            publicAddressLabel.leftAnchor.constraint(equalTo: moneyLabel.leftAnchor),
        ])
    }
    
    convenience init(model: GLAccountModel) {
        self.init(frame: CGRect(x: 0, y: 0, width: 260, height: 240))
        
        self.model = model
        
        accountLabel.text = model.account;
        moneyLabel.text = "$" + (model.money ?? "");
        publicAddressLabel.text = model.publicAddress;
        
    }
}
