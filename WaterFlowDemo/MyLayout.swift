//
//  MyLayout.swift
//  WaterFlowDemo
//
//  Created by 王荣荣 on 7/8/16.
//  Copyright © 2016 王荣荣. All rights reserved.
//

import UIKit

protocol MyLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForCellAtIndexPath indexPath: NSIndexPath) -> CGFloat
}

class MyLayout: UICollectionViewLayout {
    var delegate:MyLayoutDelegate!
    
    //2. Configurable properties
    var numberOfColumns = 2
    var cellPadding: CGFloat = 6.0
    
    //3. Array to keep a cache of attributes.
    private var cache = [UICollectionViewLayoutAttributes]()
    
    //4. Content height and size
    private var contentHeight:CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
    }
    
    override func prepareLayout() {
        if cache.isEmpty {
            
            // 2. Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth )
            }
            var column = 0
            var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
            
            // 3. Iterates through the list of items in the first section
            for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
                
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                
                // 4. Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
                let photoHeight = delegate.collectionView(collectionView!, heightForCellAtIndexPath: indexPath)
                let height = cellPadding +  photoHeight + cellPadding
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
                
                // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                // 6. Updates the collection view content height
                contentHeight = max(contentHeight, CGRectGetMaxY(frame))
                yOffset[column] = yOffset[column] + height
                
                if contentHeight <= CGRectGetMaxY(frame) {
                    column = column >= (numberOfColumns - 1) ? 0 : ++column
                }
            }
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(contentWidth, contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.cache
    }

}

extension ViewController: UICollectionViewDelegate {}
