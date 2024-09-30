//
//  ImageViewCell.swift
//  ImageGalleryApp
//
//  Created by Mohammad Shariq on 30/09/24.
//

import UIKit

class ImageViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    func configure(with url: URL) {
            ImageCacheManager.shared.loadImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
}
