//
//  BaseNavView.swift
//  PLBaseModule
//
//  Created by 张凯强 on 2022/1/27.
//

import UIKit
@objcMembers
public class BaseNavView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.centerStackView.centerXSuperView()
        self.centerStackView.heightEqualConstant(constant: 44)
        self.centerStackView.bottomSuperView()
        self.centerStackView.addArrangedSubview(self.titleLabel)

        self.leftStackView.left(anchor: self.leftAnchor, equalType: .equal, constant: 0)
        self.leftStackView.bottomSuperView()
        self.leftStackView.heightEqualConstant(constant: 44)
        
        self.rightStackView.rightSuperView(equalType: .equal, constant: -10)
        self.rightStackView.bottomSuperView()
        self.rightStackView.heightEqualConstant(constant: 44)
        self.leftStackView.addArrangedSubview(self.backBtn)
        self.backBtn.widthConstant(equalType: .equal, constant: 44)
        self.bottomBlackLineView.isHidden = true
    }
    
    
    public func addLeftView(children: UIView) {
        self.leftStackView.addArrangedSubview(children)
    }
    public func addrightView(children: UIView) {
        self.rightStackView.insertArrangedSubview(children, at: 0)        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public var title: String  {
        set {
            self.titleLabel.text = newValue

        }
        get {
            return self.titleLabel.text ?? ""
        }
    }
    

    public var attributeTitle: NSAttributedString = NSAttributedString.init(){
        didSet {
      
            self.titleLabel.attributedText = attributeTitle
            
        }
    }
    public var titleView: UIView?
    public var rightViewArr: [UIView] = []
    public var backgroundImage: UIImage?
    public var showBottomLineView: Bool = false {
        didSet {
            self.bottomBlackLineView.backgroundColor = showBottomLineView ? UIColor.lightGray : UIColor.clear
        }
    }
    
    public override func layoutSubviews() {
        if self.showBottomLineView {
            self.bringSubviewToFront(self.bottomBlackLineView)
        }
    }
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.textColor = UIColor.init(hexString: "282828")
        label.font = UIFont.init(name: pingfangSC_M, size: 18)
        label.textAlignment = .center
        return label
    }()
    public lazy var bottomBlackLineView: UIView = {
        let line = UIView.init()
        line.backgroundColor = .lightGray
        self.addSubview(line)
        line.bottomSuperView()
        line.leftSuperView()
        line.rightSuperView()
        line.heightEqualConstant(constant: 0.5)
        return line
    }()
    public lazy var backBtn: UIButton = {
        let btn = UIButton.init()
        btn.backgroundColor = .clear
        btn.setImage(UIImage.init(named: "ic_return"), for: .normal)
        btn.setTitle("", for: .normal)
        return btn
    }()
    
    lazy var leftStackView: UIStackView = {
        let stack = UIStackView.init()
        self.addSubview(stack)
        stack.distribution = .fill
        stack.spacing = 2
        stack.axis = .horizontal
        stack.alignment = .fill
        return stack
    }()
    lazy var rightStackView: UIStackView = {
        let stack = UIStackView.init()
        self.addSubview(stack)
        stack.distribution = .equalSpacing
        stack.spacing = 2
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }()
    
    
    lazy var centerStackView: UIStackView = {
        let stack = UIStackView.init()
        self.addSubview(stack)
        stack.distribution = .fill
        stack.spacing = 2
        stack.axis = .horizontal
        stack.alignment = .fill
        return stack
    }()

    
    


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
