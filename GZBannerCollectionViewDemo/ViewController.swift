//
//  ViewController.swift
//  GZBannerCollectionViewDemo
//
//  Created by gz on 16/4/24.
//  Copyright © 2016年 gz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // banner页
        let imageUrlArray = ["http://vimg.256.cc/uploads/2016/0405/20160405023650736.jpg","http://img.duoyun.io/fs/stream/news/3a-ca-3aca269cbb9d2eb16a23953e444b8a6b.jpg","http://i1.hdslb.com/bfs/archive/ec8434488296e759e13df82b38fe270b65c3471d.jpg"]
        
        let bannerUrlArray = ["www.baidu.com","http://www.163.com/","www.taobao.com"]
        
        let bannerView = GZBannerCollectionView(defaultFrame: CGRectMake(0, 64, UIScreen.mainScreen().bounds.width, 170), dataArray: imageUrlArray)
        bannerView.blockSelectCollectionViewAction = {(sender:NSInteger) -> Void in
            print("select index url is \(bannerUrlArray[sender])")
        }
        self.view.addSubview(bannerView)
        
        bannerView.backgroundColor = UIColor.orangeColor()
        
        
        
        // 滚动的字幕
        let messageArray = ["今日热门电影——《奇幻森林》","本月装B满分动画——《在下坂本，有何贵干？》","本月动画推荐——《甲铁城的卡巴内瑞》"]
        let scrollMessageView = GZMessageCollectionView(defaultFrame: CGRectMake(10, 250, UIScreen.mainScreen().bounds.width - 20, 45), dataArray: messageArray)
        scrollMessageView.blockSelectCollectionViewAction = {(sender:NSInteger) -> Void in
            print("select index is \(sender)")
        }
        self.view.addSubview(scrollMessageView)
        scrollMessageView.backgroundColor = UIColor.brownColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

