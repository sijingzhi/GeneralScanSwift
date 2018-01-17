//
//  PublicFile.swift
//  GeneralScan
//
//  Created by JJT on 2018/1/5.
//  Copyright © 2018年 JJT. All rights reserved.
//

import Foundation
import UIKit

let Screen_Width = UIScreen.main.bounds.width
let Screen_Height = UIScreen.main.bounds.height


//收货仓信息
public  let WAREHOUSING_INFO = "ms-warehouse/warehouseInfo/info";
//入库
public  let STORAGE = "ms-order-data/putInStorage/appPutInStorage";
//入库记录
public  let SCAN_RECORD = "ms-order-data/orderprint/findByOperation";

let BaseUrl = "http://192.168.10.59:8763/"

func USER_DEFAULTS(Str:String) ->String?{
    return UserDefaults.standard.object(forKey: Str) as? String
}
func SWITCH_DEFAUL(str:String) -> Bool? {
    return UserDefaults.standard.object(forKey: str) as? Bool
}

//飘窗
func MBShow(labText:String) -> Void{
    let hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow, animated: true)
    hud?.mode = MBProgressHUDMode.text
    hud?.yOffset = Float(YEYHeight(s: -50))
    hud?.detailsLabelText = labText
    hud?.detailsLabelFont = SystemFont(m: 36)
    hud?.hide(true, afterDelay: 1)
}

func UIColorFromHex(rgbValue: Int) -> (UIColor) {
    
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                   alpha: 1.0)
    
}
func YEYWith(s:CGFloat) -> CGFloat {
    return s/750.0*Screen_Width
}
func YEYHeight(s:CGFloat) -> CGFloat {
    return s/1330.0*Screen_Height
}
func With(s:CGFloat) -> CGFloat {
    return s/1330.0*Screen_Width
}
func Height(s:CGFloat) -> CGFloat {
    return s/750.0*Screen_Height
}
//字体大小设置
func SystemFont(m:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: CGFloat(YEYWith(s:m)))
}


var activiView:UIActivityIndicatorView!
func ACTIVIVIEWSHOW() {
    activiView = UIActivityIndicatorView.init(activityIndicatorStyle:UIActivityIndicatorViewStyle.whiteLarge)
    activiView.color = UIColor.gray
    activiView.center = CGPoint(x: Screen_Width/2, y: Screen_Height/2)
    activiView.bounds = CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height)
    UIApplication.shared.keyWindow?.addSubview(activiView)
    activiView.startAnimating()
}
func ACTIVIVIEWREMOVE()
{
    activiView.stopAnimating()
    activiView.removeFromSuperview()
}

let loginBackColor = UIColorFromHex(rgbValue: 0xff8800)
let phoneBackColor = UIColorFromHex(rgbValue: 0xfbb261)
let grayBackColor = UIColorFromHex(rgbValue: 0xf8f8f8)
let grayFontColor = UIColorFromHex(rgbValue: 0x999999)
let progressViewColor = UIColorFromHex(rgbValue: 0x61c3d0)
let progressSelectColor = UIColorFromHex(rgbValue: 0xf8f8f8)

