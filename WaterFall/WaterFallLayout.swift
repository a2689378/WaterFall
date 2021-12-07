//
//  WaterFallLayout.swift
//  WaterFall
//
//  Created by 何常凱 on 2021/11/3.
//

import UIKit

protocol WaterFallLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat
}

class WaterFallLayout: UICollectionViewLayout {
    var columnCount = 2
    var columnSpacing: CGFloat = 4
    var lineSpacing: CGFloat = 4

    weak var delegate: WaterFallLayoutDelegate?
    
    var collectionViewContentWidth: CGFloat {
        guard let collectionView = collectionView else {return 0}
        return collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
    }
    
    var collectionViewContentHeight: CGFloat = 0
    
    //所有cell布局属性
    private var layoutAttributesArr: [UICollectionViewLayoutAttributes] = []
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionViewContentWidth, height: collectionViewContentHeight)
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView, layoutAttributesArr.isEmpty else {return}
        
        let itemWidth = (collectionViewContentWidth - columnSpacing) / CGFloat(columnCount)
        
        var x: [CGFloat] = []
        for col in 0..<columnCount {
            x.append((itemWidth + columnSpacing) * CGFloat(col))
        }
        
        var y: [CGFloat] = Array(repeating: 0, count: columnCount)
        
        
        var column = 0
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let itemHeight = delegate?.collectionView(collectionView, heightForItemAt: indexPath) ?? 100
            let itemFrame = CGRect(x: x[column], y: y[column], width: itemWidth, height: itemHeight)
            
            let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            layoutAttributes.frame = itemFrame
            layoutAttributesArr.append(layoutAttributes)
            
            collectionViewContentHeight = max(collectionViewContentHeight, itemFrame.maxY)
            
            //为下次循环做准备
            //更新y
            y[column] = y[column] + itemHeight + lineSpacing
            
            //更新column
            column = y.firstIndex(of: y.min()!)!
            
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributesArr: [UICollectionViewLayoutAttributes] = []
        for layoutAttributes in layoutAttributesArr {
            if layoutAttributes.frame.intersects(rect) {
                visibleLayoutAttributesArr.append(layoutAttributes)
            }
        }
        return visibleLayoutAttributesArr
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        layoutAttributesArr[indexPath.item]
    }
}
