//
//  PhotoModel.swift
//  Unsplash
//
//  Created by Randy on 2021/03/21.
//

import Foundation

struct PhotoModel {
    let id: String
    let userName : String
    let imageURL : String
    let width: Int
    let height: Int
}

extension PhotoModel : Equatable {
    public static func ==(lhs: PhotoModel, rhs: PhotoModel) -> Bool {
        return lhs.id == rhs.id && lhs.userName == rhs.userName && lhs.imageURL == rhs.imageURL && lhs.width == rhs.width && lhs.height == rhs.height
    }
}
