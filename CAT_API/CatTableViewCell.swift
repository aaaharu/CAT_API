//
//  CatTableViewCell.swift
//  CAT_API
//
//  Created by 김은지 on 2023/05/30.
//

import UIKit
import Foundation
import SDWebImage


class CatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var catImageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
            print(#fileID, #function, #line, "- <# 주석 #>")
      
        catImageView.sd_imageTransition = .fade
        catImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray

        
    }
    
    
    
    
}
