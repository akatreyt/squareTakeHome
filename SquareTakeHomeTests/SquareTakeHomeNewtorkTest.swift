//
//  SquareTakeHomeNewtorkTest.swift
//  SquareTakeHomeTests
//
//  Created by Trey Tartt on 4/20/21.
//

import XCTest

class SquareTakeHomeNewtorkTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMockData() throws {
        let mockNewtork = MockNetwork()
        mockNewtork.retrieveEmployees(fromEndpoint: NetworkEndpoints.employees.url) { results in
            switch results{
            case .success(let employeeReturn):
                XCTAssert(employeeReturn.employees.count == 11, "Number of employees was incorrect")
            case .failure(let error):
                XCTFail("employee return failed with error \(error)")
            }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
