//
//  PhotoDetailPresenter.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import Foundation
protocol PhotoDetailView: class {
    func reloadCollectionView()
}

protocol PhotoDetailCollectionViewCell {
    var url : String? {get set}
    func setImage(_ imgData: Data,_ userName: String, _ url : String)
    func setImage(_ imgData: AnyObject,_ userName: String, _ url : String)
}

protocol PhotoDetailPresenter {
    func viewDidLoad()
    func configure(cell: PhotoDetailCollectionViewCell, forRow row: Int)
    
    func numberOfRowsInSection() -> Int
    func cellReachEndIndex(at row: Int)
    func changePhotoFocus(to row: Int)
    func viewWillAppear()
    func viewWillDisappear()
}

protocol PhotoDetailPresenterDelegate: class {
    func fetchPhotoListFromDetailPresetner() -> [PhotoModel]
    func movePhotoFocus(to row: Int)
    func viewWillAppear()
    func viewWillDisappear()
}

class PhotoDetailPresenterImplementation: PhotoDetailPresenter{
    private weak var view : PhotoDetailView?
    private var fetchPhotoImageUseCase : FetchPhotoImageUseCase
    
    let router : PhotoDetailRouter
    private var delegate : PhotoDetailPresenterDelegate?
    var photoListData : [PhotoModel] = []
    
    init(view: PhotoDetailView,
         fetchPhotoImageUseCase : FetchPhotoImageUseCase,
         router: PhotoDetailRouter,
         delegate: PhotoDetailPresenterDelegate,
         photoListData: [PhotoModel]) {
        self.view = view
        self.fetchPhotoImageUseCase = fetchPhotoImageUseCase
        self.router = router
        self.delegate = delegate
        self.photoListData = photoListData
        
    }
    
    func viewDidLoad(){
        
    }
    
    func configure(cell: PhotoDetailCollectionViewCell, forRow row: Int){
        if row >= photoListData.count {return}
        
        let url = photoListData[row].imageURL
        let userName = photoListData[row].userName
        
        if cell.url ?? "" == url {return}
        
        fetchPhotoImageUseCase.execute(imageURL: url,
                                       cached: {rawImgData in cell.setImage(rawImgData, userName, url)},
                                       completion: {result in
                                        switch result {
                                        case .success(let imgData):
                                            cell.setImage(imgData, userName, url)
                                        case .failure(let error):
                                            print(error.localizedDescription)
                                            cell.setImage(NetworkErrorHandler.shared.getErrorImage(), NetworkErrorHandler.errorImageUser, NetworkErrorHandler.errorImageURL)
                                        }
                                       })
        
    }
    
    func numberOfRowsInSection() -> Int{
        return self.photoListData.count
    }
    
    func cellReachEndIndex(at row: Int){
        if self.delegate != nil {
            self.photoListData = self.delegate!.fetchPhotoListFromDetailPresetner()
            self.view?.reloadCollectionView()
        }
        
    }
    
    func changePhotoFocus(to row: Int){
        self.delegate?.movePhotoFocus(to: row)
    }
    
    func viewWillAppear(){
        self.delegate?.viewWillAppear()
    }
    func viewWillDisappear(){
        self.delegate?.viewWillDisappear()
    }
    
}
