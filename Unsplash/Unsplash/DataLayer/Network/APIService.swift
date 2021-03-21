//
//  APIService.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import Foundation

protocol APIService {
    func requestPhotoList(completion: @escaping (Result<PhotoListResponseDTO,Error>) -> Void)
    func requestPhotoList(request: SearchPhotoListRequestDTO, completion: @escaping (Result<SearchPhotoListResponseDTO,Error>) -> Void)
}

class APIServiceImplementation: APIService {
    //MARK:- Default fetch photolist
    func requestPhotoList(completion: @escaping (Result<PhotoListResponseDTO,Error>) -> Void){
        
    }
    
    //MARK:- search fetch photolist
    func requestPhotoList(request: SearchPhotoListRequestDTO, completion: @escaping (Result<SearchPhotoListResponseDTO,Error>) -> Void){
        
    }
}
