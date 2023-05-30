//
//  CatCollectionViewCell.swift
//  CAT_API
//
//  Created by 김은지 on 2023/05/30.
//
import SDWebImage
import Foundation
import UIKit

class CatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var catImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        catImageView.sd_imageTransition = .fade
        catImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray

    }
    
}
