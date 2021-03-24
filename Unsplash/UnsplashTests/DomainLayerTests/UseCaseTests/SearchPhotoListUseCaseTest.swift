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
        
        let expectedData = photoListCreator.createMockData()
        let searchWord = "SEARCH_WORD"
        photoListRepository.setMockData(searchWord: searchWord, photoListData: expectedData)
        
        //When,Then
        
        useCase.execute(searchWord: searchWord){result in
            switch result{
            case .success(let searchPhotoListData):
                XCTAssertEqual(expectedData, searchPhotoListData)
            case .failure(_):
                XCTAssert(false)
            }
        }
        
    }
    
    func test_WhenExecuteFailed_ThenReturnValidError(){
        
        //Given
        
        let expectedData = photoListCreator.createMockData()
        photoListRepository.setMockData(photoListData: expectedData)
        photoListRepository.isSucessMode = false
        let searchWord = "FAILED_SEARCH_WORD"
        //When,Then
        
        useCase.execute(searchWord:searchWord){result in
            switch result{
            case .success(let emptyData):
                XCTAssertEqual(emptyData,[])
            case .failure(_):
                XCTAssert(false)
            }
        }
        
    }
    
    func test_GivenSleepMode_WhenExecute_ThenUseCaseLockWork(){
        
        //Given
        let expectedDataA = photoListCreator.createMockData()
        let expectedDataB = photoListCreator.createMockData()
        let searchWordA = "SEARCH_WORD_A"
        let searchWordB = "SEARCH_WORD_B"
        photoListRepository.setMockData(searchWord: searchWordA, photoListData: expectedDataA)
        photoListRepository.setMockData(searchWord: searchWordB, photoListData: expectedDataB)
        
        photoListRepository.isSleepMode = true
        
        
        //When
        
        var returnedDataA : [PhotoModel] = []
        var returnedDataB : [PhotoModel] = []
        
        DispatchQueue.global().async { [weak self] in
            self?.useCase.execute(searchWord: searchWordA, completion: {result in
                switch result{
                case .success(let photoListData):
                    returnedDataA = photoListData
                    
                case .failure(_):
                    XCTAssert(false)
                }
            })
        }
        
        DispatchQueue.global().async { [weak self] in
            self?.photoListRepository.isSleepMode = false
            self?.useCase.execute(searchWord: searchWordB){result in
                switch result {
                case .success(let photoListData):
                    returnedDataB = photoListData
                    
                case .failure(_):
                    XCTAssert(false)
                }
            }
        }
        
        Thread.sleep(forTimeInterval: 3)
        
        let areTwoArrayLoadProperly = returnedDataA.count == returnedDataB.count
        
        //Then
        
        XCTAssertFalse(areTwoArrayLoadProperly)
        
    }
    
    func test_GivenNotRespositoryError_WhenExecute_ThenReturnError(){
        
        //Given
        let searchWord = "SEARCH_WORD"
        photoListRepository.isRepositoryErrorEmit = false
        photoListRepository.isSucessMode = false
        
        //When,Then
        
        useCase.execute(searchWord: searchWord){result in
            switch result {
            case .success(_):
                XCTAssert(false)
            case .failure(let error):
                let isErrorRepositoryErrorType = error as? PhotoListRepositoryError
                XCTAssertNil(isErrorRepositoryErrorType)
            }
        }
        
        
    }
    
    override func tearDown() {
        photoListRepository.reset()
        
        useCase = nil
    }


}
