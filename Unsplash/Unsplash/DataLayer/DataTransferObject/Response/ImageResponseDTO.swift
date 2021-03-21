//
//  ImageResponseDTO.swift
//  Unsplash
//
//  Created by Randy on 2021/03/21.
//

import Foundation

struct ImageResponseDTO {
    let data : Data
}

extension ImageResponseDTO {
    func toDomain() -> Data {
        return self.data
    }
}
