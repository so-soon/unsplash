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
    func detailViewWillAppear()
    func detailViewWilldisappear()
}

protocol PhotoListTableViewCell {
    var url : String? {get set}
    
    func setImage(_ imgData: Data,_ userName: String, _ url : String)
    func setImage(_ imgData: AnyObject,_ userName: String, _ url : String)
}

protocol PhotoListPresenter {
    var router : PhotoListRouter { get }
    func viewDidLoad()
    func configure(cell : PhotoListTableViewCell, forRow row: Int)
    
    func numberOfRowsInSection() -> Int
    func photoRatioHeight(cellAt row :Int) -> Float
    
    func didSelect(cellAt row: Int)
    func searchTextFieldEndEdit(with searchWord : String?)
    
    func updatePhotoList()
}

//MARK:- Implementation
class PhotoListPresenterImplementation : PhotoListPresenter {
    fileprivate weak var view : PhotoListView?
    fileprivate let fetchDefaultPhotoListUseCase : FetchDefaultPhotoListUseCase
    fileprivate let fetchPhotoImageUseCase : FetchPhotoImageUseCase
    fileprivate let searchPhotoListUseCase : SearchPhotoListUseCase
    private var prevSearchWord : String?
    var router : PhotoListRouter
    
    
    var photoListData : [PhotoModel] = []

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
        fetchPhotoList(searchWord: nil)
    }
    
    func configure(cell : PhotoListTableViewCell, forRow row: Int){
        if row >= photoListData.count {return}
        
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
        if row >= photoListData.count {return 0}
        return Float(photoListData[row].height) / Float(photoListData[row].width)
    }
    
    func didSelect(cellAt row: Int) {
        router.presentDetailsView(delegate: self,
                                  photoListData: self.photoListData,
                                  at: row)
    }
    
    func searchTextFieldEndEdit(with searchWord : String?) {
        if self.prevSearchWord == searchWord || searchWord == nil {return}
        self.prevSearchWord = searchWord
        
        flushPhotoList()
        fetchPhotoList(searchWord: searchWord)
        self.view?.moveSrollFocus(at: 0)
    }
    
    func updatePhotoList(){
        fetchPhotoList(searchWord: self.prevSearchWord)
    }
    
    
    //MARK:- Private
    private func fetchPhotoList(searchWord: String?){
        if searchWord == nil || searchWord == ""{
            fetchDefaultPhotoListUseCase.execute(){ [weak self] result in
                switch result {
                case .success(let photoList):
                    self?.addPhotoList(photoList)
                    self?.view?.reloadTableView()
                case .failure(let error):
                    self?.errorHandler(error)
                }
            }
        }else{
            searchPhotoListUseCase.execute(searchWord: searchWord.orEmpty()){ [weak self] result in
                switch result {
                case .success(let photoList):
                    self?.addPhotoList(photoList)
                    self?.view?.reloadTableView()
                case .failure(let error):
                    self?.errorHandler(error)
                }
            }
        }
    }
    
    private func flushPhotoList(){
        photoListData.removeAll()
    }
    
    private func addPhotoList(_ photoList : [PhotoModel]) {
        photoListData.append(contentsOf: photoList)
    }
    
    private func errorHandler(_ error : Error) {
        // Todo :
        print(error.localizedDescription)
    }
    
}

extension PhotoListPresenterImplementation: PhotoDetailPresenterDelegate {
    func fetchPhotoListFromDetailPresetner()  -> [PhotoModel] {
        fetchPhotoList(searchWord: self.prevSearchWord)
        return self.photoListData
    }
    
    func movePhotoFocus(to row: Int) {
        self.view?.moveSrollFocus(at: row)
    }
    
    func viewWillAppear(){
        self.view?.detailViewWillAppear()
    }
    
    func viewWillDisappear(){
        self.view?.detailViewWilldisappear()
    }
}
