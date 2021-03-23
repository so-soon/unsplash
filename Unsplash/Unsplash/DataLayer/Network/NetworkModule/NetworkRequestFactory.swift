//
//  RequestFactory.swift
//  Unsplash
//
//  Created by Randy on 2021/03/21.
//

import Foundation

enum HTTPMethod : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol NetworkRequestFactory {
    func producePhotoListRequest(baseURL: String, targetURL: String, clientID: String, method: HTTPMethod, query:[String:String]?, body: Data?) -> URLRequest?
    
}

class NetworkRequestFactoryImplementation: NetworkRequestFactory{
    func producePhotoListRequest(baseURL: String, targetURL: String, clientID: String, method: HTTPMethod, query:[String:String]?, body: Data?) -> URLRequest? {
        
        //MARK:- Produce URLComponent
        var component = URLComponents(string: baseURL)
        
        component?.path = targetURL
        
        component?.queryItems = []
        query?.forEach({(key,value) in
            component?.queryItems?.append(URLQueryItem(name: key, value: value))
        })
        
        //MARK:- Produce URLRequest
        var header : [String:String] = [:]
        
        guard let url = component?.url else {return nil}
        var request = URLRequest(url: url)
        
        
        
        header["Authorization"] = "Client-ID \(clientID)"
        
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        header.forEach({(key,value) in
            request.setValue(value, forHTTPHeaderField: key)
        })
        
        request.httpBody = body
        
        return request
    }
}
