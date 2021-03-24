//
//  UIImageDataCreator.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import UIKit

class UIImageDataCreator {
    let systemNames = ["icloud.and.arrow.down.fill","icloud.and.arrow.up","icloud.and.arrow.up.fill","icloud.circle","icloud.circle.fill","icloud.fill"]
    
    func createMockDataWithURL(url : String) -> Data {
        return url.data(using: .utf8)!
    }
    
    func createUIImageMockData() -> Data?{
        let randIdx = Int.random(in: 0..<systemNames.count)
        let image = UIImage(systemName: systemNames[randIdx])
        return image?.pngData()
    }
}

