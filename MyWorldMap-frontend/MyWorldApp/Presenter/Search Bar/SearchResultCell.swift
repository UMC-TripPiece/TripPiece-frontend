//
//  SearchResultCell.swift
//  MyWorldApp
//
//  Created by 김서현 on 8/22/24.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    static let identifier = "SearchResultCell"
        
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "arrowImage")
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellLabel)
        contentView.addSubview(arrowImageView)
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            arrowImageView.widthAnchor.constraint(equalToConstant: 5),
            arrowImageView.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(cityName: String, countryName: String, countryImage: String) {
        cellLabel.text = "\(countryImage)  \(cityName), \(countryName)"
    }
}

