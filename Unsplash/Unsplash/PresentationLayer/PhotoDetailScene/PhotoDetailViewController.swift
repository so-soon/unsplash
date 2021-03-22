//
//  PhotoDetailViewController.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    var configurator: PhotoDetailConfigurator!
    var presenter: PhotoDetailPresenter!
    var delegate : PhotoDetailPresenterDelegate?
    
    var cellFocusOffset : Int?
    
    private var collectionViewWidth : CGFloat = 0
    private var collectionViewHeight : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoCollectionView.dataSource = self
        self.photoCollectionView.delegate = self
        self.photoCollectionView.prefetchDataSource = self
        
        configurator.configure(photoDetailViewController: self)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        self.setCellFocusOffset()
    }
    //MARK:- Interface Builder Links
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    //MARK:- Private
    
    private func setCellFocusOffset() {
        if let cellFocusOffset = self.cellFocusOffset {
            let position = CGFloat(cellFocusOffset) * UIScreen.main.bounds.width
            self.photoCollectionView.setContentOffset(CGPoint(x: position, y: 0), animated: false)
        }
    }

}

extension PhotoDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoDetailCollectionViewCell.id, for: indexPath) as! PhotoDetailCollectionViewCell
        
        presenter.configure(cell: cell, rowRow: indexPath.row)
        
        return cell
    }
}

extension PhotoDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.changePhotoFocus(to: indexPath.row)
    }
}

extension PhotoDetailViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let photoDataCount = presenter.numberOfRowsInSection()
        
        if photoDataCount == 0 {
            return
        }else{
            for indexPath in indexPaths{
                if photoDataCount == (indexPath.row + 3) {
                    presenter.cellReachEndIndex(at: indexPath.row)
                }
            }
        }
    }
}

extension PhotoDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let height = collectionView.frame.size.height
        
        self.collectionViewWidth = width
        self.collectionViewHeight = height

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension PhotoDetailViewController : PhotoDetailView {
    func reloadCollectionView(){
        DispatchQueue.main.async { [weak self] in
            self?.photoCollectionView.reloadData()
        }
    }
}
