//
//  GZBannerCollectionViewCell.swift
//  GZBannerCollectionViewDemo
//
//  Created by gz on 16/4/24.
//  Copyright © 2016年 gz. All rights reserved.
//

import UIKit
import Kingfisher

class GZBannerCollectionViewCell: UICollectionViewCell {
    var imageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tempImageView = UIImageView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        
        self.addSubview(tempImageView)
        self.imageView = tempImageView
        self.imageView.frame = self.bounds
        self.backgroundColor = UIColor.clearColor()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageViewUrl(urlString:String) {
        self.imageView.kf_setImageWithURL(NSURL(string: urlString)!, placeholderImage: UIImage(named: "placeholderImage"))
    }    
}