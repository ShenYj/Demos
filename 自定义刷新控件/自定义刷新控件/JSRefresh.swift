//
//  JSRefresh.swift
//  自定义刷新控件
//
//  Created by ShenYj on 16/7/1.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

import UIKit

// 自定义刷新控件的高度
let REFRESH_HEIGHT: CGFloat = 50

// 设置自定义刷新控件的背景色
let REFRESH_BACKGROUND_COLOR: UIColor = UIColor.orangeColor()

// 屏幕宽度
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width

// 自定义刷新控件文字状态字体大小
let STATUS_LABEL_FONT_SIZE: CGFloat = 15

// 自定义刷新控件文字字体颜色
let STATUS_LABEL_FONT_COLOR: UIColor = UIColor.purpleColor()



// 刷新控件的状态
enum JSRefreshType: Int {
    
    case Normal = 0      // 正常
    case Pulling = 1     // 下拉中
    case Refreshing = 2  // 刷新中
}

class JSRefresh: UIControl {

    // 被观察对象
    var scrollerView: UIScrollView?
    
    // MARK: - 懒加载控件
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(STATUS_LABEL_FONT_SIZE)
        label.textColor = STATUS_LABEL_FONT_COLOR
        label.textAlignment = .Center
        return label
    }()
    
    // 记录刷新控件状态,初始为正常状态
    var refreshStatus: JSRefreshType = .Normal{
        
        didSet{
            
            switch refreshStatus {
            case .Normal:
                statusLabel.text = "\(refreshStatus)"
                // 让自定义控件的上方间距恢复
                UIView.animateWithDuration(0.25, animations: { 
                    self.scrollerView?.contentInset.top -= REFRESH_HEIGHT
                })
                
            case .Pulling:
                statusLabel.text = "\(refreshStatus)"
            case .Refreshing:
                statusLabel.text = "\(refreshStatus)"
                
                //刷新中状态让自定义刷新控件保留显示
                UIView.animateWithDuration(0.25, animations: {
                    
                    self.scrollerView?.contentInset.top += REFRESH_HEIGHT
                    
                    }, completion: { (finished) in
                        
                        self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
                })
            
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: -REFRESH_HEIGHT, width: SCREEN_WIDTH, height: REFRESH_HEIGHT))
        
        // 设置视图
        setupUI()
    }
    
    // MARK: - 设置视图
    private func setupUI () {
        
        // 设置背景色
        backgroundColor = REFRESH_BACKGROUND_COLOR
        
        // 添加控件
        addSubview(statusLabel)
        
        // 添加约束
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: statusLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: statusLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        
    }
    
    // MARK: - 监听该类将要添加到哪个父控件上
    override func willMoveToSuperview(newSuperview: UIView?) {
        
        /*
             这里需要监测父控件的ContentOffSet判断状态
             因为其控制器可能会使用TableView的代理方法,代理为一对一,考虑到封装性,不推荐使用代理,所以这里使用KVO
         
                KVO的使用基本上都是三步：
          
                1.注册观察者
                    addObserver:forKeyPath:options:context:
                2.观察者中实现
                    observeValueForKeyPath:ofObject:change:context:
                3.移除观察者
                    removeObserver:forKeyPath:
         
         */
        
        // 判断是否有值,是否可以滚动
        guard let scrollerView = newSuperview as? UIScrollView else {
            
            return
        }
        
        self.scrollerView = scrollerView
        
        // 注册观察者
        scrollerView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil)
        
        
    }
    
    // 观察者实现
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        // 获取所监听的scrollView的Y轴偏移量
        let contentOffSetY = self.scrollerView!.contentOffset.y
        
        // 判断ScrollView是否正在拖动
        if scrollerView!.dragging {
            
            // 如果 scrollerView!.dragging == true 代表当前正在拖动ScrollView
            if contentOffSetY > -(REFRESH_HEIGHT+64) && refreshStatus == .Pulling {
                
                // contentOffSet.y > -(自定义刷新控件高度+64) && 当前状态为下拉中  --> 正常状态
                refreshStatus = .Normal
                
            } else if contentOffSetY <= -(REFRESH_HEIGHT+64) && refreshStatus == .Normal {
                
                // contentOffSet.y <= -(自定义刷新控件高度+64) && 当前状态为正常   --> 下拉状态
                refreshStatus = .Pulling
                
            }
            
        // 未拖动ScrollView时
        } else {
            
            // 停止拖动并松手,而且状态为下拉中   --> 刷新
            if refreshStatus == .Pulling {
                refreshStatus = .Refreshing
                
            }
            
        }
        
    }
    // MARK: - 结束刷新
    func endRefreshing() -> Void {
        // 将状态改为正常
        refreshStatus = .Normal
    }
    
    deinit{
        
        // 移除观察者
        self.scrollerView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
