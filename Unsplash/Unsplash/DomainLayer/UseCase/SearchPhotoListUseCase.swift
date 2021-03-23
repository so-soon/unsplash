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
    
    init(repository: PhotoListRepository) {
        self.repository = repository
    }
    
    func execute(searchWord: String,completion: @escaping (Result<[PhotoModel],Error>) -> Void){
        repository.fetching(searchWord: searchWord,
                            completion: {result in
                                switch result {
                                case .success(let photoList):
                                    completion(.success(photoList))
                                case .failure(let error):
                                    completion(.failure(error))
                                }
                            })
    }
}
