//
//  BaseViewController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/8.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    fileprivate lazy var titleView    : UIScrollView = UIScrollView()
    fileprivate lazy var contentTitleView  : UIView = UIView()
    fileprivate lazy var contentView : UIScrollView = UIScrollView()
    fileprivate lazy var btnArrays : [UIButton] = [UIButton]()
    
    var titleArray : [String]?{
        didSet{
            addAllButtons()
            
            addAlphaView(isLeft: true)
            addAlphaView(isLeft: false)
            
            addChildVC()
            addContentView()

        }
    }
    var image : UIImage?{
        didSet{
            addRightImageView()
        }
    }
    
    fileprivate lazy var indicatorView : UIView = UIView()
    fileprivate lazy var seletedButton : UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.groupTableViewBackground
         navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 251/255.0, green: 31/255.0, blue: 70/255.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.lightGray
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        addTitleView()
        addIndicatorView()
       
    }
}

//MARK: - 添加子控件
extension BaseViewController{
    /**
     *添加导航栏的View
     *
     */
    fileprivate func addTitleView(){
        contentTitleView.frame = CGRect(x: 0, y: 0, width: SCREENWITH - 40, height: 44)
        contentTitleView.backgroundColor = UIColor.clear
        
        titleView.frame = CGRect(x: 10, y: 0, width: SCREENWITH - 60, height: 44)
        titleView.backgroundColor = UIColor.clear
        titleView.showsVerticalScrollIndicator = false
        titleView.showsHorizontalScrollIndicator = false
        
        contentTitleView.addSubview(titleView)
        
        navigationItem.titleView = contentTitleView
    }
    
    /**
     *添加导航栏的button的底部指示器
     *
     */
    fileprivate func addIndicatorView(){
        indicatorView.frame = CGRect(x: 0, y: 41, width: titleView.frame.size.width / 5, height: 2)
        indicatorView.backgroundColor = UIColor.white
        
        titleView.addSubview(indicatorView)
    }
    
    /**
     *设置导航栏左右两边的透明度
     *
     */
    fileprivate func addAlphaView(isLeft : Bool){
        
        //为透明度设置渐变效果
        let alphaView = UIView(frame: CGRect(x: isLeft == true ? 0 : contentTitleView.frame.size.width - 10, y: 0, width: 20, height: 43))
        //        alphaView.backgroundColor = UIColor.white
        let colorOne = UIColor.init(red: 251/255.0, green: 31/255.0, blue: 70/255.0, alpha: 1.0)
        let colorTwo = UIColor.init(red: 251/255.0, green: 31/255.0, blue: 70/255.0, alpha: 0.0)
        
        let gradient = CAGradientLayer()
        
        //设置开始和结束位置(设置渐变的方向)
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        gradient.colors = isLeft == true ? [colorOne.cgColor,colorTwo.cgColor] : [colorTwo.cgColor,colorOne.cgColor]
        
        gradient.frame = CGRect(x: 0, y: 0, width: 20, height: 43)
        alphaView.layer.insertSublayer(gradient, at: 0)
        
        contentTitleView.addSubview(alphaView)
        
    }
    
    /**
     *添加导航栏的所有按钮
     *
     */
    fileprivate func addAllButtons(){
        
        let btnWith : CGFloat = titleView.frame.size.width / 5
        titleView.contentSize = CGSize(width: btnWith * CGFloat(titleArray!.count) , height: 0)
        
        for i in 0..<titleArray!.count {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: CGFloat(i) * btnWith, y: 0, width: btnWith, height: 40)
            button.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitle(titleArray![i], for: .normal)
            button.tag  = 100 + i
            button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
            
            if i == 0 {
                indicatorView.center.x = button.center.x
                seletedButton = button
                button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            }
            
            btnArrays.append(button)
            
            titleView.addSubview(button)
        }
    }
    
    /**
     *添加导航栏rightBarButtonItemw
     *
     */
    fileprivate func addRightImageView(){
        let rightItem = UIButton(type: .custom)
        rightItem.setImage(image, for: .normal)
        rightItem.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        rightItem.addTarget(self, action: #selector(clickRightItemButton), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightItem)
    }
    
    
    /**
     *添加内容的子控制器
     *
     */
    fileprivate func addChildVC() {
        
        for i in 0..<titleArray!.count {
            
            let topicVC = TopicViewController()
            topicVC.title = titleArray![i]
            
            addChildViewController(topicVC)
        }
    }
    
    /**
     *添加内容的大的UIScrollView
     *
     */
    fileprivate func addContentView() {
        
        automaticallyAdjustsScrollViewInsets = false
        contentView.frame = CGRect(x: 0, y: 0, width: SCREENWITH, height: SCREENHEIGHT)
        contentView.backgroundColor = UIColor.groupTableViewBackground
        contentView.delegate = self
        contentView.isPagingEnabled = true
        view.insertSubview(contentView, at: 0)
        contentView.contentSize = CGSize(width: SCREENWITH * CGFloat(titleArray!.count), height: 0)
        
        scrollViewDidEndScrollingAnimation(contentView)
    }
}


//MARK: - 事件处理
extension BaseViewController{
    
    /**
     *导航栏按钮的点击事件
     *
     */
    @objc fileprivate func clickButton(button : UIButton){
        
        seletedButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        var tag = button.tag - 100 - 2
        
        if button.tag - 100 <= 2 {
            tag = 0
        }
        
        if button.tag - 100 >= titleArray!.count - 3 {
            tag = titleArray!.count - 5
        }
        
        
        UIView.animate(withDuration: 0.25) {
            self.titleView.setContentOffset(CGPoint(x: button.frame.size.width * CGFloat(tag), y: 0), animated: true)
            self.indicatorView.center.x = button.center.x
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        }
        
        
        contentView.setContentOffset(CGPoint(x: CGFloat(button.tag - 100) * contentView.frame.size.width, y: 0), animated: true)
        
        seletedButton = button
    }
    
    /**
     *导航栏右边的rightItemButton的点击事件
     *
     */
    @objc fileprivate func clickRightItemButton(){
        
        print("clickrightItemButton")
    }
}

//MARK: - UIScrollViewDelegate
extension BaseViewController:UIScrollViewDelegate{
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index : Int = Int(scrollView.contentOffset.x / SCREENWITH)
        let vc = childViewControllers[index]

        vc.view.frame = CGRect(x: scrollView.contentOffset.x, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        
        scrollView.addSubview(vc.view)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        
        let index : Int = Int(scrollView.contentOffset.x / SCREENWITH)
        
        clickButton(button: btnArrays[index])
    }

    
}









