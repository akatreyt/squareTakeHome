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

    func testMockEmployeeData() throws {
        let expectation = self.expectation(description: "EmployeEndPoint")
        
        var didFail = false
        var errorDesc: String?
        
        let mockNewtork = MockNetwork()
        mockNewtork.retrieveEmployees(fromEndpoint: NetworkEndpoints.employees.url) { results in
            switch results{
            case .success(let employeeReturn):
                if employeeReturn.employees.count != 11 {
                    errorDesc = "number of employees returned is incorrect"
                    didFail = true
                }
            case .failure(let error):
                errorDesc = error.errorDescription
                didFail = true
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertTrue(didFail == false, "employee return failed with error \(errorDesc ?? "")")
    }
    
    func testMockEmployeeEmptyData() throws {
        let expectation = self.expectation(description: "EmployeEmptyEndPoint")
        
        var didFail = false
        var errorDesc: String?
        
        let mockNewtork = MockNetwork()
        mockNewtork.retrieveEmployees(fromEndpoint: NetworkEndpoints.emptyEmployees.url) { results in
            switch results{
            case .success(let employeeReturn):
                if employeeReturn.employees.count != 0 {
                    errorDesc = "number of employees returned is incorrect"
                    didFail = true
                }
            case .failure(let error):
                errorDesc = error.errorDescription
                didFail = true
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertTrue(didFail == false, "employee return failed with error \(errorDesc ?? "")")
    }
    
    func testMockEmployeeMalformedData() throws {
        let expectation = self.expectation(description: "EmployeMalformedEndPoint")
        
        var didFail = false
        var errorDesc: String?
        
        let mockNewtork = MockNetwork()
        mockNewtork.retrieveEmployees(fromEndpoint: NetworkEndpoints.malformedEmployees.url) { results in
            switch results{
            case .success:
                errorDesc = "succedded when it should have failed"
                didFail = true
            case .failure:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertTrue(didFail == false, "employee return failed with error \(errorDesc ?? "")")
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
