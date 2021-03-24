//
//  UIImageDataCreator.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import Foundation

class UIImageDataCreator {
    func createMockData(url : String) -> Data {
        return url.data(using: .utf8)!
    }
}
