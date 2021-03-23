//
//  FetchDefaultPhotoListUseCaseMock.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import Foundation
@testable import Unsplash

class FetchDefaultPhotoListUseCaseMock : FetchDefaultPhotoListUseCase{
    var photoListDataMock : [PhotoModel]?
    
    func setMockData(_ data: [PhotoModel]){
        self.photoListDataMock = data
    }
    func execute(completion: @escaping (Result<[PhotoModel], Error>) -> Void) {
        completion(.success(photoListDataMock!))
    }
    
    func reset(){
        self.photoListDataMock = nil
    }
}
