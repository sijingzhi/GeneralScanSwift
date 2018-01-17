//
//  HttpRequestTool.swift
//  GeneralScan
//
//  Created by JJT on 2018/1/10.
//  Copyright © 2018年 JJT. All rights reserved.
//

import UIKit
enum EagleRequestType {
    case Get
    case Post
}

class HttpRequestTool: AFHTTPSessionManager {

    static let shareInstance : HttpRequestTool = {
        let toolInstance = HttpRequestTool()
        
        toolInstance.requestSerializer.httpShouldHandleCookies = false
        toolInstance.requestSerializer.timeoutInterval = 20.0
        toolInstance.responseSerializer.acceptableContentTypes = NSSet(objects: "text/plain", "text/json", "application/json","text/javascript","text/html", "application/javascript", "text/js","text/xml","multipart/form-data") as? Set<String>
        
        toolInstance.securityPolicy.allowInvalidCertificates = true;
        
        toolInstance.requestSerializer = AFJSONRequestSerializer(writingOptions: JSONSerialization.WritingOptions(rawValue: 0))// 上传JSON格式
//        toolInstance.responseSerializer = AFJSONResponseSerializer()// AFN会JSON解析返回的数据
        AFJSONResponseSerializer().removesKeysWithNullValues = true;
        
        //获取当前版本号
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        toolInstance.requestSerializer.setValue(String(format: "%@","jujiabao"), forHTTPHeaderField:"app-code")
        toolInstance.requestSerializer.setValue(String(format: "%@",currentVersion), forHTTPHeaderField:"versionNo")
        
        return toolInstance
    }()
    
    func requestData(requestType : EagleRequestType, url : String, parameters : [String : Any]?, succeed : @escaping( Any?) -> (), failure : @escaping(Error?) -> ()) {
        if USER_DEFAULTS(Str: "token") != nil{
                HttpRequestTool.shareInstance.requestSerializer.setValue(String(format: "%@",USER_DEFAULTS(Str: "token")!), forHTTPHeaderField:"token")
        }
    
        // 成功闭包
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
         let daDic:[String:Any] = (responseObj as! Dictionary)
         let success:CFNumber = daDic["success"] as! CFNumber
            succeed(responseObj)
         if  Int(truncating: success) == 1{
            
            }else{
            MBShow(labText: daDic["error_message"]as! String)

            }
        }
        
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            
            let manager = AFNetworkReachabilityManager.shared()
            manager.startMonitoring()
            manager.setReachabilityStatusChange({ (status) in
                if status == AFNetworkReachabilityStatus.notReachable{
                    MBShow(labText: "网络异常")
                }else{
                    MBShow(labText: "服务器异常")
                }
            })
            manager.stopMonitoring()
            failure(error)
        }
        
        // Get 请求
        if requestType == .Get {
//            
//            HttpRequestTool.shareInstance.requestSerializer = AFHTTPRequestSerializer()//上传普通格式
//            HttpRequestTool.shareInstance.responseSerializer = AFJSONResponseSerializer()// AFN会JSON解析返回的数据
   
            get(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
            
            
        }
        // Post 请求
        if requestType == .Post {
       
            post(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
    }
    
    
    //图片上传
    func requestFiles(url : String, parameters : [String : Any]?, dataImage:UIImage,  succeed : @escaping( Any?) -> (), failure : @escaping(Error?) -> ()){
        // 成功闭包
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
            succeed(responseObj)
        }
        
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
        post(url, parameters: parameters, constructingBodyWith: { (formData) in
            let imageData = UIImagePNGRepresentation(dataImage)
            let fileNames = String(format: "%@.png", NSUUID().uuidString)
            formData.appendPart(withFileData: imageData!, name: "picture", fileName: fileNames, mimeType: "image.png")
        }, progress: nil, success: successBlock, failure: failureBlock)
        
        
        
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

}
