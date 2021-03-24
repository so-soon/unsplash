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
    
    func setMockData(_ data: Data){
        self.photoImageDataMock = data
    }
    
    func execute(imageURL: String, cached: @escaping (AnyObject) -> Void, completion: @escaping (Result<Data, Error>) -> Void) {
        completion(.success(photoImageDataMock!))
    }
    
    func reset(){
        self.photoImageDataMock = nil
    }
    
}
