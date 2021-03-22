//
//  PhotoListRouter.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import UIKit

protocol PhotoListRouter {
    func presentDetailsView(delegate : PhotoDetailPresenterDelegate,photoListData : [PhotoModel],at row: Int)
    func perpare(for segue: UIStoryboardSegue, sender: Any?)
}

class PhotoListRouterImplementation: PhotoListRouter {
    static let showDetailViewSegueId = "ShowPhotoDetailSegue"
    fileprivate var photoListData : [PhotoModel]!
    
    fileprivate weak var photoListViewController : PhotoListViewController?
    fileprivate weak var delegate : PhotoDetailPresenterDelegate?
    
    init(photoListViewController: PhotoListViewController) {
        self.photoListViewController = photoListViewController
    }
    
    func presentDetailsView(delegate : PhotoDetailPresenterDelegate,
                            photoListData : [PhotoModel],
                            at row: Int) {
        self.delegate = delegate
        self.photoListData = photoListData
        self.photoListViewController?.performSegue(withIdentifier: PhotoListRouterImplementation.showDetailViewSegueId,
                                                   sender: row)
    }
    
    func perpare(for segue: UIStoryboardSegue, sender: Any?){
        if let photoDetailViewController = segue.destination as? PhotoDetailViewController {
            photoDetailViewController.cellFocusOffset = (sender as? Int) ?? 0
            photoDetailViewController.configurator = PhotoDetailConfiguratorImplementation(photoListData: self.photoListData,
                                                                                           delegate: self.delegate!)
        }
    }
}
