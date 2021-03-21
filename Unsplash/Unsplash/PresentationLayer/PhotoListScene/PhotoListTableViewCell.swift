//
//  PhotoListTableViewCell.swift
//  Unsplash
//
//  Created by Randy on 2021/03/20.
//

import UIKit

class PhotoListTableViewCell: UITableViewCell {
    static let id = "PhotoListTableViewCell"
    
    //MARK:- Interface Builder Links
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setImage(_ imgData: Data,_ userName: String){
        DispatchQueue.main.async { [weak self] in
            let image = UIImage(data: imgData)
            self?.photoImageView.image = image
            self?.userNameLabel.text = userName
        }
    }

}
