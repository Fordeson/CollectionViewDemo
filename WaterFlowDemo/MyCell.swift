//
//  MyCell.swift
//  WaterFlowDemo
//
//  Created by 王荣荣 on 7/8/16.
//  Copyright © 2016 王荣荣. All rights reserved.
//

import UIKit
@objc protocol MyCellDelegate {
    optional func imageBtnDidClick(btn: UIButton)
}

class MyCell: UICollectionViewCell {
    var delegate: MyCellDelegate!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var imageBtn: UIButton!
    
    @IBAction func imageBtnClick(sender: UIButton) {
        self.delegate.imageBtnDidClick!(sender)
    }
}
