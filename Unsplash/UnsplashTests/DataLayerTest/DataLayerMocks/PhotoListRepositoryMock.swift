//
//  PhotoListRepositoryMock.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import Foundation
@testable import Unsplash

class PhotoListRepositoryMock: PhotoListRepository {
    var photoListData : [PhotoModel]?
    var searchPhotoListDataDict : [String:[PhotoModel]] = [:]
    var isSucessMode : Bool = true
    
    func setMockData(photoListData: [PhotoModel]){
        self.photoListData = photoListData
    }
    
    func setSearchMockData(searchWord: String, photoListData: [PhotoModel]){
        self.searchPhotoListDataDict[searchWord] = photoListData
    }
    
    func fetching(completion: @escaping (Result<[PhotoModel], Error>) -> Void) {
        if isSucessMode{
            completion(.success(self.photoListData!))
        }else{
            completion(.failure(PhotoListRepositoryError.kInvalidPageRequestError))
        }
        
    }
    
    func fetching(searchWord: String, completion: @escaping (Result<[PhotoModel], Error>) -> Void) {
        if isSucessMode{
            completion(.success(self.searchPhotoListDataDict[searchWord]!))
        }else{
            completion(.failure(PhotoListRepositoryError.kInvalidPageRequestError))
        }
    }
    
    func reset(){
        self.photoListData = nil
        self.isSucessMode = true
        self.searchPhotoListDataDict = [:]
    }
    
}
