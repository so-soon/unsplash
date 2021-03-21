//
//  CacheService.swift
//  Unsplash
//
//  Created by Randy on 2021/03/21.
//

import Foundation

enum CacheError : Error {
    case kCacheNotFoundError
    case kKeyConversionError
}

protocol CacheService {
    func requestImage(request: ImageRequestDTO, completion: @escaping (Result<ImageResponseDTO,CacheError>) -> Void)
    func cachingImage(key: String, data : Data) -> Bool
}

class CacheServiceImplementation: CacheService{
    private let cacheStorage = NSCache<NSString, NSData>()
    
    func requestImage(request: ImageRequestDTO, completion: @escaping (Result<ImageResponseDTO,CacheError>) -> Void){
        DispatchQueue.global().async {
            [weak self] in
            if let key = request.url.data(using: .utf8)?.base64EncodedString(){
                guard let imageData = self?.cacheStorage.object(forKey: key as NSString) else{
                    completion(.failure(.kCacheNotFoundError))
                    return
                }
                completion(.success(ImageResponseDTO(data: imageData as Data)))
            }else{
                completion(.failure(.kKeyConversionError))
            }
        }
    }
    
    func cachingImage(key: String, data : Data) -> Bool{
        if let key = key.data(using: .utf8)?.base64EncodedString(){
            cacheStorage.setObject(data as NSData, forKey: key as NSString)
            return true
        }else{
            return false
        }
    }
}
