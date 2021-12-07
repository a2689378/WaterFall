//
//  CollectionViewController.swift
//  WaterFall
//
//  Created by 何常凱 on 2021/11/2.
//

import UIKit

private let reuseIdentifier = "Cell"
private let collectionViewContentInset = UIEdgeInsets(top: 10, left: 4, bottom: 10, right: 4)

class CollectionViewController: UICollectionViewController {
    
    var itemWidth: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = collectionViewContentInset
        
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.minimumInteritemSpacing = collectionViewContentInset.left
//        layout.minimumLineSpacing = collectionViewContentInset.left
//        let itemWidth = (collectionView.bounds.width - collectionViewContentInset.left * 3) / 2
//        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        let layout = collectionView.collectionViewLayout as! WaterFallLayout
        layout.delegate = self
        itemWidth = (collectionView.bounds.width - collectionViewContentInset.left - collectionViewContentInset.right - layout.columnSpacing) / CGFloat(layout.columnCount)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 16
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(named: "\(indexPath.item + 1)")
//        cell.label.text = "test"
        
        return cell
    }

}

extension CollectionViewController: WaterFallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat {
        let imageSize = UIImage(named: "\(indexPath.item + 1)")!.size
        let imageWidth = imageSize.width
        let imageHeight = imageSize.height
        let imageRatio = imageHeight / imageWidth
        
        return itemWidth * imageRatio + 20
    }
}
