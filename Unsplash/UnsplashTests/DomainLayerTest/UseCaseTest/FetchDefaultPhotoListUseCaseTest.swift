//
//  FetchDefaultPhotoListUseCaseTest.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import XCTest
@testable import Unsplash

class FetchDefaultPhotoListUseCaseTest: XCTestCase {
    let photoListRepository = PhotoListRepositoryMock()
    
    let photoListCreator = PhotoListMockCreator()
    
    var useCase: FetchDefaultPhotoListUseCaseImplementation!
    
    override func setUp(){
        useCase = FetchDefaultPhotoListUseCaseImplementation(repository: photoListRepository)
    }
    
    func test_WhenExecuteSucess_ThenReturnValidData(){
        
        //Given
        
        let expectedData = photoListCreator.createTenMockData()
        photoListRepository.setMockData(photoListData: expectedData)
        
        //When,Then
        
        useCase.execute{result in
            switch result{
            case .success(let photoListData):
                XCTAssertEqual(expectedData, photoListData)
            case .failure(_):
                XCTAssertTrue(false)
            }
        }
        
    }
    
    func test_WhenExecuteFailed_ThenReturnValidError(){
        
        //Given
        
        let expectedData = photoListCreator.createTenMockData()
        photoListRepository.setMockData(photoListData: expectedData)
        photoListRepository.isSucessMode = false
        
        //When,Then
        
        useCase.execute{result in
            switch result{
            case .success(_):
                XCTAssertTrue(false)
            case .failure(let error):
                XCTAssertEqual(error as! PhotoListRepositoryError, PhotoListRepositoryError.kInvalidPageRequestError)
            }
        }
        
    }
    
    override func tearDown(){
        photoListRepository.reset()
        
        useCase = nil
    }

}
