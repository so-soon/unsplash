//
//  CacheService.swift
//  Unsplash
//
//  Created by Randy on 2021/03/21.
//

import Foundation

enum CacheErrorType : Error {
    case kCacheNotFound
    case kKeyConversionException
}

protocol CacheService {
    func requestImage(request: ImageRequestDTO, completion: @escaping (Result<ImageResponseDTO,Error>) -> Void)
}

class CacheServiceImplementation {
    private let cacheStorage = NSCache<NSString, NSData>()
    
    func requestImage(request: ImageRequestDTO, completion: @escaping (Result<ImageResponseDTO,Error>) -> Void){
        DispatchQueue.global().async {
            [weak self] in
            if let key = request.url.data(using: .utf8)?.base64EncodedString(){
                guard let imageData = self?.cacheStorage.object(forKey: key as NSString) else{
                    completion(.failure(CacheErrorType.kCacheNotFound))
                    return
                }
                completion(.success(ImageResponseDTO(data: imageData as Data)))
            }else{
                completion(.failure(CacheErrorType.kKeyConversionException))
            }
        }
    }
}
