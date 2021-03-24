//
//  PhotoListRepositoryTest.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import XCTest
@testable import Unsplash

class PhotoListRepositoryTest: XCTestCase {
    let apiServiceMock = APIServiceMock()
    
    let photoListCreator = PhotoListMockCreator()
    
    
    var repository : PhotoListRepositoryImplementaiton!
    
    override func setUp() {
        repository = PhotoListRepositoryImplementaiton(apiService: apiServiceMock)
    }
    
    func test_GivenRandomPageCount_WhenDefaultFetchingSucess_ThenReturnValidData(){
        
        //Given
        
        let pageCount = Int.random(in: 1..<10)
        var expectedPhotoListData :[PhotoModel] = []
        
        for _ in 0...pageCount{
            expectedPhotoListData.append(contentsOf: photoListCreator.createMockData())
        }
        apiServiceMock.setMockData(photoListResponseDTO: expectedPhotoListData.map{$0.toDefaultDTO()})
        
        //When
        var returnedPhotoListData :[PhotoModel] = []
        
        for _ in 0...pageCount{
            repository.fetching(){result in
                switch result {
                case .success(let photoListData):
                    returnedPhotoListData.append(contentsOf: photoListData)
                case .failure(_):
                    XCTAssert(false)
                }
            }
        }
        
        //Then
        XCTAssertEqual(expectedPhotoListData, returnedPhotoListData)
        
    }
    
    func test_WhenDefaultFetchingFailed_ThenReturnValidData(){
        
        //Given
        let expectedPhotoListData = photoListCreator.createMockData()
        
        apiServiceMock.setMockData(photoListResponseDTO: expectedPhotoListData.map{$0.toDefaultDTO()})
        
        apiServiceMock.isSucessMode = false
        
        //When,Then
        
        repository.fetching(){result in
            switch result {
            case .success(_):
                XCTAssert(false)
            case .failure(_):
                XCTAssert(true)
            }
        }
        
    }
    
    func test_GivenNewSearchWord_WhenSearchFetchingSucess_ThenFlushRepository(){
        
        //Given
        
        let prevSearchWord = "PREV_SEARCH_WORD"
        let newSearchWord = "NEW_SEARCH_WORD"
        
        let expectedPrevPhotoListData = photoListCreator.createMockData(total: 30)
        let expectedPrevResponse = SearchPhotoListResponseDTO(total: 30, total_pages: 3, results: expectedPrevPhotoListData.map{$0.toDefaultDTO()})
        
        let expectedNewPhotoListData = photoListCreator.createMockData(total: 30)
        let expectedNewResponse = SearchPhotoListResponseDTO(total: 30, total_pages: 3, results: expectedNewPhotoListData.map{$0.toDefaultDTO()})
        
        apiServiceMock.setMockData(searchWord: prevSearchWord, searchPhotoListResponseDTO: expectedPrevResponse)
        
        apiServiceMock.setMockData(searchWord: newSearchWord, searchPhotoListResponseDTO: expectedNewResponse)
        
        repository.fetching(searchWord: prevSearchWord){result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                XCTAssert(false)
            }
        }
        
        //When,Then
        
        repository.fetching(searchWord: newSearchWord){result in
            switch result {
            case .success(let photoListData):
                let firstPageInNewPhotoList = Array(expectedNewPhotoListData[0..<10])
                XCTAssertEqual(firstPageInNewPhotoList, photoListData)
            case .failure(_):
                XCTAssert(false)
            }
        }
    }
    
    func test_GivenPageLargerThanTotalPages_WhenSearchFetchingSucess_ThenReturnFail(){
        
        //Given
        
        let searchWord = "SEARCH_WORD"
        let expectedPhotoListData = photoListCreator.createMockData(total: 10)
        let expectedResponse = SearchPhotoListResponseDTO(total: 10, total_pages: 1, results: expectedPhotoListData.map{$0.toDefaultDTO()})
        
        apiServiceMock.setMockData(searchWord: searchWord, searchPhotoListResponseDTO: expectedResponse)
        
        repository.fetching(searchWord: searchWord){result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                XCTAssert(false)
            }
        }
        
        //When,Then
        
        repository.fetching(searchWord: searchWord){result in
            switch result {
            case .success(_):
                XCTAssert(false)
            case .failure(_):
                XCTAssert(true)
            }
        }
        
    }
    
    func test_GivenValidData_WhenSearchFetchingSucessTwoTimes_ThenReturnValidData(){
        
        //Given
        
        let searchWord = "SEARCH_WORD"
        let expectedPhotoListData = photoListCreator.createMockData(total: 20)
        let expectedResponse = SearchPhotoListResponseDTO(total: 20, total_pages: 2, results: expectedPhotoListData.map{$0.toDefaultDTO()})
        
        apiServiceMock.setMockData(searchWord: searchWord, searchPhotoListResponseDTO: expectedResponse)
        
        //When
        
        var returnedPhotoListdata : [PhotoModel] = []
        
        for _ in 0..<2{
            repository.fetching(searchWord: searchWord){result in
                switch result {
                case .success(let photoListData):
                    returnedPhotoListdata.append(contentsOf: photoListData)
                case .failure(_):
                    XCTAssert(false)
                }
            }
        }
        
        //Then
        
        XCTAssertEqual(expectedPhotoListData, returnedPhotoListdata)
        
    }
    
    func test_WhenSearchFetchingFailed_ThenFlushRepository(){
        
        //Given
        
        let searchWord = "SEARCH_WORD"
        let expectedPhotoListData = photoListCreator.createMockData(total: 20)
        let expectedResponse = SearchPhotoListResponseDTO(total: 20, total_pages: 2, results: expectedPhotoListData.map{$0.toDefaultDTO()})
        
        apiServiceMock.setMockData(searchWord: searchWord, searchPhotoListResponseDTO: expectedResponse)
        
        //page count up
        repository.fetching(searchWord: searchWord){result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                XCTAssert(false)
            }
        }
        
        //When
        
        apiServiceMock.isSucessMode = false
        
        repository.fetching(searchWord: searchWord){result in
            switch result {
            case .success(_):
                XCTAssert(false)
            case .failure(_):
                XCTAssert(true)
            }
        }
        
        //Then
        
        apiServiceMock.isSucessMode = true
        
        repository.fetching(searchWord: searchWord){result in
            switch result {
            case .success(let photoListData):
                let firstPageInExpectedPhotoList = Array(expectedPhotoListData[0..<10])
                
                XCTAssertEqual(firstPageInExpectedPhotoList, photoListData)
            case .failure(_):
                XCTAssert(false)
            }
        }
        
        
    }
    
    override func tearDown() {
        apiServiceMock.reset()
        
        repository = nil
    }

}
