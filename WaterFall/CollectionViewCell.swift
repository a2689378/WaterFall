//
//  CollectionViewCell.swift
//  WaterFall
//
//  Created by 何常凱 on 2021/11/2.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionCV: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionCV.layer.cornerRadius = 6
    }
}
