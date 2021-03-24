//
//  PhotoListPresenterTest.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import XCTest
@testable import Unsplash

class PhotoListPresenterTest: XCTestCase {
    let viewMock = PhotoListViewMock()
    let fetchDefaultPhotoListUseCaseMock = FetchDefaultPhotoListUseCaseMock()
    let fetchPhotoImageUseCaseMock = FetchPhotoImageUseCaseMock()
    let searchPhotoListUseCaseMock = SearchPhotoListUseCaseMock()
    let routerMock = PhotoListRouterMock()
    
    let cellMock = PhotoListTableViewCellMock()
    
    let photoListCreator = PhotoListMockCreator()
    let imageDataCreator = UIImageDataCreator()
    
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
    
    func test_GivenDefaultUseCaseFailed_WhenViewDidLoad_ThenReturnError(){
        
        //Given
        
        var expectedData : [PhotoModel] = []
        for _ in 0..<10{
            expectedData.append(PhotoModel(id: NetworkErrorHandler.errorImageId,
                                        userName: NetworkErrorHandler.errorImageId,
                                        imageURL: NetworkErrorHandler.errorImageURL,
                                        width: NetworkErrorHandler.errorImageWidth,
                                        height: NetworkErrorHandler.errorImageHeight))
        }
        fetchDefaultPhotoListUseCaseMock.isSucessMode = false
        
        //When
        presenter.viewDidLoad()
        
        //Then
        XCTAssertEqual(expectedData, presenter.photoListData)
    }
    
    func test_GivenCacheMode_WhenConfigure_ThenReturnCacheData(){
        
        //Given
        
        let expectedPhotoListData = photoListCreator.createMockData()
        presenter.photoListData = expectedPhotoListData
        let row = Int.random(in: 0..<expectedPhotoListData.count)
        
        let expectedPhotoImageData = imageDataCreator.createMockDataWithURL(url: expectedPhotoListData[row].imageURL)
        fetchPhotoImageUseCaseMock.setMockData(expectedPhotoImageData)
        
        fetchPhotoImageUseCaseMock.isCacheMode = true
        
        //When
        
        presenter.configure(cell: cellMock, forRow: row)
        
        //Then
        
        XCTAssertEqual(expectedPhotoImageData, cellMock.image)
    }
    
    func test_GivenRowLargerThanDataSize_WhenConfigure_ThenReturnNotNilImage(){
        
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
        let row = Int.random(in: 0..<expectedPhotoListData.count)
        
        let expectedPhotoImageData = imageDataCreator.createMockDataWithURL(url: expectedPhotoListData[row].imageURL)
        fetchPhotoImageUseCaseMock.setMockData(expectedPhotoImageData)
        
        //When
        
        presenter.configure(cell: cellMock, forRow: row)
        
        //Then

        XCTAssertEqual(expectedPhotoImageData, cellMock.image)
    }
    
    func test_GivenDuplicatedURL_WhenConfigure_ThenReturnNotNilImage(){
        
        //Given
        
        let expectedPhotoListData = photoListCreator.createMockData()
        presenter.photoListData = expectedPhotoListData
        let row = Int.random(in: 0..<expectedPhotoListData.count)
        
        let expectedPhotoImageData = imageDataCreator.createMockDataWithURL(url: expectedPhotoListData[row].imageURL)
        fetchPhotoImageUseCaseMock.setMockData(expectedPhotoImageData)
        presenter.configure(cell: cellMock, forRow: row)
        cellMock.image = nil
        
        //When
        
        presenter.configure(cell: cellMock, forRow: row)
        
        //Then
        
        XCTAssertNil(cellMock.image)
    }
    
    func test_GivenFailedUseCase_WhenConfigure_ThenReturnErrorImage(){
        
        //Given
        let expectedPhotoListData = photoListCreator.createMockData()
        presenter.photoListData = expectedPhotoListData
        let expectedPhotoImageData = NetworkErrorHandler.shared.getErrorImage()
        let row = Int.random(in: 0..<expectedPhotoListData.count)
        
        fetchPhotoImageUseCaseMock.isCacheMode = false
        fetchPhotoImageUseCaseMock.isSucessMode = false
        //When
        
        presenter.configure(cell: cellMock, forRow: row)
        
        //Then
        
        XCTAssertEqual(expectedPhotoImageData, cellMock.image)
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
    
    func test_GivenRowLargerThanDataSize_WhenPhotoRatioHeight_ThenReturnZero(){
        
        //Given
        
        let expectedData = photoListCreator.createMockData()
        let row = expectedData.count + 1
        
        //When
        
        let returnHeight = presenter.photoRatioHeight(cellAt: row)
        
        //Then
        
        XCTAssertEqual(Float(0), returnHeight)
        
    }
    
    func test_GivenValidData_WhenPhotoRatioHeight_ThenReturnValidRatio(){
        
        //Given
        
        let expectedData = photoListCreator.createMockData()
        presenter.photoListData = expectedData
        let row = Int.random(in: 0..<expectedData.count)
        let expectedHeight = Float(expectedData[row].height) / Float(expectedData[row].width)
        //When
        
        let returnedHeight = presenter.photoRatioHeight(cellAt: row)
        
        //Then
        
        XCTAssertEqual(expectedHeight, returnedHeight)
        
    }
    
    func test_WhenDidSelect_ThenRouterHasDelegate(){
        
        //Given
        
        let expectedData = photoListCreator.createMockData()
        presenter.photoListData = expectedData
        let row = Int.random(in: 0..<expectedData.count)
        
        //When
        
        presenter.didSelect(cellAt: row)
        
        //Then
        
        XCTAssert(routerMock.delegate === presenter)
        
    }
    
    func test_WhenDidSelect_ThenRouterHasData(){
        
        //Given
        
        let expectedData = photoListCreator.createMockData()
        presenter.photoListData = expectedData
        let row = Int.random(in: 0..<expectedData.count)
        
        //When
        
        presenter.didSelect(cellAt: row)
        
        //Then
        
        XCTAssertEqual(routerMock.photoListData,expectedData)
        
    }
    
    func test_WhenDidSelect_ThenRouterHasSender(){
        
        //Given
        
        let expectedData = photoListCreator.createMockData()
        presenter.photoListData = expectedData
        let row = Int.random(in: 0..<expectedData.count)
        
        //When
        
        presenter.didSelect(cellAt: row)
        
        //Then
        
        XCTAssertEqual(routerMock.sender,row)
        
    }
    
    func test_GivenDuplicatedSearchWord_WhenSearchTextFieldEndEdit_ThenNotFetchData(){
        
        //Given
        
        let expectedSearchData = photoListCreator.createMockData()
        searchPhotoListUseCaseMock.setMockData(expectedSearchData)
        let searchWord = "DUPLICATED_SEARCH_WORD"
        presenter.searchTextFieldEndEdit(with: searchWord)
        presenter.photoListData = []
        
        //When
        
        presenter.searchTextFieldEndEdit(with: searchWord)
        
        //Then
        
        XCTAssertEqual(presenter.photoListData, [])
        
    }
    
    func test_GivenFailedSearchUseCase_WhenSearchTextFieldEndEdit_ThenReturnError(){
        
        //Given
        let searchWord = "SEARCH_WORD"
        var expectedData : [PhotoModel] = []
        for _ in 0..<10{
            expectedData.append(PhotoModel(id: NetworkErrorHandler.errorImageId,
                                        userName: NetworkErrorHandler.errorImageId,
                                        imageURL: NetworkErrorHandler.errorImageURL,
                                        width: NetworkErrorHandler.errorImageWidth,
                                        height: NetworkErrorHandler.errorImageHeight))
        }
        searchPhotoListUseCaseMock.isSucessMode = false
        
        //When
        
        presenter.searchTextFieldEndEdit(with: searchWord)
        
        //Then
        XCTAssertEqual(expectedData, presenter.photoListData)
    }
    
    func test_GivenNilSearchWord_WhenSearchTextFieldEndEdit_ThenNotFetchData(){
        
        //Given
        
        let expectedSearchData = photoListCreator.createMockData()
        searchPhotoListUseCaseMock.setMockData(expectedSearchData)
        
        //When
        
        presenter.searchTextFieldEndEdit(with: nil)
        
        //Then
        
        XCTAssertEqual(presenter.photoListData, [])
    }
    
    func test_GivenEmptySearchWord_WhenSearchTextFieldEndEdit_ThenFetchDefaultData(){
        
        //Given
        
        let defaultData = photoListCreator.createMockData()
        fetchDefaultPhotoListUseCaseMock.setMockData(defaultData)
        
        let expectedSearchData = photoListCreator.createMockData()
        searchPhotoListUseCaseMock.setMockData(expectedSearchData)
        
        presenter.viewDidLoad()
        let returnedData = presenter.photoListData
        
        //When
        
        presenter.searchTextFieldEndEdit(with: "")
        
        //Then
        
        XCTAssertEqual(returnedData, presenter.photoListData)
    }
    
    func test_GivenPrevPostData_WhenSearchTextFieldEndEdit_ThenUpdateData(){
        
        //Given
        let prevData = photoListCreator.createMockData()
        searchPhotoListUseCaseMock.setMockData(prevData)
        
        let prevSearchWord = "PREV_SEARCH_WORD"
        presenter.searchTextFieldEndEdit(with: prevSearchWord)
        
        let postData = photoListCreator.createMockData()
        searchPhotoListUseCaseMock.setMockData(postData)
        
        let postSearchWord = "POST_SEARCH_WORD"
        
        //When
        
        presenter.searchTextFieldEndEdit(with: postSearchWord)
        
        //Then
        
        XCTAssertNotEqual(prevData, presenter.photoListData)
        
    }
    
    func test_GivenPrevSearchWord_WhenUpdatePHotoList_ThenUpdateData(){
        
        //Given
        let expectedSearchData = photoListCreator.createMockData()
        searchPhotoListUseCaseMock.setMockData(expectedSearchData)
        let searchWord = "UNIT_TEST"
        presenter.searchTextFieldEndEdit(with: searchWord)
        presenter.photoListData = []
        
        //When
        
        presenter.updatePhotoList()
        
        //Then
        
        XCTAssertEqual(expectedSearchData,presenter.photoListData)
        
    }
    
    func test_WhenFetchPhotoListFromDetailPresenter_ThenReturnValidData(){
        
        //Given
        
        let expectedData = photoListCreator.createMockData()
        fetchDefaultPhotoListUseCaseMock.setMockData(expectedData)
        
        //When
        
        let returnedData = presenter.fetchPhotoListFromDetailPresetner()
        
        //Then
        
        XCTAssertEqual(expectedData, returnedData)
    }
    
    func test_WhenMovePhotoFocus_ThenChangeViewsFocusRow(){
        
        //Given
        
        let row = Int.random(in: 0..<100)
        
        //When
        
        presenter.movePhotoFocus(to: row)
        
        //Then
        
        XCTAssertEqual(row, viewMock.resultMoveSrollFocus)
        
    }
    
    func test_WhenDelegateViewWillAppear_ThenCallDelegateMethod(){
        
        //Given
        
        //When
        
        presenter.viewWillAppear()
        
        //Then
        
        XCTAssertTrue(viewMock.resultDetailViewWillAppear)
        
    }
    
    func test_WhenDelegateViewWillDisappear_ThenCallDelegateMethod(){
        
        //Given
        
        //When
        
        presenter.viewWillDisappear()
        
        //Then
        
        XCTAssertTrue(viewMock.resultDetailViewWillDisappear)
        
    }
    
    override func tearDown() {
        fetchPhotoImageUseCaseMock.reset()
        fetchDefaultPhotoListUseCaseMock.reset()
        searchPhotoListUseCaseMock.reset()
        routerMock.reset()
        viewMock.reset()
        cellMock.reset()
        
        presenter = nil
    }
}
