//
//  GLLeftViewCell.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/11.
//

import UIKit

class GLLeftSideViewCell: UITableViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellHeight() -> CGFloat{
        return 50
    }
    
    var leftViewModel:GLLeftViewModel?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.text = "钱包"
        return label
    }()

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 0.7)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    override init( style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.commonBackgroundColor()
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(line)
        NSLayoutConstraint.activate([
            iconImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant:15),
            iconImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant:15),
            titleLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            line.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            line.widthAnchor.constraint(equalTo:self.contentView.widthAnchor),
            line.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            line.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    func configData(model:GLLeftViewModel, isHiddenLine:Bool){
        titleLabel.text = model.title
        iconImageView.image = UIImage.init(named: model.imageName ?? "")
        leftViewModel = model
        line.isHidden = isHiddenLine
    }
}
