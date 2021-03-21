//
//  PhotoListTableViewCell.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import UIKit

class PhotoListTableViewCell: UITableViewCell {
    static let id = "PhotoListTableViewCell"
    var url : String?
    
    //MARK:- Interface Builder Links
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
        self.userNameLabel.text = nil
        self.url = nil
    }
    func setImage(_ imgData: Data,_ userName: String, _ url : String){
        DispatchQueue.main.async { [weak self] in
            let image = UIImage(data: imgData)
            self?.photoImageView.image = image
            self?.userNameLabel.text = userName
            self?.url = url
        }
    }
    
    func setImage(_ imgData: AnyObject,_ userName: String, _ url : String){
        DispatchQueue.main.async { [weak self] in
            let image = imgData as! UIImage
            self?.photoImageView.image = image
            self?.userNameLabel.text = userName
            self?.url = url
        }
    }

}
