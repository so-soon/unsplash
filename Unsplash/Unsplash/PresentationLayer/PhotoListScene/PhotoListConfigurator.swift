//
//  PhotoListConfigurator.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import Foundation

protocol PhotoListConfigurator {
    func configure(photoListViewController: PhotoListViewController)
}

class PhotoListConfiguratorImplementation: PhotoListConfigurator{
    func configure(photoListViewController: PhotoListViewController) {
        // Todo : add configure Domain,DataLayer
        
        // Todo : impl usecase's initializer
        let photoListRepository = PhotoListRepositoryImplementaiton()
        let photoRepository = PhotoRepositoryImplementation()
        
        let fetchPhotoListUseCase = FetchDefaultPhotoListUseCaseImplementation(repository: photoListRepository)
        let fetchPhotoImageUsecase = FetchPhotoImageUseCaseImplementation(repository: photoRepository)
        let searchPhotoListUseCase = SearchPhotoListUseCaseImplementation()
        
        let router = PhotoListRouterImplementation()
        
        let presenter = PhotoListPresenterImplementation(
            view: photoListViewController,
            fetchDefaultPhotoListUseCase: fetchPhotoListUseCase,
            fetchPhotoImageUseCase: fetchPhotoImageUsecase,
            searchPhotoListUseCase: searchPhotoListUseCase,
            router: router)
        
        photoListViewController.presenter = presenter
    }
}
