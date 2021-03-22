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

protocol PhotoDetailPresenter {
    func viewDidLoad()
    func configure(cell: PhotoDetailCollectionViewCell, rowRow row: Int)
    
    func numberOfRowsInSection() -> Int
    func cellReachEndIndex(at row: Int)
    func changePhotoFocus(to row: Int)
}

protocol PhotoDetailPresenterDelegate: class {
    func fetchPhotoListFromDetailPresetner(at row : Int) -> [PhotoModel]
    func movePhotoFocus(to row: Int)
}

class PhotoDetailPresenterImplementation: PhotoDetailPresenter{
    private weak var view : PhotoDetailView?
    private var fetchPhotoImageUseCase : FetchPhotoImageUseCase
    
    let router : PhotoDetailRouter
    private var delegate : PhotoDetailPresenterDelegate?
    private var photoListData : [PhotoModel] = []
    
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
    
    func configure(cell: PhotoDetailCollectionViewCell, rowRow row: Int){
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
                                        }
                                       })
        
    }
    
    func numberOfRowsInSection() -> Int{
        return self.photoListData.count
    }
    
    func cellReachEndIndex(at row: Int){
        self.photoListData = self.delegate?.fetchPhotoListFromDetailPresetner(at: row) ?? []
        self.view?.reloadCollectionView()
    }
    
    func changePhotoFocus(to row: Int){
        self.delegate?.movePhotoFocus(to: row)
    }
    
}
