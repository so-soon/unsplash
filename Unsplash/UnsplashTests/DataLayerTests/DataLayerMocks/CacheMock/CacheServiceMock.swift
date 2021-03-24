//
//  CacheServiceMock.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/24.
//

import Foundation
@testable import Unsplash

class CacheServiceMock: CacheService {
    var cacheStorageMock : [String:AnyObject] = [:]
    var isSucessMode : Bool = true
    
    func setMockData(url:String, data: Data){
        cacheStorageMock[url] = data as AnyObject
    }
    
    func requestImage(request: ImageRequestDTO, completion: @escaping (Result<AnyObject, CacheError>) -> Void) {
        if isSucessMode{
            if cacheStorageMock[request.url] == nil {
                completion(.failure(.kCacheNotFoundError))
            }else{
                completion(.success(cacheStorageMock[request.url]!))
            }
        }else{
            completion(.failure(.kCacheNotFoundError))
        }
        
    }
    
    func cachingImage(url: String, data: AnyObject){
        cacheStorageMock[url] = data
    }
    
    func reset(){
        cacheStorageMock = [:]
        isSucessMode = true
    }
}
