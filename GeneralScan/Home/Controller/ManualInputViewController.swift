//
//  ManualInputViewController.swift
//  GeneralScan
//
//  Created by JJT on 2018/1/13.
//  Copyright © 2018年 JJT. All rights reserved.
//

import UIKit

class ManualInputViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "扫描入库"
        self.view.backgroundColor = grayBackColor
        self.tabBarController?.tabBar.isHidden = true
        let labelArr = ["订单号","包件号"]
        let placeholderArr = ["输入订单号","输入包件号"]
        for i in 0...1
        {
            let backV = UIView(frame: CGRect(x: 0, y: (70+YEYHeight(s: 26*4)*CGFloat(i)), width: Screen_Width, height: YEYHeight(s: 25*4)))
            backV.backgroundColor = UIColor.white
            self.view.addSubview(backV)
            
            let backL = UILabel(frame: CGRect(x: 18, y: 12, width:YEYWith(s: 120) , height:  YEYHeight(s: 46)))
            backL.text = labelArr[i]
            backL.font = SystemFont(m: 32)
            backV.addSubview(backL)
            
            let passwordTF = UITextField(frame: CGRect(x: backL.frame.maxX, y: 0, width:Screen_Width-YEYWith(s: 290), height: YEYHeight(s: 25*4)))
            passwordTF.placeholder = placeholderArr[i]
            passwordTF.keyboardType = .alphabet
            passwordTF.font = SystemFont(m: 30)
            passwordTF.tag = 100+i
            backV.addSubview(passwordTF)
            
        }
        
        
        let explainL = UILabel(frame: CGRect(x: 18, y: YEYHeight(s: 350), width:Screen_Width , height:  YEYHeight(s: 46)))
        explainL.text = "备注:包件码即A-B包件请在包件码栏输入00A00B"
        explainL.textColor = grayFontColor
        explainL.font =  SystemFont(m: 24)
        self.view.addSubview(explainL)
        
        let commitButon = UIButton(type: UIButtonType.custom)
        commitButon.frame = CGRect(x: 22.5*2, y:YEYHeight(s: 234*2), width: YEYWith(s: 143.5*4), height: YEYHeight(s: 25*4));
        commitButon.setTitle("提 交", for: .normal)
        commitButon.setTitleColor(UIColor.white, for: .normal)
        commitButon.backgroundColor = loginBackColor
        commitButon.titleLabel?.font = UIFont.boldSystemFont(ofSize: YEYWith(s: 32))
        commitButon.layer.cornerRadius = YEYWith(s: 10)
        commitButon.addTarget(self, action:#selector(btnClick), for: .touchUpInside)
        self.view.addSubview(commitButon)
        
        
//        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//        self.navigationItem.backBarButtonItem = item
        
        
        //设置按钮
        let leftButon = UIButton(type: UIButtonType.custom)
        leftButon.frame = CGRect(x: 0, y:0, width: 30, height: 64);
        leftButon.addTarget(self, action:#selector(leftButonClick), for: .touchUpInside)
        leftButon.setImage(UIImage(named:"home_page_right_row"), for: .normal)
        //        leftButon.backgroundColor = UIColor.red
        let LButon = UIBarButtonItem(customView: leftButon)
        
        
        // 重要方法，用来调整自定义返回view距离左边的距离
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = -10
        
        // 返回按钮设置成功
        navigationItem.leftBarButtonItems = [barButtonItem, LButon]
        
    }
    
    @objc func leftButonClick(){
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func btnClick(){
        
        let balseNo = self.view.viewWithTag(100) as! UITextField
        let orderNo = self.view.viewWithTag(101) as! UITextField
        if balseNo.text?.count == 0 {
            MBShow(labText: "单号为空")
            return;
        }
        
        if orderNo.text?.count == 0 {
            MBShow(labText: "包件为空")
            return;
        }
        let urls = String(format: "%@ms-order-data/putInStorage/appPutInStorage", BaseUrl)
        let paramas = ["balseNo":balseNo.text ?? "","orderNo":orderNo.text ?? ""] as [String : Any]
         ACTIVIVIEWSHOW()
        HttpRequestTool.shareInstance.requestData(requestType:.Post, url: urls, parameters:paramas , succeed: { (response) in
            
            ACTIVIVIEWREMOVE();
            
            let daDic:[String:Any] = (response as! Dictionary)
            let success:CFNumber = daDic["success"] as! CFNumber
            
            if  Int(truncating: success) == 1{
                
                MBShow(labText: "成功")
                balseNo.text = ""
            }
           
            
        }) { (error) in
            
            guard error != nil else{
                return
            }
            print(error!)
        }
        
       
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let phoneTF = self.view.viewWithTag(100) as! UITextField
        let codeTF = self.view.viewWithTag(101) as! UITextField
        phoneTF.resignFirstResponder()
        codeTF.resignFirstResponder()
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
