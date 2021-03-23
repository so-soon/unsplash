//
//  PhotoDetailPresenterDelegateMock.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import Foundation
@testable import Unsplash

class PhotoDetailPresenterDelegateMock: PhotoDetailPresenterDelegate {
    var searchResultPhotoListData : [PhotoModel]?
    var photoFocusRow : Int?
    var resultViewWillAppear: Bool = false
    var resultViewWillDisappear: Bool = false
    
    func setMockData(photoListData: [PhotoModel]){
        self.searchResultPhotoListData = photoListData
    }
    
    func fetchPhotoListFromDetailPresetner() -> [PhotoModel] {
        return self.searchResultPhotoListData!
    }
    
    func movePhotoFocus(to row: Int) {
        self.photoFocusRow = row
    }
    
    func viewWillAppear() {
        self.resultViewWillAppear = true
    }
    
    func viewWillDisappear() {
        self.resultViewWillDisappear = true
    }
    
    func reset(){
        self.searchResultPhotoListData = nil
        self.photoFocusRow = nil
        self.resultViewWillAppear = false
        self.resultViewWillDisappear = false        
    }
    
}
