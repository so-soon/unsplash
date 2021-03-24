//
//  SearchPhotoListUseCase.swift
//  Unsplash
//
//  Created by Randy on 2021/03/21.
//

import Foundation

protocol SearchPhotoListUseCase {
    func execute(searchWord: String,completion: @escaping (Result<[PhotoModel],Error>) -> Void)
}

class SearchPhotoListUseCaseImplementation: SearchPhotoListUseCase {
    private let repository: PhotoListRepository
    private var useCaseLock : Bool = false
    
    init(repository: PhotoListRepository) {
        self.repository = repository
    }
    
    func execute(searchWord: String,completion: @escaping (Result<[PhotoModel],Error>) -> Void){
        if useCaseLock {return}
        
        useCaseLock = true
        repository.fetching(searchWord: searchWord,
                            completion: {[weak self] result in
                                switch result {
                                case .success(let photoList):
                                    completion(.success(photoList))
                                case .failure(let error):
                                    if error is PhotoListRepositoryError{
                                        if (error as! PhotoListRepositoryError) == .kInvalidPageRequestError {
                                            completion(.success([]))
                                        }
                                    }else{
                                        completion(.failure(error))
                                    }
                                }
                                self?.useCaseLock = false
                            })
    }
}
