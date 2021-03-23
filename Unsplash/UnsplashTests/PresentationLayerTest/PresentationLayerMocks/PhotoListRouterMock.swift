//
//  PhotoListRouterMock.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import UIKit
@testable import Unsplash

class PhotoListRouterMock :PhotoListRouter{
    var delegate : PhotoDetailPresenterDelegate?
    var photoListData : [PhotoModel]?
    
    func presentDetailsView(delegate: PhotoDetailPresenterDelegate, photoListData: [PhotoModel], at row: Int) {
        self.delegate = delegate
        self.photoListData = photoListData
    }
    
    func perpare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func reset(){
        self.delegate = nil
        self.photoListData = nil
    }
    
    
}
