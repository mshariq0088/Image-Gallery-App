//
//  ImageViewModel.swift
//  ImageGalleryApp
//
//  Created by Mohammad Shariq on 30/09/24.
//

import Foundation

class ImageViewModel {
    
    func fetchImages(completion: @escaping ([ImageModel]) -> Void) {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/photos") {
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Failed to fetch data")
                    return
                }
                do {
                    let images = try JSONDecoder().decode([ImageModel].self, from: data)
                    completion(images)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            task.resume()
        }
    }
}
