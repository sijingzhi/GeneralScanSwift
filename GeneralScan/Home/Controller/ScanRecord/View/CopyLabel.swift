//
//  CopyLabel.swift
//  GeneralScan
//
//  Created by JJT on 2018/1/17.
//  Copyright © 2018年 JJT. All rights reserved.
//

import UIKit

//class CopyLabel: UILabel {
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//
//}
class CopyLabel: UILabel {
    
    override var canBecomeFirstResponder: Bool { return true }
    
    // 代码创建控件的时候有效
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // storyboard或xib创建控件的时候有效
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // 让其有交互能力，并添加一个长按手势
    func setup() {
        isUserInteractionEnabled = true
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(clickLabel)))
    }
    
    @objc func clickLabel() {
        
        // 让其成为响应者
        becomeFirstResponder()
        
        // 拿出菜单控制器单例
        let menu = UIMenuController.shared
        // 创建一个复制的item
        let copy = UIMenuItem(title: "复制", action: #selector(copyText))
        // 将复制的item交给菜单控制器（菜单控制器其实可以接受多个操作）
        menu.menuItems = [copy]
        // 设置菜单控制器的点击区域为这个控件的bounds
        menu.setTargetRect(bounds, in: self)
        // 显示菜单控制器，默认是不可见状态
        menu.setMenuVisible(true, animated: true)
        
    }
    
    @objc func copyText() {
        
        UIPasteboard.general.string = self.text
        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(copyText) {
            return true
        } else {
            return false
        }
    }
}


