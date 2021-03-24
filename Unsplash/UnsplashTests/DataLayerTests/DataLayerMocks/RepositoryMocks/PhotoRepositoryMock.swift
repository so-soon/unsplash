//
//  PhotoRepositoryMock.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import Foundation
@testable import Unsplash

class PhotoRepositoryMock: PhotoRepository {
    var photoImageData : Data?
    var isSucessMode : Bool = true
    var isCacheMode : Bool = false
    
    func setMockData(photoImageData: Data){
        self.photoImageData = photoImageData
    }
    
    func fetching(imageURL: String, cached: @escaping (AnyObject) -> Void, completion: @escaping (Result<Data, Error>) -> Void) {
        if isCacheMode{
            cached(self.photoImageData as AnyObject)
        }else{
            if isSucessMode{
                completion(.success(self.photoImageData!))
            }else{
                completion(.failure(NSError()))
            }
        }
    }
    
    func reset(){
        self.photoImageData = nil
        self.isSucessMode = true
        self.isCacheMode = false
    }
    
}
