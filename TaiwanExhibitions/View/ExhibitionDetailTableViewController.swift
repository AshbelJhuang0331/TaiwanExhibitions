//
//  ExhibitionDetailTableViewController.swift
//  TaiwanExhibitions
//
//  Created by Chuan-Jie Jhuang on 2022/3/16.
//

import UIKit

class ExhibitionDetailTableViewController: UITableViewController {
    
    var viewModel: ExhibitionDetailViewModel?
    private let kCellIdentifier = "Cell"
    private let kShowItemCount = 4
    private enum RowItem: Int {
        case title = 0
        case location = 1
        case price = 2
        case duration = 3
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupUI()
    }

    // MARK: Private method
    
    private func setupTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
    }
    
    private func setupUI() {
        self.navigationItem.title = self.viewModel?.navigationTitle
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return kShowItemCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath)
        let rowItem = RowItem(rawValue: indexPath.row)
        let exhibition = self.viewModel?.exhibition
        switch rowItem {
        case .title:
            cell.textLabel?.text = exhibition?.title
        case .location:
            cell.textLabel?.text = "地點: \(exhibition?.showInfo.last?.location ?? "")"
        case .price:
            cell.textLabel?.text = "價格: \(exhibition?.showInfo.last?.price ?? "")"
        case .duration:
            cell.textLabel?.text = "展期: \((exhibition?.startDate ?? "") + " ~ " + (exhibition?.endDate ?? ""))"
        default:
            break;
        }
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
