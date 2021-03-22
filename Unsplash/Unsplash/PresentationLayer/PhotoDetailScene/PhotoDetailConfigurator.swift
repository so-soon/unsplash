//
//  PhotoDetailConfigurator.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import Foundation

protocol PhotoDetailConfigurator {
    func configure(photoDetailViewController: PhotoDetailViewController)
}

class PhotoDetailConfiguratorImplementation: PhotoDetailConfigurator {
    fileprivate var photoListData : [PhotoModel]
    fileprivate weak var delegate : PhotoDetailPresenterDelegate?
    
    init(photoListData : [PhotoModel],
         delegate: PhotoDetailPresenterDelegate) {
        self.photoListData = photoListData
        self.delegate = delegate
    }
    
    func configure(photoDetailViewController: PhotoDetailViewController){
        let apiService = APIServiceImplementation.shared
        let cacheService = CacheServiceImplementation.shared
        
        let photoRepository = PhotoRepositoryImplementation(apiService: apiService, cacheService: cacheService)
        
        let fetchPhotoImageUseCase = FetchPhotoImageUseCaseImplementation(repository: photoRepository)
        
        let router = PhotoDetailRouterImplementation()
        
        let presenter = PhotoDetailPresenterImplementation(
            view: photoDetailViewController,
            fetchPhotoImageUseCase: fetchPhotoImageUseCase,
            router: router,
            delegate: self.delegate!,
            photoListData: self.photoListData)
        
        photoDetailViewController.presenter = presenter
    }
}
