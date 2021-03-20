//
//  PhotoListPresenter.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import Foundation

//MARK:- Protocol
protocol PhotoListView {
    
}

protocol PhotoListPresenter {
    func viewDidLoad()
    func configure(cell : PhotoListTableViewCell, forRow row: Int)
}

//MARK:- Implementation
class PhotoListPresenterImplementation : PhotoListPresenter {
    
    func viewDidLoad(){
        
    }
    func configure(cell : PhotoListTableViewCell, forRow row: Int){
        
    }
}
