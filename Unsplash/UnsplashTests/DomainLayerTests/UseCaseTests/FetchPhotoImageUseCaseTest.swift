//
//  FetchPhotoImageUseCaseTest.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import XCTest
@testable import Unsplash

class FetchPhotoImageUseCaseTest: XCTestCase {
    let photoRepository = PhotoRepositoryMock()
    
    let photoListCreator = PhotoListMockCreator()
    let imageDataCreator = UIImageDataCreator()
    
    var useCase: FetchPhotoImageUseCaseImplementation!
    
    override func setUp() {
        useCase = FetchPhotoImageUseCaseImplementation(repository: photoRepository)
    }
    
    func test_WhenExecuteSucessWithoutCache_ThenReturnValidData(){
        
        //Given
        
        let expectedPhotoListData = photoListCreator.createMockData()
        let row = Int.random(in: 0..<10)
        
        let expectedImageData = imageDataCreator.createMockDataWithURL(url: expectedPhotoListData[row].imageURL)
        photoRepository.setMockData(photoImageData: expectedImageData)
        
        //When,Then
        
        useCase.execute(imageURL: expectedPhotoListData[row].imageURL, cached: {_ in}){result in
            switch result {
            case .success(let imgData):
                XCTAssertEqual(expectedImageData, imgData)
            case .failure(_):
                XCTAssert(false)
            }
        }
    }
    
    func test_WhenExecuteFailedWithoutCache_ThenReturnValidError(){
        
        //Given
        
        let expectedPhotoListData = photoListCreator.createMockData()
        let row = Int.random(in: 0..<10)
        
        let expectedImageData = imageDataCreator.createMockDataWithURL(url: expectedPhotoListData[row].imageURL)
        photoRepository.setMockData(photoImageData: expectedImageData)
        photoRepository.isSucessMode = false
        
        //When,Then
        
        useCase.execute(imageURL: expectedPhotoListData[row].imageURL, cached: {_ in}){result in
            switch result {
            case .success(_):
                XCTAssert(false)
            case .failure(_):
                XCTAssert(true)
            }
        }
    }
    
    func test_WhenExecuteCache_ThenReturnValidData(){
        
        //Given
        
        let expectedPhotoListData = photoListCreator.createMockData()
        let row = Int.random(in: 0..<10)
        
        let expectedImageData = imageDataCreator.createMockDataWithURL(url: expectedPhotoListData[row].imageURL)
        photoRepository.setMockData(photoImageData: expectedImageData)
        photoRepository.isCacheMode = true
        
        //When,Then
        
        useCase.execute(imageURL: expectedPhotoListData[row].imageURL, cached: { imgData in
            XCTAssertEqual(expectedImageData, imgData as! Data)
        },completion: {_ in})
        
    }
    
    override func tearDown() {
        photoRepository.reset()
        
        useCase = nil
    }
}
