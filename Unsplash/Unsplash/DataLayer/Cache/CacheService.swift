//
//  CacheService.swift
//  Unsplash
//
//  Created by Randy on 2021/03/21.
//

import UIKit

enum CacheError : Error {
    case kCacheNotFoundError
}

protocol CacheService {
    func requestImage(request: ImageRequestDTO, completion: @escaping (Result<AnyObject,CacheError>) -> Void)
    func cachingImage(url: String, data : AnyObject)
}

class CacheServiceImplementation: CacheService{
    static let shared : CacheServiceImplementation = CacheServiceImplementation()
    
    private let cacheStorage = NSCache<NSString, AnyObject>()
    
    func requestImage(request: ImageRequestDTO, completion: @escaping (Result<AnyObject,CacheError>) -> Void){
        let key = request.url.data(using: .utf8)!.base64EncodedString()
        guard let imageData = self.cacheStorage.object(forKey: key as NSString) else{
            completion(.failure(.kCacheNotFoundError))
            return
        }
        completion(.success(imageData))
        
        
    }
    
    func cachingImage(url: String, data : AnyObject){
        let dataFromAnyObject = data as! Data
        let uiImageData = UIImage(data: dataFromAnyObject)
        let key = url.data(using: .utf8)!.base64EncodedString()
            cacheStorage.setObject(uiImageData as AnyObject, forKey: key as NSString)
    }
}
