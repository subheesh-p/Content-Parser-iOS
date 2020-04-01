//
//  HomeViewController.swift
//  ContentParser
//
//  Created by Subeesh on 01/04/20.
//  Copyright © 2020 qburst. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    /// Table view that shows the whole content
    var contentTableView: UITableView!
    
    /// View model for home screen
    var viewModel = HomeViewModel()
    
    /// Activity indicator
    var activityIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchData()
    }
    
    /// Method to configure the UI
    private func configureView() {
        
        // Set view background colour
        view.backgroundColor = UIColor.white
        
        // Configure tableView
        contentTableView = UITableView()
        contentTableView.register(ContentTableViewCell.self, forCellReuseIdentifier: ContentTableViewCell.cellIdentifier)
        contentTableView.estimatedRowHeight = 100.0
        contentTableView.rowHeight = UITableView.automaticDimension
        contentTableView.dataSource = self
        contentTableView.tableFooterView = UIView(frame: CGRect.zero)
        view.addSubview(contentTableView)
        
        // Add constraints for content tableview
        contentTableView.translatesAutoresizingMaskIntoConstraints = false
                
        contentTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        contentTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        contentTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        contentTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    
    /// Method to fetch data from server
    private func fetchData() {
        
        // Show activity indicator
        showActivityIndicator()
        
        // Fetch data from server
        viewModel.fetchData { (errorString) in
            
            DispatchQueue.main.async {
                
                // Dismiss activityIndicator
                self.dismissActivityIndicator()
                
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
    
    /// Show activity indicator
    private func showActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(frame: view.bounds)
        activityIndicatorView.style = .gray
        view.addSubview(activityIndicatorView)
        
        // Add constraints for activity indicator
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicatorView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        activityIndicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        activityIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        activityIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // Start animating the activity indicator
        activityIndicatorView.startAnimating()
        activityIndicator = activityIndicatorView
    }
    
    /// Dismiss activity indicator
    private func dismissActivityIndicator() {
        if let activityIndicator = activityIndicator {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
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
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
}


