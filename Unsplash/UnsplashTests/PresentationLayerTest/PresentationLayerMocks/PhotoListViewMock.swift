//
//  PhotoListViewMock.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import Foundation
@testable import Unsplash

class PhotoListViewMock : PhotoListView {
    var resultReloadTableView : Bool = false
    var resultMoveSrollFocus : Int = -1
    var resultDetailViewWillAppear : Bool = false
    var resultDetailViewWilldisappear : Bool = false
    
    func reloadTableView() {
        self.resultReloadTableView = true
    }
    
    func moveSrollFocus(at row: Int) {
        self.resultMoveSrollFocus = row
    }
    
    func detailViewWillAppear() {
        self.resultDetailViewWillAppear = true
    }
    
    func detailViewWilldisappear() {
        self.resultDetailViewWilldisappear = true
    }
    
    func reset(){
        self.resultReloadTableView = false
        self.resultMoveSrollFocus = -1
        self.resultDetailViewWillAppear = false
        self.resultDetailViewWilldisappear = false
    }
    
    
}
