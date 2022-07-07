//
//  WalkThroughVC.swift
//  Litter Stopper
//
//  Created by Apple01 on 8/31/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import FSPagerView

class WalkThroughVC: UIViewController,FSPagerViewDataSource,FSPagerViewDelegate {
    //MARK:- Variable Declarations
    let arrImages = ["1.png","2.png","3.png","4.png","5.png"]
    var numberOfItems = 5
    //MARK:- IBOutlets
    @IBOutlet weak var btn_getstarted: UIButton!
    @IBOutlet var navViewHeightConstant: NSLayoutConstraint!
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pagerView.delegate = self
        self.pagerView.dataSource = self
        pagerView.backgroundColor = CLEAR_COLOR
        pageControl.backgroundColor = CLEAR_COLOR
        btn_getstarted.btnRoundCorner(cornerRadius: 20)
        if DeviceType.iPhoneX {
            navViewHeightConstant.constant = 74.0
        }
    }
    
    override func viewDidLayoutSubviews() {
        btn_getstarted.layer.cornerRadius = (btn_getstarted.layer.frame.height)/2
    }
    
    //MARK:- Button Actions
    @IBAction func getstartedBtn_Action(_ sender: Any) {
        DispatchQueue.main.async {
            isWalkThroughRead = true
            AppDelegate.sharedDelegate.setupMainController()
        }
    }
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            let newScale = 0.85 // [0.5 - 1.0]
            self.pagerView.itemSize = self.pagerView.frame.size.applying(CGAffineTransform(scaleX: CGFloat(newScale), y: CGFloat(newScale)))
        }
    }
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.arrImages.count
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    // MARK:- FSPagerView DataSource
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return arrImages.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.arrImages[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        //        cell.textLabel?.text = index.description+index.description
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        //        self.pageControl.currentPage = index
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex // Or 
    }
}


