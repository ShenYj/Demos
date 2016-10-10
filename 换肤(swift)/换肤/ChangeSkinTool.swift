//
//  ChangeSkinTool.swift
//  换肤
//
//  Created by ShenYj on 16/7/18.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

import UIKit

class ChangeSkinTool: NSObject {
    
    // 全局访问点
    static let sharedTool: ChangeSkinTool = ChangeSkinTool()
    
    private var isNight: Bool = false
    
    override init() {
        super.init()
        
       isNight = NSUserDefaults.standardUserDefaults().boolForKey("isNightMode")
        
    }
    
    
    // 根据皮肤设置图片
    func setImageByCurrentSkin (imageName: String) -> UIImage {
        
        var name: String = imageName
        if isNight {
            
            name = "\(imageName)_night"
        }
        return UIImage(named: name)!
        
    }
    
    // 返回当前皮肤状态
    func currentSkin() -> Bool {
        return isNight
    }
    
    // 保存当前皮肤状态
    func saveCurrentSkinMode(isNightMode: Bool) -> Void {
        
        isNight = isNightMode
        // 本地化
        NSUserDefaults.standardUserDefaults().setBool(isNightMode, forKey: "isNightMode")
        NSUserDefaults.standardUserDefaults().synchronize()
    }

}
