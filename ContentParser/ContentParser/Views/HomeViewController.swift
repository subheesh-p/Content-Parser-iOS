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
    }
    

    private func configureView() {
        
        // Set view background colour
        view.backgroundColor = UIColor.white
        
        // Configure tableView
        contentTableView = UITableView()
        view.addSubview(contentTableView)
        
        // Add constraints for content tableview
        contentTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.topAnchor.constraint(equalTo: contentTableView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentTableView.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: contentTableView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentTableView.trailingAnchor).isActive = true
        
        // Fetch data from server
        viewModel.fetchData {
            
        }
    }

}

