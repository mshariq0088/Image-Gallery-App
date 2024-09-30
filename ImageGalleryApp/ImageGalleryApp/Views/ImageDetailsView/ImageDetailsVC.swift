//
//  ImageDetailsVC.swift
//  ImageGalleryApp
//
//  Created by Mohammad Shariq on 30/09/24.
//

import UIKit

class ImageDetailsVC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    
    var imageModel: [ImageModel] = []
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayImage(at: currentIndex)
        setupGestures()
        gradientView()
        setUpUI()
    }
    
    //MARK:- Set Up UI
    func setUpUI() {
        imageView.layer.cornerRadius = 20
    }
    
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

    //MARK:- Display Images
    private func displayImage(at index: Int) {
        let imageModel = imageModel[index]
        if let urlString = imageModel.url, let url = URL(string: urlString) {
            ImageCacheManager.shared.loadImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        } else {
            print("Invalid URL")
        }
        titleText.text = imageModel.title
        
    }
    
    //MARK:- Set Up Gesture
    private func setupGestures() {
           let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
           swipeLeft.direction = .left
           view.addGestureRecognizer(swipeLeft)

           let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
           swipeRight.direction = .right
           view.addGestureRecognizer(swipeRight)
       }
    
    @objc private func didSwipe(_ gesture: UISwipeGestureRecognizer) {
           if gesture.direction == .left && currentIndex < imageModel.count - 1 {
               currentIndex += 1
               displayImage(at: currentIndex)
           } else if gesture.direction == .right && currentIndex > 0 {
               currentIndex -= 1
               displayImage(at: currentIndex)
           }
       }
}
