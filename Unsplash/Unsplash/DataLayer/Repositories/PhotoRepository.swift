//
//  PhotoRepository.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import Foundation

protocol PhotoRepository {
    func fetching(imageURL: String,
                  cached: @escaping (Data) -> Void,
                  completion: @escaping (Result<Data,Error>) -> Void)
}

class PhotoRepositoryImplementation: PhotoRepository {
    func fetching(imageURL: String,
                  cached: @escaping (Data) -> Void,
                  completion: @escaping (Result<Data,Error>) -> Void){
        
    }
}
