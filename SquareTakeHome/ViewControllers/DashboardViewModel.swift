//
//  DashboardViewModel.swift
//  SquareTakeHome
//
//  Created by Trey Tartt on 4/20/21.
//

import Foundation

public final class DashboardViewModel{
    private var dataFetcher: DataFetchable!
    private var viewUpdater: (() -> Void)!
    
    private(set) public var employeeReturn: EmployeeReturn?
    
    private(set) public var currentViewType: DashboardViewType{
        didSet{
            viewUpdater()
        }
    }
    
    public enum DashboardViewConstants: String{
        case emptyEmployee = "There are no employees to view"
        case firstLaunch = "No data, tap refresh to fetch"
        case uknownError = "Uknown Error"
    }
    
    public enum DashboardViewType{
        case loading
        case employees
        case error(String)
    }
    
    init(dataFetchType: DataFetchable, viewUpdater: @escaping (() -> Void)) {
        self.dataFetcher = dataFetchType
        self.viewUpdater = viewUpdater
        self.currentViewType = .error(DashboardViewConstants.firstLaunch.rawValue)
    }

    public func getData(endpoint: NetworkEndpoints = .employees){
        self.currentViewType = .loading
        self.employeeReturn = nil
        dataFetcher.retrieveEmployees(fromEndpoint: endpoint.url) { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let employeeReturnData):
                if employeeReturnData.employees.count == 0{
                    self.currentViewType = .error(DashboardViewConstants.emptyEmployee.rawValue)
                }else{
                    self.employeeReturn = employeeReturnData
                    self.currentViewType = .employees
                }
            case .failure(let error):
                self.currentViewType = .error(error.errorDescription ?? DashboardViewConstants.uknownError.rawValue)
            }
        }
    }
}
