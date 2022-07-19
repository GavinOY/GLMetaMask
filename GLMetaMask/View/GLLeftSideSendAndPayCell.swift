//
//  GLLeftSendAndChangeCell.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/12.
//

import UIKit
class GLLeftSideSendAndPayCell: UITableViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellHeight() -> CGFloat{
        return 60
    }
    
    let buttonHeight:CGFloat = 40
    func createButton(title:String) -> UIButton{
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.commonBackgroundBlueColor(), for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = buttonHeight/2
        button.layer.borderColor = UIColor.commonBackgroundBlueColor().cgColor
        button.layer.borderWidth = 1
        return button
    }
    
    lazy var sendButton: UIButton = {
        let sendButton = createButton(title: "发送")
        return sendButton
    }()
    
    lazy var payButton: UIButton = {
        let payButton = createButton(title: "充值")
        return payButton
    }()
    
    lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 0.7)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
   @objc func onClickedSendButton(button:UIButton){
        print("onClickedSendButton")
    }
    
    @objc func onClickedPayButton(button:UIButton){
        print("onClickedPayButton")
    }
    
    override init( style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.commonBackgroundColor()
   
        self.contentView.addSubview(line)
        self.contentView.addSubview(sendButton)
        sendButton.addTarget(self, action: #selector(onClickedSendButton(button:)), for: .touchUpInside)
        self.contentView.addSubview(payButton)
        payButton.addTarget(self, action: #selector(onClickedPayButton(button:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            line.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            line.widthAnchor.constraint(equalTo:self.contentView.widthAnchor),
            line.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            line.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        let leftPadding :CGFloat = 8
        NSLayoutConstraint.activate([
            sendButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            sendButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: leftPadding),
            sendButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
        
        NSLayoutConstraint.activate([
            payButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            payButton.leftAnchor.constraint(equalTo: sendButton.rightAnchor,constant: leftPadding),
            payButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -leftPadding),
            payButton.widthAnchor.constraint(equalTo: sendButton.widthAnchor),
            payButton.heightAnchor.constraint(equalTo: sendButton.heightAnchor)
        ])
    }
    
}
