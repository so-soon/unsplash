//
//  PhotoResponseDTO.swift
//  Unsplash
//
//  Created by Randy on 2021/03/21.
//

import Foundation

struct PhotoResponseDTO : Decodable{
    let id: String
    let width: Int
    let height: Int
    let urls: PhotoReponseURLsDTO
    let user: PhotoReponseUserDTO
}

struct PhotoReponseURLsDTO: Decodable {
    let regular: String?
}

struct PhotoReponseUserDTO: Decodable {
    let name: String?
}
