//
//  PhotoListRepository.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import Foundation

protocol PhotoListRepository {
    func fetching(completion: @escaping (Result<[PhotoModel],Error>) -> Void)
    func fetching(searchWord: String, completion: @escaping (Result<[PhotoModel],Error>) -> Void)
}

class PhotoListRepositoryImplementaiton: PhotoListRepository{
    func fetching(completion: @escaping (Result<[PhotoModel],Error>) -> Void){
        
    }
    
    func fetching(searchWord: String, completion: @escaping (Result<[PhotoModel],Error>) -> Void){
        
    }
}
