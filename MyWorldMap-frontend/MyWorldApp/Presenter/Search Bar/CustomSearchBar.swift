//
//  CustomSearchBar.swift
//  MergeWithSwiftUI
//
//  Created by 김서현 on 8/14/24.
//

import UIKit

class CustomSearchBar: UIView {
    
    // MARK: - Properties
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "도시 및 국가를 검색해 보세요."
        searchBar.layer.borderColor = UIColor(named: "Main")?.cgColor
        return searchBar
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        self.addSubview(searchBar)
        setupConstraints()
    }
    
    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
            
        })
    }
}

// MARK: - UISearchBarDelegate

extension CustomSearchBar: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.layer.borderWidth = searchBar.text == "" ? 0 : 1
    }
}
