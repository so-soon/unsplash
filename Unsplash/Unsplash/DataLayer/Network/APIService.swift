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
    case kJSONDecodeError
    case kURLConversionError
}

protocol APIService {
    func requestPhotoList(request: PhotoListRequestDTO,completion: @escaping (Result<PhotoListResponseDTO,NetworkError>) -> Void)
    func requestPhotoList(request: SearchPhotoListRequestDTO, completion: @escaping (Result<SearchPhotoListResponseDTO,NetworkError>) -> Void)
    func requestImage(request: ImageRequestDTO, completion: @escaping (Result<ImageResponseDTO,NetworkError>)->Void)
}

class APIServiceImplementation: APIService {
    static let shared = APIServiceImplementation()
    private let baseURL = "https://api.unsplash.com"
    private let clientID = "WXdEMqd63TR_vmbfodcLdFKjqGmJWxVXWupM_iv4NaM"
    private let requestFactory = NetworkRequestFactoryImplementation()
    
    
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
                if let _ = error {
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
                    completion(.failure(.kJSONDecodeError))
                    return
                }
                
                completion(.success(responseDTO))
            }.resume()
        }
        
        
    }
    
    //MARK:- Search fetch photolist
    func requestPhotoList(request: SearchPhotoListRequestDTO, completion: @escaping (Result<SearchPhotoListResponseDTO,NetworkError>) -> Void){
        // Todo :
    }
    
    //MARK:- fetch image
    func requestImage(request: ImageRequestDTO, completion: @escaping (Result<ImageResponseDTO,NetworkError>)->Void){
        guard let url = URL(string: request.url) else {
            completion(.failure(.kURLConversionError))
            return
        }
        
        URLSession.shared.dataTask(with: url){ (data,response,error) in
            if let _ = error {
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
            completion(.success(ImageResponseDTO(data: data)))
        }.resume()
    }
    
    //MARK:- Private
    
    private func decodeJSON<T: Decodable>(data: Data) -> T? {
        do{
            let jsonData = try JSONDecoder().decode(T.self, from: data)
            
            return jsonData
        }catch{
            return nil
        }
    }
}
