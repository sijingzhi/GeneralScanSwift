//
//  MyViewController.swift
//  GeneralScan
//
//  Created by JJT on 2018/1/11.
//  Copyright © 2018年 JJT. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我 的";
        UINavigationBar.appearance().barTintColor = loginBackColor
        //改变导航栏的标题文字的颜色
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.view.backgroundColor = grayBackColor
        
        let backImageV = UIImageView(frame: CGRect(x: YEYWith(s: 144*2), y: YEYHeight(s: 132*2), width: YEYWith(s: 89*2), height: YEYHeight(s: 89*2)))
        backImageV.image = UIImage(named:"Group 4")
        backImageV.isUserInteractionEnabled = true;
        self.view.addSubview(backImageV)
        
        for i in 0...2{
            
            let nameL = UILabel(frame: CGRect(x: 0, y: backImageV.frame.maxY+10+YEYHeight(s: 25*2)*CGFloat(i), width: Screen_Width, height: YEYHeight(s: 25*2)))
            nameL.tag = 200+i
            nameL.textAlignment = .center
            nameL.textColor = grayFontColor
            self.view.addSubview(nameL)
            if i==0 {
            nameL.textColor = UIColor.black
            nameL.font = SystemFont(m: 36);
                
            }
        }
        
        let outButon = UIButton(type: UIButtonType.custom)
        outButon.frame = CGRect(x: 22.5*2, y:YEYHeight(s: 214*4), width: YEYWith(s: 143.5*4), height: YEYHeight(s: 25*4));
        outButon.setTitle("安全退出", for: .normal)
        outButon.setTitleColor(UIColor.white, for: .normal)
        outButon.backgroundColor = loginBackColor
        outButon.titleLabel?.font = UIFont.boldSystemFont(ofSize: YEYWith(s: 32))
        outButon.layer.cornerRadius=YEYWith(s: 22)
        outButon.addTarget(self, action:#selector(btnClick), for: .touchUpInside)
        self.view.addSubview(outButon)
    }
    @objc func btnClick(){
      
    let loginVC = LoginViewController();
    self.navigationController?.pushViewController(loginVC, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let urls = String(format: "%@ms-warehouse/warehouseInfo/info", BaseUrl)
        HttpRequestTool.shareInstance.requestData(requestType: .Get, url: urls, parameters:nil , succeed: { (response) in
            
            let daDic:[String:Any] = (response as! Dictionary)
            
            if let _:[String:Any] = daDic["data"] as? [String : Any]{
                
                let dataDic:[String:Any] = daDic["data"] as! [String : Any]
                let nameL = self.view.viewWithTag(200) as! UILabel
                let prinL = self.view.viewWithTag(201) as! UILabel
                let prinMobileL = self.view.viewWithTag(202) as! UILabel
                
                nameL.text = dataDic["name"] as? String
                prinL.text = dataDic["prin"] as? String
                prinMobileL.text = dataDic["prinMobile"] as? String
            }
            
        }) { (error) in
            
            guard error != nil else{
                return
            }
            print(error!)
        }
        
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
