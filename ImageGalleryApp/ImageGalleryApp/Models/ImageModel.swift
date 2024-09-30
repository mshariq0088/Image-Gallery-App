//
//  ImageModel.swift
//  ImageGalleryApp
//
//  Created by Mohammad Shariq on 30/09/24.
//

import Foundation

struct ImageModel: Codable {
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
