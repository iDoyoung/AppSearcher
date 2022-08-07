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
        sut = SearchAppInteractor(searchedAppWorker: searchedAppWorkerSpy,
                                  presenter: searchAppPresenterSpy)
    }
    override func tearDownWithError() throws {
        sut = nil
        searchedAppWorkerSpy = nil
        searchAppPresenterSpy = nil
        try super.tearDownWithError()
    }
    //MARK: - Test doubles
    class SearchAppPresenterSpy: SearchAppPresentionLogic {
        var presentCalled = false
        func presentFindSearchedApp() {
            presentCalled = true
        }
    }
    
    class SearchedAppWorkerSpy: SearchedAppWorker {
        var fetchCalled = false
        var isSuccessFetch = false
        var error: NetworkError?
        
        override func fetchSearchedApps(with id: String, completion: @escaping SearchedAppWorker.CompletionHandler) {
            fetchCalled = true
            isSuccessFetch ? completion(.success(FetchSearchedApps.Response(results: []))) : completion(.failure(error!))
        }
    }
    //MARK: - Tests
    func test_searchAppIsSuccess_shouldBeAskWorkerAndCalledPresentInPresenter() {
        //given
        searchedAppWorkerSpy.isSuccessFetch = true
        //when
        sut.searchApp(with: "")
        //then
        XCTAssert(searchedAppWorkerSpy.fetchCalled)
        XCTAssert(searchAppPresenterSpy.presentCalled)
    }
}
