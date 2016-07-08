//
//  ViewController.swift
//  WaterFlowDemo
//
//  Created by 王荣荣 on 7/8/16.
//  Copyright © 2016 王荣荣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var images = [UIImage]()
    private var layout: MyLayout!

    @IBOutlet weak var collectionView: UICollectionView!
    private let cellIdentifier = "cellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in 1...100 {
            let imageName = "images (\(index)).jpg"
            let image = UIImage(named: imageName)
            images.append(image!)
        }
        self.collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? MyLayout {
            self.layout = layout
            layout.numberOfColumns = 4
            layout.delegate = self
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let image = self.images[indexPath.item]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifier, forIndexPath: indexPath) as! MyCell
        cell.imageBtn.setBackgroundImage(image, forState: .Normal)
        cell.countLabel.text = "\(indexPath.item)"
        cell.delegate = self
        return cell
    }
}

extension ViewController: MyLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForCellAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let image = self.images[indexPath.item]
        let currentWidth = (collectionView.frame.size.width - CGFloat(layout.numberOfColumns + 1) * layout.cellPadding) / CGFloat(layout.numberOfColumns)
        let scale = image.size.width / currentWidth
        let height = image.size.height / scale
        
        return height
    }
}

extension ViewController: MyCellDelegate {

    func imageBtnDidClick(btn: UIButton) {
        
    }
}

