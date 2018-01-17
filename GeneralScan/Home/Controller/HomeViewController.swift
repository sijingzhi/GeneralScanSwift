//
//  HomeViewController.swift
//  GeneralScan
//
//  Created by JJT on 2018/1/11.
//  Copyright © 2018年 JJT. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = grayBackColor
        UINavigationBar.appearance().barTintColor = loginBackColor
        //改变导航栏的标题文字的颜色
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.title = "首 页"
        let titleArr = ["入库扫描","入库记录"]
        let imageArr = ["in storage","scanning recor"]
        for i in 0...1
        {
            let homeButon = UIButton(type: UIButtonType.custom)
            homeButon.frame = CGRect(x:0, y: (YEYHeight(s: 261)*CGFloat(i))+64, width: Screen_Width, height: YEYHeight(s: 260))
            homeButon.tag = 200+i
//            loginButon.setTitle(titleArr[i], for: .normal)
            homeButon.setTitleColor(UIColor.black, for: .normal)
            homeButon.backgroundColor = UIColor.white
            homeButon.titleLabel?.font = UIFont.boldSystemFont(ofSize: YEYWith(s: 32))
//            loginButon.setImage(UIImage(named:"in storage"), for: .normal)
            homeButon.set(image: UIImage(named: imageArr[i]), title: titleArr[i], titlePosition: .bottom,
                     additionalSpacing: 10.0, state:.normal)
            homeButon.addTarget(self, action:#selector(btnClick(_:)), for: .touchUpInside)
            self.view.addSubview(homeButon)
            
            if i==1 {
              homeButon.backgroundColor = grayBackColor
            }
            
        }
        
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
//        item.image = UIImage(named: "Shape1")

      
        
        
        
    
        
    }
    @objc func btnClick(_ button:UIButton){
        print(button.tag)
        
        switch button.tag {
        case 200:
            print(button.tag)
//            let scanVC = ScanViewController()
//            self.navigationController?.pushViewController(scanVC, animated: true)
            self.ZhiFuBaoStyle()
        case 201:
            let scanRVC = ScanRecordViewController()
            self.navigationController?.pushViewController(scanRVC, animated: true)
        default:
            print(button.tag)
        }
    }
    
    
    //MARK: ---模仿支付宝------
    func ZhiFuBaoStyle()
    {
        //设置扫码区域参数
        var style = LBXScanViewStyle()
        
        style.centerUpOffset = 60;
        style.xScanRetangleOffset = 30;
        
        if UIScreen.main.bounds.size.height <= 480
        {
            //3.5inch 显示的扫码缩小
            style.centerUpOffset = 40;
            style.xScanRetangleOffset = 20;
        }
        
        
        style.color_NotRecoginitonArea = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.4)
        
        
        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner;
        style.photoframeLineW = 2.0;
        style.photoframeAngleW = 16;
        style.photoframeAngleH = 16;
        
        style.isNeedShowRetangle = false;
        
        style.anmiationStyle = LBXScanViewAnimationStyle.NetGrid;
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_full_net")
        
        
        
        let vc = LBXScanViewController();
        vc.scanStyle = style
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
