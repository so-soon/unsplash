//
//  APIService.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import Foundation

enum NetworkError : Error {
    
}

protocol APIService {
    func requestPhotoList(request: PhotoListRequestDTO,completion: @escaping (Result<PhotoListResponseDTO,Error>) -> Void)
    func requestPhotoList(request: SearchPhotoListRequestDTO, completion: @escaping (Result<SearchPhotoListResponseDTO,Error>) -> Void)
}

class APIServiceImplementation: APIService {
    let baseURL = "https://api.unsplash.com"
    let clientID = "CpqfOYCldalTto6DyStDUk14-WBpChlfM1gxSzD-UlQ"
    let requestFactory = RequestFactoryImplementation()
    
    
    //MARK:- Default fetch photolist
    func requestPhotoList(request: PhotoListRequestDTO,completion: @escaping (Result<PhotoListResponseDTO,Error>) -> Void){
        
    }
    
    //MARK:- Search fetch photolist
    func requestPhotoList(request: SearchPhotoListRequestDTO, completion: @escaping (Result<SearchPhotoListResponseDTO,Error>) -> Void){
        
    }
}
