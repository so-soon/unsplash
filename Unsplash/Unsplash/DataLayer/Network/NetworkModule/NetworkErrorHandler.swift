//
//  NetworkErrorHandler.swift
//  Unsplash
//
//  Created by Randy on 2021/03/24.
//

import UIKit

class NetworkErrorHandler {
    static let shared = NetworkErrorHandler()
    static let errorImageURL = "errorMessageImage"
    static let errorImageId = "error"
    static let errorImageUser = "error"
    static let errorImageWidth = 225
    static let errorImageHeight = 225
    
    func getErrorImage() -> Data{
        let image = UIImage(named: NetworkErrorHandler.errorImageURL)
        return image!.pngData()!
    }
}
