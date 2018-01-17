//
//  ScanRecordViewController.swift
//  GeneralScan
//
//  Created by JJT on 2018/1/12.
//  Copyright © 2018年 JJT. All rights reserved.
//

import UIKit

let cellIdentifier = "cellIdentifier"

class ScanRecordViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var recordTableV : UITableView!
    var listArr = Array<RecordModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "入库记录"
        self.view.backgroundColor = grayBackColor
        self.tabBarController?.tabBar.isHidden = true
        
        
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
        
        recordTableV = UITableView(frame: CGRect(x: 0, y: 64, width: Screen_Width, height: Screen_Height), style: UITableViewStyle.plain)
        recordTableV.delegate = self
        recordTableV.dataSource = self
        recordTableV?.register(RecordCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(recordTableV)
        
        let urls = String(format: "%@ms-order-data/orderprint/findByOperation", BaseUrl)
        HttpRequestTool.shareInstance.requestData(requestType: .Get, url: urls, parameters:nil , succeed: { (response) in
            
            let daDic:[String:Any] = (response as! Dictionary)
            let dataArray = daDic["data"] as! NSArray
            
            dataArray.enumerateObjects { (mutableDict, idx, stop) -> Void in
                
                let disD:Dictionary = mutableDict as! Dictionary<String,Any>
                let model:RecordModel = RecordModel()
                model.consigneeName = disD["consigneeName"] as? String
                model.operationNum = disD["operationNum"] as! Int
                model.orderNo = disD["orderNo"] as? String
                model.staticNum = disD["staticNum"] as! Int
                model.foundtime = disD["foundtime"] as? CLong
                model.orderBalseOperationList = disD["orderBalseOperationList"] as? Array
                self.listArr.append(model)
                
            }
            
            self.recordTableV.reloadData()
            
        }) { (error) in
            
            guard error != nil else{
                return
            }
            print(error!)
        }
        
    }
    
    @objc func leftButonClick(){
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.listArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)as?RecordCell
        if cell == nil {
            cell = RecordCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        
        let model:RecordModel = self.listArr[indexPath.row]
        cell?.titleL?.text = "\(indexPath.row)"
        cell?.orderNoL?.text = model.orderNo
        cell?.numL?.text =  String(format:"%@/%@",String(stringInterpolationSegment: model.operationNum) ,String(stringInterpolationSegment: model.staticNum))
//        cell?.numL?.text =  String(format:"%@/%@","\(model.operationNum)" ,"\(model.staticNum)")
        
        
        let timeInterval:TimeInterval = TimeInterval(model.foundtime!/1000)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm" //自定义日期格式
        let time = dateformatter.string(from: date as Date)
        cell?.nameTimeL?.text = String(format:"%@  %@",model.consigneeName!,time)
        
        if model.operationNum==model.staticNum {
            cell?.stateL?.text = "全部入库";
        }else{
            cell?.stateL?.text = "部分入库";
            cell?.stateL?.textColor = UIColor.red
        }
        cell?.progressView?.progress = Float(model.operationNum)/Float(model.staticNum) //默认进度50%
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model:RecordModel = self.listArr[indexPath.row]
        let recordVC = RecordDetailViewController()
        recordVC.orderBalseOperationList = model.orderBalseOperationList
        recordVC.staticNum = model.staticNum
        recordVC.operationNum = model.operationNum
        recordVC.orderNo = model.orderNo
        
        self.navigationController?.pushViewController(recordVC, animated: true)
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    //  Dispose of any resources that can be recreated.
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
