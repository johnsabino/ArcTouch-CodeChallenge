//
//  NetworkServiceTests.swift
//  WordQuizTests
//
//  Created by João Paulo de Oliveira Sabino on 14/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import XCTest
@testable import WordQuiz
class NetworkServiceTests: XCTestCase {

    var apiProvider: APIProvider<Quiz>!
    override func setUp() {
        apiProvider = APIProvider<Quiz>()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        apiProvider = nil
    }

    func testRequest_success() {
        let expectation = XCTestExpectation(description: "Success on request")
        apiProvider.request(EndPoint.getQuiz(id: 1)) { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("The request should be succeeded")
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testRequest_failure() {
        let expectation = XCTestExpectation(description: "Failure on request")
        apiProvider.request(EndPoint.getQuiz(id: -1)) { result in
            switch result {
            case .success:
                XCTFail("The request should fail")
            case .failure:
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
}
