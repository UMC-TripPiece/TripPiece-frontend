//
//  LogSearchResultView.swift
//  MyWorldApp
//
//  Created by 김나연 on 8/11/24.
//

import UIKit

class LogSearchResultsViewController: UIViewController {
    
    // 검색 결과를 담을 배열
    var searchItems: [LogSearchItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // 검색 결과를 보여줄 TableView
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    func updateSearchResults(_ searchItems: [LogSearchItem]) {
            self.searchItems = searchItems
            tableView.reloadData()
        }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension LogSearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        let item = searchItems[indexPath.row]
        cell.textLabel?.text = "\(item.cityName), \(item.countryName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = searchItems[indexPath.row]
        // 선택된 아이템 처리 로직
        print("Selected: \(selectedItem.cityName), \(selectedItem.countryName)")
        // 필요한 경우, 선택된 도시 데이터를 전달하거나 다른 액션을 수행
    }
}
