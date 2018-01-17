//
//  LBXScanViewController.swift
//  swiftScan
//
//  Created by lbxia on 15/12/8.
//  Copyright © 2015年 xialibing. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

public protocol LBXScanViewControllerDelegate {
     func scanFinished(scanResult: LBXScanResult, error: String?)
}


open class LBXScanViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
 //返回扫码结果，也可以通过继承本控制器，改写该handleCodeResult方法即可
   open var scanResultDelegate: LBXScanViewControllerDelegate?
    
   open var scanObj: LBXScanWrapper?
    
   open var scanStyle: LBXScanViewStyle? = LBXScanViewStyle()
    
   open var qRScanView: LBXScanView?

    
    //启动区域识别功能
   open var isOpenInterestRect = false
    
    //识别码的类型
   public var arrayCodeType:[AVMetadataObject.ObjectType]?
    
    //是否需要识别后的当前图像
   public  var isNeedCodeImage = false
    
    //相机启动提示文字
   public var readyString:String! = "loading"

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // [self.view addSubview:_qRScanView];
        
        self.view.backgroundColor = UIColor.black
//      self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        self.title = "扫描入库"
        self.tabBarController?.tabBar.isHidden = true
        
        //设置按钮
        let rightButon = UIButton(type: UIButtonType.custom)
        rightButon.frame = CGRect(x: 0, y:0, width: 60, height: 64);
        rightButon.addTarget(self, action:#selector(rightButonClick), for: .touchUpInside)
        rightButon.setTitle("手动输入", for: .normal)
        let RButon = UIBarButtonItem(customView: rightButon)
        //设置按钮（注意顺序）
        self.navigationItem.rightBarButtonItems = [RButon]
        
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
    
    @objc func rightButonClick(){
        
        self.navigationController?.pushViewController(ManualInputViewController(), animated: true)
        
    }
    open func setNeedCodeImage(needCodeImg:Bool)
    {
        isNeedCodeImage = needCodeImg;
    }
    //设置框内识别
    open func setOpenInterestRect(isOpen:Bool){
        isOpenInterestRect = isOpen
    }
 
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        drawScanView()
       
        perform(#selector(LBXScanViewController.startScan), with: nil, afterDelay: 0.3)
        
    }
    
    @objc open func startScan()
    {
   
        if (scanObj == nil)
        {
            var cropRect = CGRect.zero
            if isOpenInterestRect
            {
                cropRect = LBXScanView.getScanRectWithPreView(preView: self.view, style:scanStyle! )
            }
            
            //指定识别几种码
            if arrayCodeType == nil
            {
                arrayCodeType = [AVMetadataObject.ObjectType.qr,AVMetadataObject.ObjectType.ean13,AVMetadataObject.ObjectType.code128]
            }
            
            scanObj = LBXScanWrapper(videoPreView: self.view,objType:arrayCodeType!, isCaptureImg: isNeedCodeImage,cropRect:cropRect, success: { [weak self] (arrayResult) -> Void in
                
                if let strongSelf = self
                {
                    //停止扫描动画
                    strongSelf.qRScanView?.stopScanAnimation()
                    
                    strongSelf.handleCodeResult(arrayResult: arrayResult)
                }
             })
        }
        
        //结束相机等待提示
        qRScanView?.deviceStopReadying()
        
        //开始扫描动画
        qRScanView?.startScanAnimation()
        
        //相机运行
        scanObj?.start()
    }
    
    open func drawScanView()
    {
        if qRScanView == nil
        {
            qRScanView = LBXScanView(frame: self.view.frame,vstyle:scanStyle! )
            self.view.addSubview(qRScanView!)
        }
        qRScanView?.deviceStartReadying(readyStr: readyString)
        
    }
   
    
    /**
     处理扫码结果，如果是继承本控制器的，可以重写该方法,作出相应地处理，或者设置delegate作出相应处理
     */
    open func handleCodeResult(arrayResult:[LBXScanResult])
    {
        if let delegate = scanResultDelegate  {
            
            self.navigationController? .popViewController(animated: true)
            let result:LBXScanResult = arrayResult[0]
            
            delegate.scanFinished(scanResult: result, error: nil)

        }else{
            
            for result:LBXScanResult in arrayResult
            {
                print("666%@",result.strScanned ?? "")
            }
            
            let result:LBXScanResult = arrayResult[0]
            
//          showMsg(title: result.strBarCodeType, message: result.strScanned)
            
            let daDic:[String:Any] =  self.getDictionaryFromJSONString(jsonString: result.strScanned!) as! [String : Any]
            
            let urls = String(format: "%@ms-order-data/putInStorage/appPutInStorage", BaseUrl)
            let paramas = ["balseNo":daDic["balseNo"] ?? "","orderNo":daDic["jujiatong"] ?? ""] as [String : Any]

            HttpRequestTool.shareInstance.requestData(requestType:.Post, url: urls, parameters:paramas , succeed: { (response) in
                
                self.scanObj?.start()
//                self.showMsg(title: result.strBarCodeType, message: "成功")

            }) { (error) in
                self.scanObj?.start()
                guard error != nil else{
                    return
                }
                print(error!)
            }
        }
    }
    
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
        
        
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        qRScanView?.stopScanAnimation()
        
        scanObj?.stop()
    }
    
    open func openPhotoAlbum()
    {
        LBXPermissions.authorizePhotoWith { [weak self] (granted) in
            
            let picker = UIImagePickerController()
            
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            picker.delegate = self;
            
            picker.allowsEditing = true
            
           self?.present(picker, animated: true, completion: nil)
        }
    }
    
    //MARK: -----相册选择图片识别二维码 （条形码没有找到系统方法）
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        picker.dismiss(animated: true, completion: nil)
        
        var image:UIImage? = info[UIImagePickerControllerEditedImage] as? UIImage
        
        if (image == nil )
        {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        
        if(image != nil)
        {
            let arrayResult = LBXScanWrapper.recognizeQRImage(image: image!)
            if arrayResult.count > 0
            {
                handleCodeResult(arrayResult: arrayResult)
                return
            }
        }
      
        showMsg(title: nil, message: NSLocalizedString("Identify failed", comment: "Identify failed"))
    }
    
    func showMsg(title:String?,message:String?)
    {
        
            let alertController = UIAlertController(title: nil, message:message, preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertActionStyle.default) { (alertAction) in
                
//                if let strongSelf = self
//                {
//                    strongSelf.startScan()
//                }
            }
            
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
    }
    deinit
    {
//        print("LBXScanViewController deinit")
    }
    
}





