//
//  SquareTakeHomeDashboardViewModelTest.swift
//  SquareTakeHomeTests
//
//  Created by Trey Tartt on 4/20/21.
//

import XCTest

class SquareTakeHomeDashboardViewModelTest: XCTestCase {

    var viewModel: DashboardViewModel!
    var viewUpdateIteration = 0

    override func setUpWithError() throws {
       
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmployeeMock() throws {
        viewUpdateIteration = 0
        viewModel = DashboardViewModel(dataFetchType: MockNetwork(),
                                       viewUpdater: {
                                        self.employeeMockViewUpdater()
                                       })
        
        viewModel.getData()
    }
    
    private func employeeMockViewUpdater(){
        if viewUpdateIteration == 0 {
            switch viewModel.currentViewType{
            case .loading:
                break
            case .employees:
                XCTFail("current view type is incorrect")
            case .error(_):
                XCTFail("current view type is incorrect")
            }
        }else{
            switch viewModel.currentViewType{
            case .loading:
                XCTFail("current view type is incorrect")
            case .employees:
               break
            case .error(_):
                XCTFail("current view type is incorrect")
            }
        }
        viewUpdateIteration = viewUpdateIteration + 1
    }
    
    func testEmployeeMalformedMock() throws {
        viewUpdateIteration = 0
        viewModel = DashboardViewModel(dataFetchType: MockNetwork(),
                                       viewUpdater: {
                                        self.employeeMalformedMockViewUpdater()
                                       })
        
        viewModel.getData(endpoint: NetworkEndpoints.malformedEmployees)
    }
    
    private func employeeMalformedMockViewUpdater(){
        if viewUpdateIteration == 0 {
            switch viewModel.currentViewType{
            case .loading:
                break
            case .employees:
                XCTFail("current view type is incorrect")
            case .error(_):
                XCTFail("current view type is incorrect")
            }
        }else{
            switch viewModel.currentViewType{
            case .loading:
                XCTFail("current view type is incorrect")
            case .employees:
                XCTFail("current view type is incorrect")
            case .error(_):
                break
            }
        }
        viewUpdateIteration = viewUpdateIteration + 1
    }
    
    func testEmployeeEmptydMock() throws {
        viewUpdateIteration = 0
        viewModel = DashboardViewModel(dataFetchType: MockNetwork(),
                                       viewUpdater: {
                                        self.employeeEmptyMockViewUpdater()
                                       })
                
        viewModel.getData(endpoint: NetworkEndpoints.emptyEmployees)
    }
    
    private func employeeEmptyMockViewUpdater(){
        if viewUpdateIteration == 0 {
            switch viewModel.currentViewType{
            case .loading:
                break
            case .employees:
                XCTFail("current view type is incorrect")
            case .error(_):
                XCTFail("current view type is incorrect")
            }
        }else{
            switch viewModel.currentViewType{
            case .loading:
                XCTFail("current view type is incorrect")
            case .employees:
                XCTFail("current view type is incorrect")
            case .error(let error):
                XCTAssertTrue(error == DashboardViewModel.DashboardViewConstants.emptyEmployee.rawValue, "error string is not DashboardViewModel.DashboardViewConstants.emptyEmployee" )
            }
        }
        viewUpdateIteration = viewUpdateIteration + 1
    }
}
