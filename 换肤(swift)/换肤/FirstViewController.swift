//
//  FirstViewController.swift
//  换肤
//
//  Created by ShenYj on 16/7/18.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var firstImageView: UIImageView!
    
    @IBOutlet weak var isNightLabel: UILabel!

    @IBOutlet weak var isNigthSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    private func setupUI () -> Void{
        
        isNigthSwitch.on = ChangeSkinTool.sharedTool.currentSkin()
        
        firstImageView.image = ChangeSkinTool.sharedTool.setImageByCurrentSkin("girl")
        
    }
    
    
    @IBAction func isNightSwitchClick(sender: UISwitch) {
        
        // 保存皮肤状态
        ChangeSkinTool.sharedTool.saveCurrentSkinMode(sender.on)
        
        firstImageView.image = ChangeSkinTool.sharedTool.setImageByCurrentSkin("girl")
        
    }
    

}
