//
//  FetchPhotoImageUseCase.swift
//  Unsplash
//
//  Created by Randy on 2021/03/21.
//

import Foundation

protocol FetchPhotoImageUseCase {
    func execute(imageURL: String,
                 cached: @escaping (AnyObject) -> Void,
                 completion: @escaping (Result<Data,Error>) -> Void)
}

class FetchPhotoImageUseCaseImplementation: FetchPhotoImageUseCase {
    private let repository : PhotoRepository
    
    init(repository: PhotoRepository) {
        self.repository = repository
    }
    
    func execute(imageURL: String,
                 cached: @escaping (AnyObject) -> Void,
                 completion: @escaping (Result<Data,Error>) -> Void) {
        repository.fetching(imageURL: imageURL,
                            cached: cached){ result in
            switch result{
            case .success(let photo):
                completion(.success(photo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
