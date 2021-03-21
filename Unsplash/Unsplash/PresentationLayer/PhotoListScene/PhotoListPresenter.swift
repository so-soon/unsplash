//
//  PhotoListPresenter.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import Foundation

//MARK:- Protocol
protocol PhotoListView: class {
}

protocol PhotoListPresenter {
    func viewDidLoad()
    func configure(cell : PhotoListTableViewCell, forRow row: Int)
    
    func numberOfRowsInSection() -> Int
    func photoRatioHeight(cellAt row :Int) -> Float
    
    func didSelect(cellAt row: Int)
    func searchTextFieldEndEdit(with searchWord : String)
    
    func fetchPhotoList()
    func flushPhotoList()
}

//MARK:- Implementation
class PhotoListPresenterImplementation : PhotoListPresenter {
    fileprivate weak var view : PhotoListView?
    fileprivate let fetchDefaultPhotoListUseCase : FetchDefaultPhotoListUseCase
    fileprivate let fetchPhotoImageUseCase : FetchPhotoImageUseCase
    fileprivate let searchPhotoListUseCase : SearchPhotoListUseCase
    let router : PhotoListRouter
    
    fileprivate var photoListData : [PhotoModel] = []
    
    init(view: PhotoListView,
         fetchDefaultPhotoListUseCase : FetchDefaultPhotoListUseCase,
         fetchPhotoImageUseCase : FetchPhotoImageUseCase,
         searchPhotoListUseCase : SearchPhotoListUseCase,
         router : PhotoListRouter) {
        self.view = view
        self.fetchDefaultPhotoListUseCase = fetchDefaultPhotoListUseCase
        self.fetchPhotoImageUseCase = fetchPhotoImageUseCase
        self.searchPhotoListUseCase = searchPhotoListUseCase
        self.router = router
    }
    
    func viewDidLoad(){
        
    }
    
    func configure(cell : PhotoListTableViewCell, forRow row: Int){
        
    }
    
    func numberOfRowsInSection() -> Int {
        return 1
    }
    
    func photoRatioHeight(cellAt row :Int) -> Float {
        return Float(photoListData[row].height / photoListData[row].width)
    }
    
    func didSelect(cellAt row: Int) {
        
    }
    
    func searchTextFieldEndEdit(with searchWord : String) {
        
    }
    
    func fetchPhotoList(){
        
    }
    
    func flushPhotoList(){
        
    }
}
