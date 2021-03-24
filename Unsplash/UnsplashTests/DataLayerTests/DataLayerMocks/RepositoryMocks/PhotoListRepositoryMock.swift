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
    var isSleepMode = false
    var isRepositoryErrorEmit = true
    
    func setMockData(photoListData: [PhotoModel]){
        self.photoListData = photoListData
    }
    
    func setMockData(searchWord: String, photoListData: [PhotoModel]){
        self.searchPhotoListDataDict[searchWord] = photoListData
    }
    
    func fetching(completion: @escaping (Result<[PhotoModel], Error>) -> Void) {
        if isSucessMode{
            if isSleepMode{
                Thread.sleep(forTimeInterval: 2)
            }
            completion(.success(self.photoListData!))
        }else{
            if isSleepMode{
                Thread.sleep(forTimeInterval: 2)
            }
            if isRepositoryErrorEmit{
                completion(.failure(PhotoListRepositoryError.kInvalidPageRequestError))
            }else{
                completion(.failure(NetworkError.kDataTaskResponseError))
            }
            
        }
        
    }
    
    func fetching(searchWord: String, completion: @escaping (Result<[PhotoModel], Error>) -> Void) {
        if isSucessMode{
            if isSleepMode{
                Thread.sleep(forTimeInterval: 2)
            }
            completion(.success(self.searchPhotoListDataDict[searchWord]!))
        }else{
            if isSleepMode{
                Thread.sleep(forTimeInterval: 2)
            }
            if isRepositoryErrorEmit{
                completion(.failure(PhotoListRepositoryError.kInvalidPageRequestError))
            }else{
                completion(.failure(NetworkError.kDataTaskResponseError))
            }
        }
    }
    
    func reset(){
        self.photoListData = nil
        self.isSucessMode = true
        self.isSleepMode = false
        self.isRepositoryErrorEmit = true
        self.searchPhotoListDataDict = [:]
    }
    
}
