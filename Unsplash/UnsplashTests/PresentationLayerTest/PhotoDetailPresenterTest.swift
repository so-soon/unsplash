//
//  PhotoDetailPresenterTest.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import XCTest
@testable import Unsplash

class PhotoDetailPresenterTest: XCTestCase {
    
    let viewMock = PhotoDetailViewMock()
    let fetchPhotoImageUseCaseMock = FetchPhotoImageUseCaseMock()
    let routerMock = PhotoDetailRouterMock()
    let delegateMock = PhotoDetailPresenterDelegateMock()
    
    let cellMock = PhotoDetailCollectionViewCellMock()
    
    let photoListCreator = PhotoListMockCreator()
    let imageDataCreator = UIImageDataCreator()
    
    var presenter: PhotoDetailPresenterImplementation!
    
    override func setUp() {
        let photoListData = photoListCreator.createMockData()
        presenter = PhotoDetailPresenterImplementation(view: viewMock,
                                                       fetchPhotoImageUseCase: fetchPhotoImageUseCaseMock,
                                                       router: routerMock,
                                                       delegate: delegateMock,
                                                       photoListData: photoListData)
    }
    
    func test_GivenRowLargetThanDataSize_WhenConfigure_ThenReturn(){
        
        //Given
        
        let expectedData = photoListCreator.createMockData()
        presenter.photoListData = expectedData
        let row = expectedData.count + 1
        
        //When
        
        presenter.configure(cell: cellMock, forRow: row)
        
        //Then
        
        XCTAssertNil(cellMock.image)
        
    }
    
    func test_GivenValidRow_WhenConfigure_ThenLoadImageData(){
        
        //Given
        
        let expectedPhotoListData = photoListCreator.createMockData()
        presenter.photoListData = expectedPhotoListData
        let row = Int.random(in: 0..<10)
        
        let expectedPhotoImageData = imageDataCreator.createMockData(url: expectedPhotoListData[row].imageURL)
        fetchPhotoImageUseCaseMock.setMockData(expectedPhotoImageData)
        
        //When
        
        presenter.configure(cell: cellMock, forRow: row)
        
        //Then
        
        XCTAssertEqual(expectedPhotoImageData, cellMock.image)
        
    }
    
    func test_GivenDuplicatedURL_WhenConfigure_ThenReturn(){
        
        //Given
        
        let expectedPhotoListData = photoListCreator.createMockData()
        presenter.photoListData = expectedPhotoListData
        let row = Int.random(in: 0..<10)
        
        let expectedPhotoImageData = imageDataCreator.createMockData(url: expectedPhotoListData[row].imageURL)
        fetchPhotoImageUseCaseMock.setMockData(expectedPhotoImageData)
        presenter.configure(cell: cellMock, forRow: row)
        cellMock.image = nil
        
        //When
        
        presenter.configure(cell: cellMock, forRow: row)
        
        //Then
        
        XCTAssertNil(cellMock.image)
        
    }
    
    func test_GivenRandomData_WhenNumberOfRowsInSections_ThenValidCount(){
        
        //Given
        
        let expectedPhotoListData = photoListCreator.createMockDataRandomly()
        presenter.photoListData = expectedPhotoListData
        let expectedCount = expectedPhotoListData.count
        
        //When
        
        let returnedCount = presenter.numberOfRowsInSection()
        
        //Then
        
        XCTAssertEqual(expectedCount, returnedCount)
        
    }
    
    func test_WhenCellReachEndIndex_ThenValidData(){
        
        //Given
        
        let expectedPhotoListData = photoListCreator.createMockData()
        delegateMock.setMockData(photoListData: expectedPhotoListData)
        let row = Int.random(in: 0..<10)
        
        //When
        
        presenter.cellReachEndIndex(at: row)
        
        //Then
        
        XCTAssertEqual(expectedPhotoListData, presenter.photoListData)
        
    }
    
    func test_WhenCellReachEndIndex_ThenReloadCollectionView(){
        
        //Given
        
        let expectedPhotoListData = photoListCreator.createMockData()
        delegateMock.setMockData(photoListData: expectedPhotoListData)
        let row = Int.random(in: 0..<10)
        
        //When
        
        presenter.cellReachEndIndex(at: row)
        
        //Then
        
        XCTAssertTrue(viewMock.resultReloadCollectionView)
        
    }
    
    func test_GivenRandomRow_WhenChangePhotoFocus_ThenMovePhotoFocus(){
        
        //Given
        
        let randomRow = Int.random(in: 0..<100)
        
        //When
        
        presenter.changePhotoFocus(to: randomRow)
        
        //Then
        
        XCTAssertEqual(randomRow, delegateMock.photoFocusRow)
        
    }
    
    func test_WhenViewWillAppear_ThenDelegateCalled(){
        
        //When
        
        presenter.viewWillAppear()
        
        //Then
        
        XCTAssertTrue(delegateMock.resultViewWillAppear)
    }
    
    func test_WhenViewWillDisappear_ThenDelegateCalled(){
        
        //When
        
        presenter.viewWillDisappear()
        
        //Then
        
        XCTAssertTrue(delegateMock.resultViewWillDisappear)
    }
    
    override func tearDown() {
        self.viewMock.reset()
        self.fetchPhotoImageUseCaseMock.reset()
        self.routerMock.reset()
        self.delegateMock.reset()
        self.cellMock.reset()
        
        self.presenter = nil
    }

}
