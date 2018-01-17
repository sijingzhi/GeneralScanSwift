//
//  BalseNoCell.swift
//  GeneralScan
//
//  Created by JJT on 2018/1/16.
//  Copyright © 2018年 JJT. All rights reserved.
//

import UIKit

class BalseNoCell: UITableViewCell {

    var balseNo:UILabel?
    var founder:UILabel?
    var foundtime:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        
        for i in 0...2{
            
            let nameL = UILabel(frame: CGRect(x: (Screen_Width-40)*CGFloat(i)/3, y: 0, width: (Screen_Width-40)/3, height: YEYHeight(s: 44*2)))
            nameL.tag = 200+i
            nameL.text = "567"
            nameL.textAlignment = .center
            nameL.textColor = grayFontColor
            self.addSubview(nameL)
            if i==0 {
                nameL.textColor = UIColor.black
                nameL.font = SystemFont(m: 36);
                balseNo = nameL
                
            }else  if i==1 {
                founder = nameL
            }
            else  if i==2 {
                foundtime = nameL
                 nameL.font = SystemFont(m: 30);
            }
        }
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
