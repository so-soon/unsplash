//
//  PhotoDetailPresenter.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import Foundation

protocol PhotoDetailPresenter {
    func viewDidLoad()
    func configure(cell: PhotoDetailCollectionViewCell, rowRow row: Int)
    
    func numberOfRowsInSection() -> Int
}

protocol PhotoDetailPresenterDelegate {
    func fetchPhotoListFromDetailPresetner(atRow row : Int)
}

class PhotoDetailPresenterImplementation: PhotoDetailPresenter{
    var delegate : PhotoDetailPresenterDelegate?
    
    func viewDidLoad(){
        
    }
    
    func configure(cell: PhotoDetailCollectionViewCell, rowRow row: Int){
        
    }
    
    func numberOfRowsInSection() -> Int{
        return 1
    }
    
}
