//
//  ContentTableViewCell.swift
//  ContentParser
//
//  Created by Subeesh on 01/04/20.
//  Copyright © 2020 qburst. All rights reserved.
//

import UIKit
import Kingfisher

class ContentTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "ContentTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var content: ContentDetail? {
        didSet {
            titleLabel.text = content?.title
            descriptionLabel.text = content?.description
            
            if let imageUrlString = content?.imageUrlString, !imageUrlString.isEmpty {
                contentImageView.kf.indicatorType = .activity
                contentImageView.kf.setImage(with: URL(string: imageUrlString))
            }
        }
    }
    
    /// Name Label
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    
    /// Description Label
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()

    
    /// Imageview to add content image
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    /// Method to configure the cell view
    private func configureView() {
        
        self.addSubview(contentImageView)
        
        // Add constraints to imageview
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        contentImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        contentImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0).isActive = true
        contentImageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        contentImageView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        contentImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10.0).isActive = true

        
        // Create a stack view and add labels to it
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        self.addSubview(stackView)
        
        // Add constraints to stackview
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: 10.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0).isActive = true
    }
}
