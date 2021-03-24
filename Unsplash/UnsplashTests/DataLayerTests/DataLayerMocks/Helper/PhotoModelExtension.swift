//
//  PhotoModelExtension.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/24.
//

import Foundation
@testable import Unsplash

extension PhotoModel {
    func toDefaultDTO() -> PhotoResponseDTO{
        return PhotoResponseDTO(id: self.id, width: self.width, height: self.height, urls: PhotoReponseURLsDTO(regular: self.imageURL), user: PhotoReponseUserDTO(name: self.userName))
    }
}
