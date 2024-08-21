//
//  CustomSearchBar.swift
//  MergeWithSwiftUI
//
//  Created by 김서현 on 8/14/24.
//

import UIKit

class CustomSearchBar: UIViewController {
    
    // MARK: - Properties
    
    var onTextDidChange: ((String) -> Void)? // 텍스트 변경 시 호출될 클로저
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "도시 및 국가를 검색해 보세요."
        return searchBar
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.addSubview(searchBar)
        setupConstraints()
    }
    
    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - UISearchBarDelegate

extension CustomSearchBar: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        onTextDidChange?(searchText) // 텍스트가 변경될 때 클로저 호출
    }
}
