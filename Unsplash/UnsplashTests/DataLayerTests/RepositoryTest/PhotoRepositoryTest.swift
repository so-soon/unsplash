//
//  PhotoRepositoryTest.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import XCTest
@testable import Unsplash

class PhotoRepositoryTest: XCTestCase {
    let apiServiceMock = APIServiceMock()
    let cacheServiemock = CacheServiceMock()
    
    let photoListCreator = PhotoListMockCreator()
    let imageDataCreator = UIImageDataCreator()
    
    var repository: PhotoRepositoryImplementation!
    
    override func setUp() {
        repository = PhotoRepositoryImplementation(apiService: apiServiceMock, cacheService: cacheServiemock)
    }
    
    func test_GivenSucessCacheService_WhenFetchingSucess_ThenReturnCacheData(){
        
        //Given
        let expectation = self.expectation(description: "Cache Data fetched")
        let url = "https://api\(Int.random(in: 1..<10)).com"
        let expectedImageData = imageDataCreator.createMockDataWithURL(url: url)
        var returnedImageData : Data!
        
        cacheServiemock.setMockData(url: url, data: expectedImageData)
        
        apiServiceMock.isSucessMode = false
        
        //When
        
        repository.fetching(imageURL: url, cached: {imgData in
            returnedImageData = imgData as? Data
            expectation.fulfill()
        }, completion: {_ in})
        
        //Then
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(expectedImageData, returnedImageData)
    }
    
    func test_GivenFailedCacheService_WhenFetchingSucess_ThenCachingData(){
        
        //Given
        
        let expectation = self.expectation(description: "Data cached")
        let url = "https://api\(Int.random(in: 1..<10)).com"
        let expectedImageData = imageDataCreator.createMockDataWithURL(url: url)
        cacheServiemock.isSucessMode = false
        
        apiServiceMock.setMockData(imgData: expectedImageData)
        
        //When
        
        repository.fetching(imageURL: url, cached: {_ in}, completion: {_ in
            expectation.fulfill()
        })
        
        //Then
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(expectedImageData, cacheServiemock.cacheStorageMock[url] as! Data)
        
    }
    
    func test_GivenFailedCacheService_WhenFetchingSucess_ThenReturnValidData(){
        
        //Given
        
        let expectation = self.expectation(description: "API Data fetched")
        let url = "https://api\(Int.random(in: 1..<10)).com"
        let expectedImageData = imageDataCreator.createMockDataWithURL(url: url)
        var returnedImageData : Data!
        cacheServiemock.isSucessMode = false
        
        apiServiceMock.setMockData(imgData: expectedImageData)
        
        //When
        
        repository.fetching(imageURL: url, cached: {_ in}, completion: {result in
            switch result {
            case .success(let imgData):
                returnedImageData = imgData
                expectation.fulfill()
            case .failure(_):
                XCTAssert(false)
            }
        })
        
        //Then
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(expectedImageData, returnedImageData)
        
    }
    
    func test_GivenFailedAPIService_WhenFetchingFailed_ThenReturnError(){
        
        //Given
        let expectation = self.expectation(description: "API Error emitted")
        let url = "https://api\(Int.random(in: 1..<10)).com"
        cacheServiemock.isSucessMode = false
        apiServiceMock.isSucessMode = false
        
        //When
        
        repository.fetching(imageURL: url, cached: {_ in}, completion: {result in
            switch result{
            case .success(_):
                XCTAssert(false)
            case .failure(_):
                expectation.fulfill()
            }
        })
        
        //Then
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(true)
    }
    
    
    
    override func tearDown() {
        apiServiceMock.reset()
        cacheServiemock.reset()
        
        repository = nil
    }
}
