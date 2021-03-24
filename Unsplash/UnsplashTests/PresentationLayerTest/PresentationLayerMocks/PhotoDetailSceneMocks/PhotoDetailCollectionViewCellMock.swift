//
//  PhotoDetailCollectionViewCellMock.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import Foundation
@testable import Unsplash

class PhotoDetailCollectionViewCellMock: PhotoDetailCollectionViewCell {
    var url: String?
    var image: Data?
    var userName: String?
    
    func setImage(_ imgData: Data, _ userName: String, _ url: String) {
        self.url = url
        self.image = imgData
        self.userName = userName
    }
    
    func setImage(_ imgData: AnyObject, _ userName: String, _ url: String) {
        self.url = url
        self.image = imgData as? Data
        self.userName = userName
    }
    
    func reset(){
        self.url = nil
        self.userName = nil
        self.image = nil
    }
    
    
}
