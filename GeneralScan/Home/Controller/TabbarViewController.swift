//
//  TabbarViewController.swift
//  GeneralScan
//
//  Created by JJT on 2018/1/11.
//  Copyright © 2018年 JJT. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = HomeViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem.image = UIImage(named: "home_shape")
        homeNav.tabBarItem.selectedImage = UIImage(named: "home_shape")?.withRenderingMode(.alwaysOriginal)
        // 改变字体的颜色
        homeNav.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : loginBackColor], for: .highlighted)
        homeNav.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font : SystemFont(m: 32)], for: .normal)
        homeNav.title = "首 页"
        
        let myVC = MyViewController()
        let myNav = UINavigationController(rootViewController: myVC)
        self.viewControllers = [homeNav,myNav]
        
        myNav.tabBarItem.image = UIImage(named: "Shape1")
        myNav.tabBarItem.selectedImage = UIImage(named: "Shape1_selected")?.withRenderingMode(.alwaysOriginal)
        // 改变字体的颜色
        myNav.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : loginBackColor], for: .highlighted)
        myNav.title = "我 的"
        myNav.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font : SystemFont(m: 32)], for: .normal)
        
        self.view.backgroundColor = UIColor.black
        self.tabBar.barTintColor = UIColor.black
        
        
        UINavigationBar.appearance().barTintColor = loginBackColor
        //改变导航栏的标题文字的颜色
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
