//
//  PhotoDetailViewMock.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import Foundation
@testable import Unsplash

class PhotoDetailViewMock: PhotoDetailView {
    var resultReloadCollectionView : Bool = false
    
    func reloadCollectionView() {
        self.resultReloadCollectionView = true
    }
    
    func reset(){
        self.resultReloadCollectionView = false
    }
}
