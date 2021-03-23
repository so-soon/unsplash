//
//  PhotoListResponseDTO.swift
//  Unsplash
//
//  Created by Randy on 2021/03/21.
//

import Foundation

struct SearchPhotoListResponseDTO : Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResponseDTO]
    
}


