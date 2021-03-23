//
//  PhotoListPresenterTest.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import XCTest
@testable import Unsplash

class PhotoListPresenterTest: XCTestCase {
    let fetchDefaultPhotoListUseCaseMock = FetchDefaultPhotoListUseCaseMock()
    let fetchPhotoImageUseCaseMock = FetchPhotoImageUseCaseMock()
    let searchPhotoListUseCaseMock = SearchPhotoListUseCaseMock()
    let routerMock = PhotoListRouterMock()
    let viewMock = PhotoListViewMock()
    
    let photoListCreator = PhotoListMockCreator()
    
    var presenter: PhotoListPresenterImplementation!
    
    override func setUp() {
        presenter = PhotoListPresenterImplementation(view: viewMock, fetchDefaultPhotoListUseCase: fetchDefaultPhotoListUseCaseMock, fetchPhotoImageUseCase: fetchPhotoImageUseCaseMock, searchPhotoListUseCase: searchPhotoListUseCaseMock, router: routerMock)
    }
    
    func test_WhenViewDidLoad_ThenLoadData(){
        //Given
        let expectedData = photoListCreator.createMockData()
        fetchDefaultPhotoListUseCaseMock.setMockData(expectedData)
        
        //When
        presenter.viewDidLoad()
        
        //Then
        XCTAssertEqual(expectedData, presenter.photoListData)
    }
    
    
    override func tearDown() {
        fetchPhotoImageUseCaseMock.reset()
        fetchDefaultPhotoListUseCaseMock.reset()
        searchPhotoListUseCaseMock.reset()
        routerMock.reset()
        viewMock.reset()

        presenter = nil
    }
}
