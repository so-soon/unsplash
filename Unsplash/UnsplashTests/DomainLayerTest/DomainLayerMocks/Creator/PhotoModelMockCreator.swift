//
//  PhotoModelMockCreator.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import Foundation
@testable import Unsplash

class PhotoListMockCreator {
    let mockId = ["a","b","c","d","e","f","g","h","i","j"]
    let mockUserName = ["kim","lee","park","choi","ahn","oh","jin","jeon","yoon","baek"]
    let mockImageURL = ["https://api1","https://api2","https://api3","https://api4","https://api5","https://api6","https://api7","https://api8","https://api9","https://api10"]
    let mockWidth = [1,2,3,4,5,6,7,8,9,10]
    let mockHeight = [1,2,3,4,5,6,7,8,9,10]
    
    func createMockData() -> [PhotoModel] {
        var mockData : [PhotoModel] = []
        
        for i in 0..<10{
            let rand = Int.random(in: 0..<10)
            mockData.append(PhotoModel(id: mockId[rand], userName: mockUserName[rand], imageURL: mockImageURL[rand], width: mockWidth[rand], height: mockHeight[rand]))
        }
        
        return mockData
    }
}
