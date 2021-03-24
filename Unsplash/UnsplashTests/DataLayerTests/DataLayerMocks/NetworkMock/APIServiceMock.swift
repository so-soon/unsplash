//
//  APIServiceMock.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/24.
//

import Foundation
@testable import Unsplash

class APIServiceMock: APIService {
    var photoListResponseDTO: PhotoListResponseDTO?
    var searchPhotoListResponseDTO: [String:SearchPhotoListResponseDTO] = [:]
    var imageResponseDTO: ImageResponseDTO?
    
    var isSucessMode = true
    
    func setMockData(photoListResponseDTO: PhotoListResponseDTO){
        self.photoListResponseDTO = photoListResponseDTO
    }
    
    func setMockData(searchWord:String,searchPhotoListResponseDTO: SearchPhotoListResponseDTO){
        self.searchPhotoListResponseDTO[searchWord] = searchPhotoListResponseDTO
    }
    
    func setMockData(imgData: Data){
        self.imageResponseDTO = ImageResponseDTO(data: imgData)
    }
    
    func requestPhotoList(request: PhotoListRequestDTO, completion: @escaping (Result<PhotoListResponseDTO, NetworkError>) -> Void) {
        if isSucessMode{
            let returnedArray = Array(self.photoListResponseDTO![10*(request.page-1)..<10*(request.page-1)+10])
            completion(.success(returnedArray))
        }else{
            completion(.failure(.kDataTaskResponseError))
        }
        
    }
    
    func requestPhotoList(request: SearchPhotoListRequestDTO, completion: @escaping (Result<SearchPhotoListResponseDTO, NetworkError>) -> Void) {
        if isSucessMode{
            let response = self.searchPhotoListResponseDTO[request.searchWord]!
            let returnResponse = SearchPhotoListResponseDTO(total: response.total, total_pages: response.total_pages, results: Array(response.results[10*(request.page-1)..<10*(request.page-1)+10]))
            
            completion(.success(returnResponse))
            
        }else{
            completion(.failure(.kDataTaskResponseError))
        }
        
    }
    
    func requestImage(request: ImageRequestDTO, completion: @escaping (Result<ImageResponseDTO, NetworkError>) -> Void) {
        if isSucessMode{
            completion(.success(imageResponseDTO!))
        }else{
            completion(.failure(.kDataTaskResponseError))
        }
    }
    
    func reset(){
        self.photoListResponseDTO = nil
        self.searchPhotoListResponseDTO = [:]
        self.imageResponseDTO = nil
        self.isSucessMode = true
    }
    
}
