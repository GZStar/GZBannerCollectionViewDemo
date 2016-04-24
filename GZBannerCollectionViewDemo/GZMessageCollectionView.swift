//
//  GZMessageCollectionView.swift
//  GZBannerCollectionViewDemo
//
//  Created by gz on 16/4/24.
//  Copyright © 2016年 gz. All rights reserved.
//

import UIKit

// 继承自GZBannerCollectionView
class GZMessageCollectionView: GZBannerCollectionView {

    override init(defaultFrame: CGRect, dataArray: [AnyObject]) {
        super.init(defaultFrame: defaultFrame, dataArray: dataArray)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addCollectionView(direction: UICollectionViewScrollDirection) {
        super.addCollectionView(.Vertical)
        
        self.collectView.scrollEnabled = false
        self.collectView.contentOffset = CGPointMake(0, self.defaultFrame.size.height)
        self.collectView.registerClass(GZMessageCollectionViewCell.self, forCellWithReuseIdentifier: "GZMessageCollectionViewCell")
    }
    
    override func addPageControl() {
        print("not pagecontrol")
    }
    
    override func addRollTimer(interval: NSTimeInterval) {
        super.addRollTimer(3)
    }
    
    override func updateCollectionView() {
        dispatch_async(dispatch_get_main_queue()) {
            let point:CGPoint = self.collectView.contentOffset
            
            if point.y == self.collectView.frame.size.height * CGFloat(self.dataArray.count - 2) {
                self.collectView.contentOffset = CGPointMake(0, 0)
                self.collectView.scrollRectToVisible(CGRectMake(0,self.collectView.frame.size.height,self.collectView.frame.size.width,self.collectView.frame.size.height), animated: true)
            } else {
                self.collectView.scrollRectToVisible(CGRectMake(0,point.y + self.collectView.frame.size.height,self.collectView.frame.size.width,self.collectView.frame.size.height), animated: true)
            }
        }
    }
    
    // cell设置
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:GZMessageCollectionViewCell! = collectView.dequeueReusableCellWithReuseIdentifier("GZMessageCollectionViewCell", forIndexPath: indexPath) as? GZMessageCollectionViewCell
        
        let message = self.dataArray[indexPath.row] as! String
        
        cell.showMassage(message)
        return cell
    }
    
    // 点击cell
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("select index is \(indexPath.row)")
        blockSelectCollectionViewAction?(sender: indexPath.row - 1)
    }

}
