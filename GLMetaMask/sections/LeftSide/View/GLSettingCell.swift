//
//  GLSettingCell.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/17.
//

import UIKit
class GLSettingCell: UITableViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellHeight() -> CGFloat{
        return 90
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.text = "钱包"
        return label
    }()
    
    
    //app_images_more
    lazy var contentTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondTitleColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.text = "钱包"
        return label
    }()
    
    lazy var moreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "app_images_more")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init( style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.commonBackgroundColor()
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(contentTitle)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant:15),
            titleLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor,constant: 15),
        ])
        
        NSLayoutConstraint.activate([
            contentTitle.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            contentTitle.topAnchor.constraint(equalTo:titleLabel.bottomAnchor,constant: 10),
        ])
        
        let line = UIView()
        line.backgroundColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 0.7)
        line.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(line)
        NSLayoutConstraint.activate([
            line.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            line.rightAnchor.constraint(equalTo:self.contentView.rightAnchor),
            line.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    func configData(model:GLSettingModel){
        titleLabel.text = model.title
        contentTitle.text = model.contentTitle
    }
}
    
