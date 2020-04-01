//
//  HomeViewController.swift
//  ContentParser
//
//  Created by Subeesh on 01/04/20.
//  Copyright © 2020 qburst. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Table view that shows the whole content
    var contentTableView: UITableView!
    
    // View model for home screen
    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchData()
    }
    

    private func configureView() {
        
        // Set view background colour
        view.backgroundColor = UIColor.white
        
        // Configure tableView
        contentTableView = UITableView()
        contentTableView.register(ContentTableViewCell.self, forCellReuseIdentifier: ContentTableViewCell.cellIdentifier)
        contentTableView.estimatedRowHeight = 100.0
        contentTableView.rowHeight = UITableView.automaticDimension
        contentTableView.dataSource = self
        view.addSubview(contentTableView)
        
        // Add constraints for content tableview
        contentTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.topAnchor.constraint(equalTo: contentTableView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentTableView.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: contentTableView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentTableView.trailingAnchor).isActive = true
    }
    
    
    /// Method to fetch data from server
    private func fetchData() {
        
        // Fetch data from server
        viewModel.fetchData { (errorString) in
            
            DispatchQueue.main.async {
                // Check if any error exist. If yes, then show alert
                if let error = errorString {
                    self.showErrorAlert(with: error)
                } else {
                    self.title = self.viewModel.screenTitle
                    self.contentTableView.reloadData()
                }
            }
            
        }
    }
    
    /// Method to show alert
    /// - Parameter error: Error message to be shown in the alert
    private func showErrorAlert(with error: String) {
        let alert = UIAlertController(title: "ALERT", message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }

}


// MARK:- UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.cellIdentifier, for: indexPath) as? ContentTableViewCell {
            cell.content = viewModel.dataArray[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
}


