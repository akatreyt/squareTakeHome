//
//  ViewController.swift
//  SquareTakeHome
//
//  Created by Trey Tartt on 4/20/21.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    fileprivate var viewModel: DashboardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "EmployeeCellTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeCell")

        viewModel = DashboardViewModel(dataFetchType: MockNetwork(), viewUpdater: { [self] in
            updateView()
        })
        
        // call to set the view initally
        updateView()
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        viewModel.getData()
    }
    
    private func updateView(){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch self.viewModel.currentViewType {
            case .loading:
                self.errorLabel.isHidden = true
                self.refreshButton.isHidden = true
                self.tableView.isHidden = true
                self.loadingSpinner.isHidden = false
                self.loadingSpinner.startAnimating()
            case .employees:
                self.errorLabel.isHidden = true
                self.refreshButton.isHidden = true
                self.tableView.isHidden = false
                self.loadingSpinner.isHidden = true
                self.tableView.reloadData()
            case .error(let errorString):
                self.errorLabel.text = errorString
                self.errorLabel.isHidden = false
                self.refreshButton.isHidden = false
                self.tableView.isHidden = true
                self.loadingSpinner.isHidden = true
            }
        }
    }
}

extension DashboardViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.employeeReturn?.employees.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell") as? EmployeeCellTableViewCell{
            if let employee = viewModel.employeeReturn?.employees[indexPath.row]{
                cell.set(employee: employee, imageCache: viewModel.imageCache)
            }
            return cell
        }else{
            fatalError()
        }
    }
}

