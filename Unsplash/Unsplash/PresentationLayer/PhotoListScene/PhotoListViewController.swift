//
//  ViewController.swift
//  Unsplash
//
//  Created by so-soon on 2021/03/20.
//

import UIKit

class PhotoListViewController: UIViewController,PhotoListView {
    var configurator = PhotoListConfiguratorImplementation()
    var presenter: PhotoListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(photoListViewController: self)
        presenter.viewDidLoad()
    }

    //MARK:- Interface Builder Links
    
    @IBAction func unWindToPhotoListView(_ unwindSegue : UIStoryboardSegue) {
        
    }
}

