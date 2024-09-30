//
//  ImageCollectionVC.swift
//  ImageGalleryApp
//
//  Created by Mohammad Shariq on 30/09/24.
//

import UIKit

class ImageCollectionVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var contentView: UIView!
    
    var images: [ImageModel] = []
    var viewModel = ImageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        fatchImages()
        gradientView()
    }
    
    
    //MARK:- Gradient View
    func gradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [
            UIColor(named: "canary")?.cgColor ?? "",
            UIColor(named: "pink")?.cgColor ?? ""
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0.0, 1.0]
        
        self.contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func fatchImages() {
        viewModel.fetchImages { [weak self] images in
            self?.images = images.reversed() // Show latest images first
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
}

extension ImageCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageViewCell
        let imageModel = images[indexPath.row]
        if let urlString = imageModel.thumbnailUrl, let url = URL(string: urlString) {
               cell.configure(with: url)
           } else {
               
               print("Invalid URL")
           }
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-20) / 3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageDetailsVC") as! ImageDetailsVC
        detailVC.imageModel = images
        detailVC.currentIndex = indexPath.row
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        self.navigationController?.view.layer.add(transition, forKey: kCATransition)

        self.navigationController?.pushViewController(detailVC, animated: false)
    }
}
