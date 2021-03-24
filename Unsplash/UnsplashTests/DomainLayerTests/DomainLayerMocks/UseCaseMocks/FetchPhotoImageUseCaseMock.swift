//
//  FetchPhotoImageUseCaseMock.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import Foundation
@testable import Unsplash
class FetchPhotoImageUseCaseMock : FetchPhotoImageUseCase{
    var photoImageDataMock : Data?
    var isSucessMode = true
    var isCacheMode = false
    
    func setMockData(_ data: Data){
        self.photoImageDataMock = data
    }
    
    func execute(imageURL: String, cached: @escaping (AnyObject) -> Void, completion: @escaping (Result<Data, Error>) -> Void) {
        if isCacheMode{
            cached(self.photoImageDataMock as AnyObject)
        }else{
            if isSucessMode{
                completion(.success(photoImageDataMock!))
            }else{
                completion(.failure(PhotoListRepositoryError.kInvalidPageRequestError as Error))
            }
        }
        
        
    }
    
    func reset(){
        self.isSucessMode = true
        self.isCacheMode = false
        self.photoImageDataMock = nil
    }
    
}
