//
//  SecondViewController.swift
//  换肤
//
//  Created by ShenYj on 16/7/18.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    

    @IBOutlet weak var secondImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }

    private func setupUI () -> () {
        
        secondImageView.image = ChangeSkinTool.sharedTool.setImageByCurrentSkin("baby")
        
    }
    

}
