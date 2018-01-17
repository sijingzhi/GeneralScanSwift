//
//  RecordDetailViewController.swift
//  GeneralScan
//
//  Created by JJT on 2018/1/16.
//  Copyright © 2018年 JJT. All rights reserved.
//

import UIKit

class RecordDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
       var orderBalseOperationList:Array<Any>?
       var recordTableV : UITableView!
       var staticNum:Int = 0
        var orderNo:String?
       var operationNum:Int = 0
       var listArr = Array<RecordModel>()
    
       override func viewDidLoad() {
       super.viewDidLoad()
        
        
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
        

        self.title = self.orderNo
        self.view.backgroundColor = grayBackColor
        self.tabBarController?.tabBar.isHidden = true
        
        let backV = UIView(frame: CGRect(x: 20, y: 74, width: Screen_Width-40, height: Screen_Height-64-50-20))
        backV.backgroundColor = UIColor.white
        self.view.addSubview(backV)
        
        let titleArr = ["包件号","操作者","入库时间"]
        
        for i in 0...2{
            
            let titleL = UILabel(frame: CGRect(x: (Screen_Width-40)*CGFloat(i)/3, y: 5, width: (Screen_Width-40)/3, height: YEYHeight(s: 44*2)))
            titleL.tag = 200+i
            titleL.text = titleArr[i]
            titleL.textAlignment = .center
            titleL.font = SystemFont(m: 36);
            titleL.textColor = UIColor.black
            backV.addSubview(titleL)
        }
        
        
        recordTableV = UITableView(frame: CGRect(x: 0, y: YEYHeight(s: 46*2), width: backV.frame.width, height: backV.frame.height-YEYHeight(s: 46*2)), style: UITableViewStyle.plain)
        recordTableV.delegate = self
        recordTableV.dataSource = self
        recordTableV?.register(BalseNoCell.self, forCellReuseIdentifier: cellIdentifier)
        backV.addSubview(recordTableV)
        
        let inPutButon = UIButton(type: UIButtonType.custom)
        inPutButon.frame = CGRect(x:0, y:Screen_Height-50, width: Screen_Width, height: 50);
        inPutButon.setTitle("全部入库", for: .normal)
        inPutButon.setTitleColor(UIColor.white, for: .normal)
        inPutButon.backgroundColor=loginBackColor
        inPutButon.titleLabel?.font=UIFont.boldSystemFont(ofSize: YEYWith(s: 32))
        inPutButon.addTarget(self, action:#selector(inPutButonClick), for: .touchUpInside)
        self.view.addSubview(inPutButon)
        
        if self.operationNum==self.staticNum {
            inPutButon.setTitle("全部入库", for: .normal)
        }else{
            inPutButon.setTitle("部分入库", for: .normal)
        }
        
    
        let dataArray = orderBalseOperationList! as NSArray
        dataArray.enumerateObjects { (mutableDict, idx, stop) -> Void in
            
            let disD:Dictionary = mutableDict as! Dictionary<String,Any>
            let model:RecordModel = RecordModel()
            model.balseNo = disD["balseNo"] as? String
            model.founder = disD["founder"] as? String
            model.foundtime = disD["foundtime"] as? CLong
           
            self.listArr.append(model)
        }
        
        self.recordTableV.reloadData()
        
    }
    
    @objc func leftButonClick(){
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func inPutButonClick() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)as?BalseNoCell
        if cell == nil {
            cell = BalseNoCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        let model:RecordModel = self.listArr[indexPath.row]
        cell?.balseNo?.text = model.balseNo
        cell?.founder?.text = model.founder
//        cell?.foundtime?.text = String(stringInterpolationSegment: model.foundtime)
       
        let timeInterval:TimeInterval = TimeInterval(model.foundtime!/1000)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd HH:mm" //自定义日期格式
        let time = dateformatter.string(from: date as Date)
        cell?.foundtime?.text  = time
        return cell!
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
