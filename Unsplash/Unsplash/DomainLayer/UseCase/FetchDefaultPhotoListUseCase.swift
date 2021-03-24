//
//  FetchDefaultPhotoListUsecase.swift
//  Unsplash
//
//  Created by Randy on 2021/03/21.
//

import Foundation

protocol FetchDefaultPhotoListUseCase {
    func execute(completion: @escaping (Result<[PhotoModel],Error>) -> Void)
}

class FetchDefaultPhotoListUseCaseImplementation: FetchDefaultPhotoListUseCase {
    private let repository : PhotoListRepository
    private var useCaseLock : Bool = false
    
    init(repository: PhotoListRepository) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<[PhotoModel],Error>) -> Void){
        if useCaseLock {return}
        
        useCaseLock = true
        
        repository.fetching(){[weak self] result in
            switch result{
            case .success(let photoList):
                completion(.success(photoList))
            case .failure(let error):
                completion(.failure(error))
            }
            self?.useCaseLock = false
        }
    }
}
