//
//  GLSwapSearchCell.swift
//  GLMetaMask
//
//  Created by  Gavin on 2022/7/19.
//

import UIKit

class GLSwapSearchCell: UITableViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellHeight() -> CGFloat{
        return 70
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.text = "DAI"
        return label
    }()

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.text = "DAI Stablecoin"
        return label
    }()
    
    func configData(model:GLCoinModel){
        titleLabel.text = model.symbol
        contentLabel.text = model.name
        let url = URL(string:model.iconUrl ?? "")
        //
        
        iconImageView.kf.setImage(with: url, placeholder: UIImage.init(named: "defaultCoin"), options: nil, completionHandler: nil)
    }
    
    override init( style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.commonBackgroundColor()
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(iconImageView)
        
        iconImageView.layer.masksToBounds = true
        let imageWidth :CGFloat = 45
        iconImageView.layer.cornerRadius = CGFloat(imageWidth/2)
        NSLayoutConstraint.activate([
            iconImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant:10),
            iconImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            iconImageView.heightAnchor.constraint(equalToConstant: imageWidth),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant:8),
            titleLabel.bottomAnchor.constraint(equalTo:self.contentView.centerYAnchor,constant: -2),
        ])
        
        NSLayoutConstraint.activate([
            contentLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            contentLabel.topAnchor.constraint(equalTo:self.contentView.centerYAnchor,constant: 2),
        ])
    }
}
