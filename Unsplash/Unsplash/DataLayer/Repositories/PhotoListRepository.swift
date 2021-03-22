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
    func flush()
}

class PhotoListRepositoryImplementaiton: PhotoListRepository{
    let apiService : APIService
    var page = 0
    
    init(apiService : APIService) {
        self.apiService = apiService
    }
    
    //MARK:- Default fetch photolist
    func fetching(completion: @escaping (Result<[PhotoModel],Error>) -> Void){
        page += 1
        let requestDTO = PhotoListRequestDTO(page: page)
        
        apiService.requestPhotoList(request: requestDTO){result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.map{$0.toDomain()}))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK:- Search fetch photolist
    func fetching(searchWord: String, completion: @escaping (Result<[PhotoModel],Error>) -> Void){
        
    }
    
    func flush(){
        self.page = 0
    }
}
