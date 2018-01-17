//
//  RecordCell.swift
//  GeneralScan
//
//  Created by JJT on 2018/1/15.
//  Copyright © 2018年 JJT. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {
    
    
    var titleL:UILabel?
    var orderNoL:UILabel?
    var progressView:UIProgressView?
    var nameTimeL:UILabel?
    var stateL:UILabel?
    var numL:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setUpUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        
    self.titleL = UILabel.init()
    self.titleL?.backgroundColor = UIColor.clear;
    self.titleL?.frame = CGRect(x:YEYWith(s: 20), y:YEYHeight(s: 50), width:YEYWith(s: 100), height:YEYHeight(s: 100))
    self.titleL?.textColor = UIColor.black
    self.titleL?.font = SystemFont(m: 28)
    self.titleL?.textAlignment = NSTextAlignment.left
    self.addSubview(self.titleL!)
        
        
    self.orderNoL = UILabel.init()
    self.orderNoL?.backgroundColor = UIColor.clear;
        self.orderNoL?.frame = CGRect(x:(self.titleL?.frame.maxX)!, y:0, width:YEYWith(s: 400), height:YEYHeight(s: 100))
    self.orderNoL?.textColor = UIColor.black
    self.orderNoL?.font = SystemFont(m: 32)
    self.orderNoL?.textAlignment = NSTextAlignment.left
    self.addSubview(self.orderNoL!)
        
        
    self.numL = UILabel.init()
    self.numL?.backgroundColor = UIColor.clear;
    self.numL?.frame = CGRect(x:Screen_Width-80, y:0, width:70, height:YEYHeight(s: 100))
   
    self.numL?.textColor = progressViewColor
    self.numL?.font = SystemFont(m: 32)
    self.numL?.textAlignment = NSTextAlignment.right
    self.addSubview(self.numL!)
        
        
    self.progressView = UIProgressView(progressViewStyle:UIProgressViewStyle.default)
    self.progressView?.center = self.center
   
    self.progressView?.frame = CGRect(x:(self.titleL?.frame.maxX)!, y:(self.orderNoL?.frame.maxY)!, width:YEYWith(s: 450), height:YEYHeight(s: 100))
    self.progressView?.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
    self.progressView?.progressTintColor = UIColor.red
    self.progressView?.trackTintColor = progressViewColor
    self.progressView?.layer.cornerRadius = (self.progressView?.frame.height)!
    self.progressView?.layer.masksToBounds = true
    self.addSubview(self.progressView!);
        
        
    self.stateL = UILabel.init()
    self.stateL?.backgroundColor = UIColor.clear;
    self.stateL?.frame = CGRect(x:Screen_Width-YEYWith(s: 180), y:(self.numL?.frame.maxY)!, width:YEYWith(s: 160), height:YEYHeight(s: 100))
    self.stateL?.text = "全部入库"
    self.stateL?.textColor = progressViewColor
    self.stateL?.font = SystemFont(m: 28)
    self.stateL?.textAlignment = NSTextAlignment.right
    self.addSubview(self.stateL!)
        
        
    self.nameTimeL = UILabel.init()
    self.nameTimeL?.backgroundColor = UIColor.clear;
    self.nameTimeL?.frame = CGRect(x:(self.titleL?.frame.maxX)!, y:(self.progressView?.frame.maxY)!, width:Screen_Width, height:YEYHeight(s: 60))
    self.nameTimeL?.textColor = UIColor.lightGray
    self.nameTimeL?.font = SystemFont(m: 28)
    self.nameTimeL?.textAlignment = NSTextAlignment.left
    self.addSubview(self.nameTimeL!)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    // Configure the view for the selected state
    }

}
