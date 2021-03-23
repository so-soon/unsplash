//
//  PhotoDetailCollectionViewCell.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import UIKit

class PhotoDetailCollectionViewCellImplementation: UICollectionViewCell {
    static let id = "PhotoDetailCollectionViewCell"
    var url : String?
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
        self.url = nil
    }
    
    
    
    
}

extension PhotoDetailCollectionViewCellImplementation: PhotoDetailCollectionViewCell {
    
    func setImage(_ imgData: Data,_ userName: String, _ url : String){
        DispatchQueue.main.async { [weak self] in
            let image = UIImage(data: imgData)
            self?.photoImageView.image = image
            self?.url = url
        }
    }
    
    func setImage(_ imgData: AnyObject,_ userName: String, _ url : String){
        DispatchQueue.main.async { [weak self] in
            let image = imgData as! UIImage
            self?.photoImageView.image = image
            self?.url = url
        }
    }
}
