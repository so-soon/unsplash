//
//  APIService.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import Foundation

enum NetworkError : Error {
    case kProduceRequestError
    case kDataTaskResponseError
    case kStatusCodeError
    case kReponseDataError
}

protocol APIService {
    func requestPhotoList(request: PhotoListRequestDTO,completion: @escaping (Result<PhotoListResponseDTO,NetworkError>) -> Void)
    func requestPhotoList(request: SearchPhotoListRequestDTO, completion: @escaping (Result<SearchPhotoListResponseDTO,NetworkError>) -> Void)
    func requestImage(request: ImageRequestDTO, completion: @escaping (Result<ImageResponseDTO,NetworkError>)->Void)
}

class APIServiceImplementation: APIService {
    let baseURL = "https://api.unsplash.com"
    let clientID = "CpqfOYCldalTto6DyStDUk14-WBpChlfM1gxSzD-UlQ"
    let requestFactory = NetworkRequestFactoryImplementation()
    
    
    //MARK:- Default fetch photolist
    func requestPhotoList(request: PhotoListRequestDTO,completion: @escaping (Result<PhotoListResponseDTO,NetworkError>) -> Void){
        let targetURL = "/photos"
        var query : [String:String] = [:]
        
        query["page"] = String(request.page)
        
        guard let request = requestFactory.produceRequest(baseURL: baseURL,
                                                    targetURL: targetURL,
                                                    clientID: clientID,
                                                    method: .get,
                                                    query: query,
                                                    body: nil)
        else {
            completion(.failure(.kProduceRequestError))
            return
        }
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: request){[weak self] (data,response,error) in
                guard let _ = error else {
                    completion(.failure(.kDataTaskResponseError))
                    return
                }
                
                guard let _ = response as? HTTPURLResponse else {
                    completion(.failure(.kStatusCodeError))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.kReponseDataError))
                    return
                }
                
                guard let responseDTO : PhotoListResponseDTO = self?.decodeJSON(data: data) else {
                    completion(.failure(.kReponseDataError))
                    return
                }
                
                completion(.success(responseDTO))
            }
        }
        
        
    }
    
    //MARK:- Search fetch photolist
    func requestPhotoList(request: SearchPhotoListRequestDTO, completion: @escaping (Result<SearchPhotoListResponseDTO,NetworkError>) -> Void){
        // Todo :
    }
    
    //MARK:- fetch image
    func requestImage(request: ImageRequestDTO, completion: @escaping (Result<ImageResponseDTO,NetworkError>)->Void){
        
    }
    
    //MARK:- Private
    
    private func decodeJSON<T: Decodable>(data: Data) -> T? {
        do{
            let serialzedData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let jsonData = try JSONDecoder().decode(T.self, from: serialzedData)
            
            return jsonData
        }catch{
            return nil
        }
    }
}
