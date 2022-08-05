//
//  NetworkServiceTests.swift
//  AppSearcherTests
//
//  Created by Doyoung on 2022/08/05.
//

import XCTest
@testable import AppSearcher

class NetworkServiceTests: XCTestCase {
    //MARK: - System under test
    var sut: NetworkService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    //MARK: - Test doubels
    struct MockModel: Decodable {
        let name: String
    }
    
    enum ErrorMock: Error {
        case someError
    }

    struct NetworkSessionManagerMock: NetworkSessionManager {
        let data: Data?
        let response: HTTPURLResponse?
        let error: Error?
        
        func request(_ request: URLRequest, completion: @escaping CompletionHandler) {
            completion(data, response, error)
        }
    }
    //MARK: - Tests
    func test_requestJustResponse_whenReceivedVaildJSONResponse_shouldBeSuccess() {
        //given
        let promise = expectation(description: "Should decode mock data")
        let configuration = NetworkConfiguration(baseURL: URL(string: "https://mock.test.com")!)
        let sessionManager = NetworkSessionManagerMock(data: nil, response: nil, error: nil)
        //when
        sut = NetworkService(configuration: configuration, sessionManager: sessionManager)
        sut.request(with: Endpoint(path: "https://mock.endpoind.com")) { result in
            switch result {
            case .success:
                promise.fulfill()
            case .failure:
                XCTFail()
            }
        }
        //then
        wait(for: [promise], timeout: 1)
    }
    func test_reqeustDecodeResponse_whenReceivedVaildJSONResponse_shouldBeSuccessDecode() {
        //given
        let responseData = #"{"name": "MockData"}"#.data(using: .utf8)
        let promise = expectation(description: "Should decode mock data")
        let configuration = NetworkConfiguration(baseURL: URL(string: "https://mock.test.com")!)
        let sessionManager = NetworkSessionManagerMock(data: responseData,
                                                       response: nil,
                                                       error: nil)
        //when
        sut = NetworkService(configuration: configuration, sessionManager: sessionManager)
        sut.request(with: Endpoint<MockModel>(path: "https://mock.endpoind.com")) { result in
            do {
                let object = try result.get()
                XCTAssertEqual(object.name, "MockData")
                promise.fulfill()
            } catch {
                XCTFail()
            }
        }
        //then
        wait(for: [promise], timeout: 1)
    }
    func test_requestDecodeResponse_whenReceivedInvalidResponse_shouldBeParsingError() {
        //given
        let responseData = #"{"title": "MockData"}"#.data(using: .utf8)
        let promise = expectation(description: "Should be Parsing error")
        let configuration = NetworkConfiguration(baseURL: URL(string: "https://mock.test.com")!)
        let sessionManager = NetworkSessionManagerMock(data: responseData,
                                                       response: nil,
                                                       error: nil)
        //when
        sut = NetworkService(configuration: configuration, sessionManager: sessionManager)
        sut.request(with: Endpoint<MockModel>(path: "https://mock.endpoind.com")) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                if case NetworkError.parsing = error {
                    promise.fulfill()
                }
            }
        }
        //then
        wait(for: [promise], timeout: 1)
    }
    func test_request_whenReceivedBadRequest_shouldBeErrorWithStatusCode() {
        //given
        let promise = expectation(description: "Should be error")
        let configuration = NetworkConfiguration(baseURL: URL(string: "https://mock.test.com")!)
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 500,
                                       httpVersion: "1.1",
                                       headerFields: nil)
        let sessionManger = NetworkSessionManagerMock(data: nil,
                                                      response: response,
                                                      error: ErrorMock.someError)
        //when
        sut = NetworkService(configuration: configuration,
                             sessionManager: sessionManger)
        sut.request(with: Endpoint<MockModel>(path: "https://mock.endpoind.com")) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                if case NetworkError.error(let statusCode, _) = error {
                    XCTAssertEqual(statusCode, 500)
                    promise.fulfill()
                } else {
                    XCTFail()
                }
            }
        }
        //then
        wait(for: [promise], timeout: 1)
    }
    func test_request_whenDoNotReceiveResponse_shouldBeNoReponseError() {
        //given
        let promise = expectation(description: "Should be No response error")
        let configuration = NetworkConfiguration(baseURL: URL(string: "https://mock.test.com")!)
        let sessionManager = NetworkSessionManagerMock(data: nil,
                                                       response: nil,
                                                       error: ErrorMock.someError)
        //when
        sut = NetworkService(configuration: configuration, sessionManager: sessionManager)
        sut.request(with: Endpoint<MockModel>(path: "https://mock.endpoind.com")) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                if case NetworkError.noResponse = error {
                    promise.fulfill()
                } else {
                    XCTFail()
                }
            }
        }
        //then
        wait(for: [promise], timeout: 1)
    }
    func test_requestDecodeResponse_whenReceiveEmptyData_shouldBeNoReponseError() {
        //given
        let promise = expectation(description: "Should be No response error")
        let configuration = NetworkConfiguration(baseURL: URL(string: "https://mock.test.com")!)
        let sessionManager = NetworkSessionManagerMock(data: nil,
                                                       response: nil,
                                                       error: nil)
        //when
        sut = NetworkService(configuration: configuration, sessionManager: sessionManager)
        sut.request(with: Endpoint<MockModel>(path: "https://mock.endpoind.com")) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                if case NetworkError.noResponse = error {
                    promise.fulfill()
                } else {
                    XCTFail()
                }
            }
        }
        //then
        wait(for: [promise], timeout: 1)
    }
}
