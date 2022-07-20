//
//  GLSwapNumberInputView.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/7/19.
//

import UIKit
import SwiftUI

enum GLSwapButtonType {
    case number
    case dot
    case delete
}

class GLSwapButton : UIButton {
    var type:GLSwapButtonType
    
    init(type:GLSwapButtonType,title:String) {
        self.type = type
        super.init(frame: CGRect.zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 0.4), for: .highlighted)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol GLSwapNumberInputViewDelegate: AnyObject {
    func onClickedSwapNumbersButton(type:GLSwapButtonType,title:String)
}


class GLSwapNumberInputView: UIView {
    weak var delegate:GLSwapNumberInputViewDelegate?
    lazy var stackView: UIStackView = {
        let dotButton = createButtons(type: .dot, title: ".")
        let numsButton = createButtons(type: .number, title: "0")
        let deleteButton = createButtons(type: .delete, title: " ⃪")
        let stackView = UIStackView(arrangedSubviews: [dotButton, numsButton, deleteButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    
        return stackView
    }()
    
    func createStackView() ->UIStackView{
        let stackView = UIStackView.init()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCustom()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCustom(){
        let numsButtons = NSMutableArray.init()
        for index in 1...9 {
            let button = createButtons(type: .number, title: String(index))
            numsButtons.add(button)
        }
        
        let stackView1 = createStackView()
        stackView1.addArrangedSubview(numsButtons[0] as! UIView)
        stackView1.addArrangedSubview(numsButtons[1] as! UIView)
        stackView1.addArrangedSubview(numsButtons[2] as! UIView)
        
        let stackView2 = createStackView()
        stackView2.addArrangedSubview(numsButtons[3] as! UIView)
        stackView2.addArrangedSubview(numsButtons[4] as! UIView)
        stackView2.addArrangedSubview(numsButtons[5] as! UIView)
        
        let stackView3 = createStackView()
        stackView3.addArrangedSubview(numsButtons[6] as! UIView)
        stackView3.addArrangedSubview(numsButtons[7] as! UIView)
        stackView3.addArrangedSubview(numsButtons[8] as! UIView)
        
        let dotButton = createButtons(type: .dot, title: ".")
        let numsButton = createButtons(type: .number, title: "0")
        let deleteButton = createButtons(type: .delete, title: " ⃪")
        let stackView4 = createStackView()
        stackView4.addArrangedSubview(dotButton)
        stackView4.addArrangedSubview(numsButton)
        stackView4.addArrangedSubview(deleteButton)
        
        addSubview(stackView1)
        addSubview(stackView2)
        addSubview(stackView3)
        addSubview(stackView4)
        
        NSLayoutConstraint.activate([
            stackView1.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView1.topAnchor.constraint(equalTo: self.topAnchor),
            stackView1.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView2.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView2.topAnchor.constraint(equalTo: stackView1.bottomAnchor,constant: 5),
            stackView2.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView2.heightAnchor.constraint(equalTo: stackView1.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView3.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView3.topAnchor.constraint(equalTo: stackView2.bottomAnchor,constant: 5),
            stackView3.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView3.heightAnchor.constraint(equalTo: stackView1.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView4.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView4.topAnchor.constraint(equalTo: stackView3.bottomAnchor,constant: 5),
            stackView4.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView4.heightAnchor.constraint(equalTo: stackView1.heightAnchor),
            stackView4.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func createButtons(type:GLSwapButtonType,title:String) ->GLSwapButton{
        let button = GLSwapButton.init(type: type, title: title)
         button.addTarget(self, action: #selector(onClickedButton(button:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    @objc func onClickedButton(button:GLSwapButton){
        self.delegate?.onClickedSwapNumbersButton(type: button.type, title: button.titleLabel?.text ?? "")
    }
}
