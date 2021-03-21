//
//  PhotoRepository.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import Foundation

protocol PhotoRepository {
    func fetching(imageURL: String,
                  cached: @escaping (AnyObject) -> Void,
                  completion: @escaping (Result<Data,Error>) -> Void)
}

class PhotoRepositoryImplementation: PhotoRepository {
    let apiService : APIService
    
    init(apiService : APIService) {
        self.apiService = apiService
    }
    
    func fetching(imageURL: String,
                  cached: @escaping (AnyObject) -> Void,
                  completion: @escaping (Result<Data,Error>) -> Void){
        let request = ImageRequestDTO(url: imageURL)
        
        DispatchQueue.global().async {[weak self] in
            CacheServiceImplementation.shared.requestImage(request: request){[weak self] result in
                switch result {
                case .success(let cacheData):
                    cached(cacheData)
                case .failure(_):
                    self?.apiService.requestImage(request: request){result in
                        switch result {
                        case .success(let responseDTO):
                            _ = CacheServiceImplementation.shared.cachingImage(key: request.url, data: responseDTO.data as AnyObject)
                            completion(.success(responseDTO.data))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            }
        }
        
        
    }
}
