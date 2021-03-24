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
    var mockWidth : [Int] {
        get{
            var value : [Int] = []
            for _ in 0..<10{
                let randValue = Int.random(in: 1..<100)
                value.append(randValue)
            }
            return value
        }
    }
    var mockHeight : [Int] {
        get{
            var value : [Int] = []
            for _ in 0..<10{
                let randValue = Int.random(in: 1..<100)
                value.append(randValue)
            }
            return value
        }
    }
    func createMockData(total: Int = 10) -> [PhotoModel] {
        var mockData : [PhotoModel] = []
        
        for _ in 0..<total{
            let rand = Int.random(in: 0..<10)
            mockData.append(PhotoModel(id: mockId[rand], userName: mockUserName[rand], imageURL: mockImageURL[rand], width: mockWidth[rand], height: mockHeight[rand]))
        }
        
        return mockData
    }
    
    func createMockDataRandomly() -> [PhotoModel] {
        var mockData : [PhotoModel] = []
        let randCount = Int.random(in:1..<30)
        for _ in 0..<randCount{
            let rand = Int.random(in: 0..<10)
            mockData.append(PhotoModel(id: mockId[rand], userName: mockUserName[rand], imageURL: mockImageURL[rand], width: mockWidth[rand], height: mockHeight[rand]))
        }
        
        return mockData
    }
}
