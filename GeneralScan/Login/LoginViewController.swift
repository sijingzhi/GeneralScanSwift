//
//  LoginViewController.swift
//  GeneralScan
//
//  Created by JJT on 2018/1/5.
//  Copyright © 2018年 JJT. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
   var parResult:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        let backImageV = UIImageView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        backImageV.image = UIImage(named:"background")
        backImageV.isUserInteractionEnabled = true;
        self.view.addSubview(backImageV)
        
        
        let passwordImV = UIImageView(frame: CGRect(x: Screen_Width/2.0-YEYWith(s: 180)/2.0, y: YEYHeight(s: 190), width: YEYWith(s: 180), height: YEYHeight(s: 180)))
        passwordImV.image = UIImage(named:"icon2")
        backImageV.addSubview(passwordImV)
   
        let imageArr = ["number","Login_Shape"]
        let placeholderArr = ["输入账号","输入密码"]
        for i in 0...1
        {
        
            let backV = UIView(frame: CGRect(x: 22.5*2, y: (passwordImV.frame.maxY+YEYHeight(s: 42*4)*CGFloat(i))+YEYHeight(s: 42*2), width: YEYWith(s: 143.5*4), height: YEYHeight(s: 25*4)))
            backV.backgroundColor = phoneBackColor
            backV.layer.cornerRadius = backV.frame.height/2.0;
            backImageV.addSubview(backV)
            
            let backImageV = UIImageView(frame: CGRect(x: 18, y: 12, width:YEYWith(s: 38) , height:  YEYHeight(s: 46)))
            backImageV.image = UIImage(named:imageArr[i])
            backImageV.isUserInteractionEnabled = true;
            backV.addSubview(backImageV)
            
            
            let passwordTF = UITextField(frame: CGRect(x: 50, y: 0, width:Screen_Width-YEYWith(s: 290), height: YEYHeight(s: 25*4)))
            passwordTF.placeholder = placeholderArr[i]
            passwordTF.font = SystemFont(m: 30)
            passwordTF.tag = 100+i
            passwordTF.textColor = UIColor.white
            passwordTF.keyboardType = .alphabet
            backV.addSubview(passwordTF)
            if i==0 {
              passwordTF.text = USER_DEFAULTS(Str: "telTF")
            }
            
        }
        
        let loginButon = UIButton(type: UIButtonType.custom)
        loginButon.frame = CGRect(x: 22.5*2, y:YEYHeight(s: 214*4), width: YEYWith(s: 143.5*4), height: YEYHeight(s: 25*4));
        loginButon.setTitle("登录", for: .normal)
        loginButon.setTitleColor(UIColor.black, for: .normal)
        loginButon.backgroundColor=UIColor.white
        loginButon.titleLabel?.font=UIFont.boldSystemFont(ofSize: YEYWith(s: 32))
        loginButon.layer.cornerRadius = YEYWith(s: 44)
        loginButon.addTarget(self, action:#selector(btnClick), for: .touchUpInside)
        self.view.addSubview(loginButon)
    }


    @objc func btnClick(){
        
        let urls = String(format: "%@ms-user-info/user/userLogin", BaseUrl)
        let phoneTF = self.view.viewWithTag(100) as! UITextField
        let codeTF = self.view.viewWithTag(101) as! UITextField
        let paramas = ["loginName":phoneTF.text,"pwd":codeTF.text]

        if phoneTF.text?.count == 0 {
            MBShow(labText: "请输入账户")
            return;
        }

        if codeTF.text?.count == 0 {
            MBShow(labText: "请输入密码")
            return;
        }
        ACTIVIVIEWSHOW()
        HttpRequestTool.shareInstance.requestData(requestType: .Post, url: urls, parameters:(paramas as Any as! [String : Any]) , succeed: { (response) in
         ACTIVIVIEWREMOVE()
            let daDic:[String:Any] = (response as! Dictionary)
            let success:CFNumber = daDic["success"] as! CFNumber
            
            if  Int(truncating: success) == 1{
                
                let dataDic:[String:Any] = daDic["data"] as! [String : Any]
                let userS = UserDefaults.standard
                userS.set(phoneTF.text, forKey:"telTF")
                userS.set(dataDic["token"] as! String, forKey:"token")
                userS.synchronize()
                
                let tabbarVC = TabbarViewController()
                tabbarVC.selectedIndex = 0;
                self.navigationController?.pushViewController(tabbarVC, animated: true)
                
            }
            

        
     

        }) { (error) in
            
            guard error != nil else{
                return
            }
            print(error!)
        }
        
    }
    func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
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
