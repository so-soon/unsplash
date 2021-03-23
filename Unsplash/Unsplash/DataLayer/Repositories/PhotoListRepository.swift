//
//  PhotoListRepository.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import Foundation

enum PhotoListRepositoryError : Error {
    case kInvalidPageRequestError
}

protocol PhotoListRepository {
    func fetching(completion: @escaping (Result<[PhotoModel],Error>) -> Void)
    func fetching(searchWord: String, completion: @escaping (Result<[PhotoModel],Error>) -> Void)
}

class PhotoListRepositoryImplementaiton: PhotoListRepository{
    let apiService : APIService
    private var page = 0
    private var totalPages : Int?
    private var prevSearchWord : String?
    
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
        page += 1
        
        if isNewSearchWord(searchWord: searchWord){
            flushPhotoListRepository()
            self.prevSearchWord = searchWord
        }
        
        if !isReuqestPageValid(){
            completion(.failure(PhotoListRepositoryError.kInvalidPageRequestError))
            return
        }
        
        let requestDTO = SearchPhotoListRequestDTO(searchWord: searchWord,
                                                   page: self.page)
        
        apiService.requestPhotoList(request: requestDTO){[weak self] result in
            switch result {
            case .success(let responseDTO):
                self?.totalPages = responseDTO.total_pages
                completion(.success(responseDTO.results.map{$0.toDomain()}))
            case .failure(let error):
                self?.flushPhotoListRepository()
                completion(.failure(error))
            }
        }
    }
    
    
    
    //MARK:- Private
    private func flushPhotoListRepository(){
        self.page = 1
        self.totalPages = nil
    }
    
    private func isNewSearchWord(searchWord: String) -> Bool{
        if let prevSearchWord = self.prevSearchWord {
            return prevSearchWord != searchWord
        }else{
            return true
        }
    }
    
    private func isReuqestPageValid() -> Bool {
        if let totalPages = self.totalPages {
            return self.page <= totalPages
        }else{
            return true
        }
        
    }
}
