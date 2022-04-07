//
//  ViewController.swift
//  TaiwanExhibitions
//
//  Created by Chuan-Jie Jhuang on 2022/3/16.
//

import UIKit

class ViewController: UIViewController {

    let kCellIdentifier = "Cell"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    let viewModel = TaiwanExhibitionsViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupData()
        self.setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.fetchAllExhibitions()
    }
    
    // MARK: - Private Method
    private func setupTableView() {
        tableView.register(UINib(nibName: "ExhibitionTableViewCell", bundle: nil), forCellReuseIdentifier: kCellIdentifier)
    }
    
    private func setupUI() {
        self.navigationItem.title = self.viewModel.navigationTitle
    }
    
    private func setupData() {
        self.viewModel.delegate = self
    }
    
    private func showLoadingView() {
        self.loadingView.isHidden = false
        self.view.bringSubviewToFront(self.loadingView)
    }
    
    private func hideLoadingView() {
        self.view.sendSubviewToBack(self.loadingView)
        self.loadingView.isHidden = true
    }
}

// MARK: - Table view data source
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.allExhibitions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! ExhibitionTableViewCell
        if let model = self.viewModel.allExhibitions?[indexPath.row] {
            cell.titleLabel.text = model.title
            cell.locationLabel.text = model.showUnit
            cell.dateLabel.text = model.startDate
        }
        return cell
    }
}

// MARK: - Table view delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = ExhibitionDetailTableViewController()
        let detailViewModel = ExhibitionDetailViewModel(exhibition: (self.viewModel.allExhibitions?[indexPath.row])!)
        detailViewController.viewModel = detailViewModel
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - TaiwanExhibitionsViewModel delegate
extension ViewController: TaiwanExhibitionsViewModelDelegate {
    func allExhibitionsAPIFetching() {
        self.showLoadingView()
    }
    
    func allExhibitionsAPIFetchSuccess() {
        self.hideLoadingView()
        self.tableView.reloadData()
    }
    
    func allExhibitionsAPIFetchFailure(error: Error) {
        self.hideLoadingView()
    }
}
