//
//  GZBannerCollectionView.swift
//  GZBannerCollectionViewDemo
//
//  Created by gz on 16/4/24.
//  Copyright © 2016年 gz. All rights reserved.
//

import UIKit

public typealias BlockSelectCollectionViewCellAction = (sender:NSInteger) -> Void

class GZBannerCollectionView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var defaultFrame:CGRect
    var dataArray:[AnyObject]
    var collectView:UICollectionView!
    var pageControl:UIPageControl!
    var timer:NSTimer!
    var blockSelectCollectionViewAction: BlockSelectCollectionViewCellAction?
    
    deinit {
        // perform the deinitialization
        timer.invalidate()
        timer = nil
        
        collectView.delegate = nil;
        collectView.dataSource = nil;
    }
    
    init(defaultFrame: CGRect, dataArray: [AnyObject]) {
        self.defaultFrame = defaultFrame
        self.dataArray = dataArray
        
        if dataArray.count > 0 {
            let firstImageUrl = dataArray[0]
            let lastImageUrl = dataArray.last
            
            self.dataArray.insert(lastImageUrl!, atIndex: 0)
            self.dataArray.append(firstImageUrl)
            
        }
        
        super.init(frame: self.defaultFrame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        addCollectionView() // 添加collectionView
        addPageControl() // 添加PageControl
        addRollTimer() // 添加计时器
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCollectionView(direction:UICollectionViewScrollDirection = .Horizontal) {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = direction
        flowLayout.itemSize = frame.size
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        self.collectView = UICollectionView(frame: CGRectMake(0, 0, self.defaultFrame.size.width, self.defaultFrame.size.height), collectionViewLayout: flowLayout)
        self.collectView.pagingEnabled = true
        self.collectView.showsHorizontalScrollIndicator = false
        self.collectView.showsVerticalScrollIndicator = false
        self.collectView.backgroundColor = UIColor.clearColor()
        self.collectView.bounces = false
        self.collectView.delegate = self
        self.collectView.dataSource = self
        self.collectView.contentOffset = CGPointMake(self.defaultFrame.size.width, 0)
        
        self.collectView.registerClass(GZBannerCollectionViewCell.self, forCellWithReuseIdentifier: "GZBannerCollectionViewCell")
        
        self.addSubview(self.collectView)
    }
    
    func addPageControl() {
        self.pageControl = UIPageControl(frame: CGRectMake(0,self.bounds.size.height - 20,frame.size.width,10))
        self.pageControl.numberOfPages = self.dataArray.count - 2
        self.pageControl.userInteractionEnabled = false
        self.addSubview(self.pageControl)
    }
    
    func addRollTimer(interval:NSTimeInterval = 3) {
        if (self.dataArray.count > 1) {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: #selector(GZBannerCollectionView.updateCollectionView), userInfo: nil, repeats: true)
        }else{
            self.collectView.setContentOffset(CGPointMake(0, 0), animated: false)
        }
    }
    
    func updateCollectionView() {
        dispatch_async(dispatch_get_main_queue()) {
            let point:CGPoint = self.collectView.contentOffset
            
            if point.x == self.collectView.frame.size.width * CGFloat(self.dataArray.count - 2) {
                self.collectView.contentOffset = CGPointMake(0, 0)
                self.collectView.scrollRectToVisible(CGRectMake(self.collectView.frame.size.width,0,self.collectView.frame.size.width,self.collectView.frame.size.height), animated: true)
                self.pageControl.currentPage = 0
            } else {
                self.collectView.scrollRectToVisible(CGRectMake(point.x + self.collectView.frame.size.width,0,self.collectView.frame.size.width,self.collectView.frame.size.height), animated: true)
                self.pageControl.currentPage = NSInteger(self.collectView.contentOffset.x / CGFloat(self.bounds.size.width))
                
            }
        }
    }
}

extension GZBannerCollectionView {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    // cell设置
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:GZBannerCollectionViewCell! = collectView.dequeueReusableCellWithReuseIdentifier("GZBannerCollectionViewCell", forIndexPath: indexPath) as? GZBannerCollectionViewCell
        
        cell.setImageViewUrl(self.dataArray[indexPath.row] as! String)
        return cell
    }
    
    // 点击cell
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("select index is \(indexPath.row)")
        blockSelectCollectionViewAction?(sender: indexPath.row - 1)
    }
    
    // 手动滑动
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentPage = Int((self.collectView.contentOffset.x - self.collectView.frame.size.width / CGFloat(self.dataArray.count)) / self.collectView.frame.size.width) + 1;
        
        let page:Int = Int(self.collectView.contentOffset.x / self.collectView.frame.size.width)
        var controlPage:Int = 0
        if (page == self.dataArray.count - 2 || page == 0) {
            controlPage = self.dataArray.count - 2
        } else if (page == self.dataArray.count - 1 || page == 1){
            controlPage = 0
        } else{
            controlPage = page - 1
        }
        
        self.pageControl.currentPage = controlPage
        
        if currentPage == 0 {
            self.collectView.scrollRectToVisible(CGRectMake(self.collectView.frame.size.width * CGFloat((self.dataArray.count - 2)),0,self.collectView.frame.size.width,self.collectView.frame.size.height), animated: false) // 序号0 最后1页,不要动画
        } else if currentPage == self.dataArray.count - 1 {
            self.collectView.scrollRectToVisible(CGRectMake(self.collectView.frame.size.width,0,self.collectView.frame.size.width,self.collectView.frame.size.height), animated: false)  // 最后+1,循环第1页，不要动画
        }
    }
}