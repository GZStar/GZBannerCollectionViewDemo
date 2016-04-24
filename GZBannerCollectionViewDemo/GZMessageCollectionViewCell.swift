//
//  GZMessageCollectionViewCell.swift
//  GZBannerCollectionViewDemo
//
//  Created by gz on 16/4/24.
//  Copyright © 2016年 gz. All rights reserved.
//

import UIKit

class GZMessageCollectionViewCell: UICollectionViewCell {
    var contentLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentLabel = UILabel(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        self.contentLabel.textColor = UIColor.whiteColor()
        self.contentLabel.backgroundColor = UIColor.clearColor()
        self.contentLabel.font = UIFont.systemFontOfSize(15)
        self.addSubview(self.contentLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showMassage(message:String) {
        self.contentLabel.text = message
    }
}
