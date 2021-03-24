//
//  SearchPhotoListUseCaseMock.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import Foundation
@testable import Unsplash

class SearchPhotoListUseCaseMock : SearchPhotoListUseCase {
    var photoListDataMock : [PhotoModel]?
    var isSucessMode = true
    
    func setMockData(_ data: [PhotoModel]){
        self.photoListDataMock = data
    }
    
    func execute(searchWord: String, completion: @escaping (Result<[PhotoModel], Error>) -> Void) {
        if isSucessMode{
            completion(.success(photoListDataMock!))
        }else{
            completion(.failure(PhotoListRepositoryError.kInvalidPageRequestError as Error))
        }
        
    }
    
    func reset(){
        self.isSucessMode = true
        self.photoListDataMock = nil
    }
    
}
