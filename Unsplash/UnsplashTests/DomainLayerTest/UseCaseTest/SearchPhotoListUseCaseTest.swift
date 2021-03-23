//
//  SearchPhotoListUseCaseTest.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import XCTest
@testable import Unsplash

class SearchPhotoListUseCaseTest: XCTestCase {
    let photoListRepository = PhotoListRepositoryMock()
    
    let photoListCreator = PhotoListMockCreator()
    
    var useCase: SearchPhotoListUseCaseImplementation!
    
    override func setUp() {
        useCase = SearchPhotoListUseCaseImplementation(repository: photoListRepository)
    }
    
    func test_WhenExecuteSucessWithSearchWord_ThenReturnValidData(){
        
        //Given
        
        let expectedData = photoListCreator.createTenMockData()
        let searchWord = "SEARCH_WORD"
        photoListRepository.setSearchMockData(searchWord: searchWord, photoListData: expectedData)
        
        //When,Then
        
        useCase.execute(searchWord: searchWord){result in
            switch result{
            case .success(let searchPhotoListData):
                XCTAssertEqual(expectedData, searchPhotoListData)
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
        let searchWord = "FAILED_SEARCH_WORD"
        //When,Then
        
        useCase.execute(searchWord:searchWord){result in
            switch result{
            case .success(_):
                XCTAssertTrue(false)
            case .failure(let error):
                XCTAssertEqual(error as! PhotoListRepositoryError, PhotoListRepositoryError.kInvalidPageRequestError)
            }
        }
        
    }
    
    override func tearDown() {
        photoListRepository.reset()
        
        useCase = nil
    }


}
