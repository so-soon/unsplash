//
//  PhotoListPresenter.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import Foundation

//MARK:- Protocol
protocol PhotoListView: class {
    // Todo :
    func reloadTableView()
    func moveSrollFocus(at row: Int)
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
        fetchPhotoList()
    }
    
    func configure(cell : PhotoListTableViewCell, forRow row: Int){
        let url = photoListData[row].imageURL
        let userName = photoListData[row].userName
        
        if cell.url ?? "" == url {return}
        
        fetchPhotoImageUseCase.execute(imageURL: url,
                                       cached: {resultData in cell.setImage(resultData,userName,url)},
                                       completion: {result in
                                        switch result{
                                        case .success(let imgData):
                                            cell.setImage(imgData,userName,url)
                                        case .failure(let error):
                                        // Todo : Error handling
                                            print(error.localizedDescription)
                                        }
                                       })
    }
    
    func numberOfRowsInSection() -> Int {
        return photoListData.count
    }
    
    func photoRatioHeight(cellAt row :Int) -> Float {
        return Float(photoListData[row].height / photoListData[row].width)
    }
    
    func didSelect(cellAt row: Int) {
        // Todo :
    }
    
    func searchTextFieldEndEdit(with searchWord : String) {
        // Todo :
    }
    
    func fetchPhotoList(){
        fetchDefaultPhotoListUseCase.execute(){ [weak self] result in
            switch result {
            case .success(let photoList):
                self?.addPhotoList(photoList)
                self?.view?.reloadTableView()
            case .failure(let error):
                self?.errorHandler(error)
            }
        }
    }
    
    func flushPhotoList(){
        photoListData.removeAll()
    }
    
    //MARK:- Private
    
    private func addPhotoList(_ photoList : [PhotoModel]) {
        photoListData.append(contentsOf: photoList)
    }
    
    private func errorHandler(_ error : Error) {
        // Todo :
        print(error.localizedDescription)
    }
    
}

extension PhotoListPresenterImplementation: PhotoDetailPresenterDelegate {
    func fetchPhotoListFromDetailPresetner(atRow row : Int) {
        fetchPhotoList()
        self.view?.moveSrollFocus(at: row)
    }
}
