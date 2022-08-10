//
//  SearchAppInteractorTests.swift
//  AppSearcherTests
//
//  Created by Doyoung on 2022/08/06.
//

import XCTest
@testable import AppSearcher

class SearchAppInteractorTests: XCTestCase {
    //MARK: - System under test
    var sut: SearchAppInteractor!
    var searchAppPresenterSpy: SearchAppPresenterSpy!
    var searchedAppWorkerSpy: SearchedAppWorkerSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        searchAppPresenterSpy = SearchAppPresenterSpy()
        searchedAppWorkerSpy = SearchedAppWorkerSpy(networkService: NetworkService(configuration: NetworkConfiguration(baseURL: URL(string: "https://mock.test.com")!)))
        sut = SearchAppInteractor()
    }
    override func tearDownWithError() throws {
        sut = nil
        searchedAppWorkerSpy = nil
        searchAppPresenterSpy = nil
        try super.tearDownWithError()
    }
    //MARK: - Test doubles
    class SearchAppPresenterSpy: SearchAppPresentionLogic {
        
        var presentFindSearchedAppCalled = false
        var presentFailedSearchedAppCalled = false
        var presentUnexpectedNetworkErrorCalled = false
        
        func presentFindSearchedApp() {
            presentFindSearchedAppCalled = true
        }
        func presentFailedSearchedApp() {
            presentFailedSearchedAppCalled = true
        }
        
        func presentUnexpectedNetworkError() {
            presentUnexpectedNetworkErrorCalled = true
        }
    }
    
    class SearchedAppWorkerSpy: SearchedAppWorker {
        var fetchCalled = false
        var isSuccessFetch = false
        var results: [SearchedApp.Response]!
        var error: NetworkError?
        
        override func fetchSearchedApps(with id: String, completion: @escaping SearchedAppWorker.CompletionHandler) {
            fetchCalled = true
            isSuccessFetch ? completion(.success(FetchSearchedApps.Response(results: results))) : completion(.failure(NetworkError.noResponse))
        }
    }
    //MARK: - Tests
    func test_searchAppIsSuccess_shouldBeAskWorkerAndPresentFindSearchedAppCalledInPresenter() {
        //given
        sut.searchedAppWorker = searchedAppWorkerSpy
        sut.presenter = searchAppPresenterSpy
        searchedAppWorkerSpy.results = [Seeds.SearchedAppDummy.app]
        searchedAppWorkerSpy.isSuccessFetch = true
        //when
        sut.searchApp(with: "")
        //then
        XCTAssert(searchedAppWorkerSpy.fetchCalled)
        XCTAssert(searchAppPresenterSpy.presentFindSearchedAppCalled)
    }
    func test_seachAppIsSuccess_shouldBeAskWorkerAndCalledPresentInPresenter_whenResultIsempty() {
        //given
        sut.searchedAppWorker = searchedAppWorkerSpy
        sut.presenter = searchAppPresenterSpy
        searchedAppWorkerSpy.results = []
        searchedAppWorkerSpy.isSuccessFetch = true
        //when
        sut.searchApp(with: "")
        //then
        XCTAssert(searchedAppWorkerSpy.fetchCalled)
        XCTAssert(searchAppPresenterSpy.presentFailedSearchedAppCalled)
    }
    func test_searchAppIsFailedByError_shouldBeAskWorkerAndCalledPresentUnexpectedNetworkError_whenResultIsempty() {
        //given
        sut.searchedAppWorker = searchedAppWorkerSpy
        sut.presenter = searchAppPresenterSpy
        searchedAppWorkerSpy.isSuccessFetch = false
        //when
        sut.searchApp(with: "")
        //then
        XCTAssert(searchedAppWorkerSpy.fetchCalled)
        XCTAssert(searchAppPresenterSpy.presentUnexpectedNetworkErrorCalled)
    }
}
