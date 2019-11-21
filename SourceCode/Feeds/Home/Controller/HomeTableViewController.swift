//
//  HomeTableViewController.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import UIKit

protocol HomeRefreshControlProtocol {
    func configureRefreshControl()
    func getLatestFeeds()
}

class HomeTableViewController: UIViewController {

    var viewModel = HomeViewModel.sharedInstance
    @IBOutlet weak var homeFeedsTableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureRefreshControl()
    }
    
    private func configureTableView() {
        homeFeedsTableView.estimatedRowHeight = 88
        homeFeedsTableView.tableFooterView = UIView()
        homeFeedsTableView.accessibilityIdentifier = "id_table_home"
        homeFeedsTableView.dataSource = self
        homeFeedsTableView.delegate = self
        homeFeedsTableView.reloadData()
    }
    
    func reloadTableView() {
        homeFeedsTableView.reloadData()
    }
}

// Table View Datasource and delegate methods
extension HomeTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNoOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.getViewModel(row: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: model.cellId.rawValue, for: indexPath as IndexPath) as? BaseTableViewCell ?? BaseTableViewCell()
        cell.configureUI(option: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HomeTableViewController: HomeRefreshControlProtocol {
    
    /// Used to configure refresh control
    func configureRefreshControl() {
        if #available(iOS 10.0, *) {
            homeFeedsTableView.refreshControl = refreshControl
        } else {
            homeFeedsTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(getLatestFeeds), for: .valueChanged)
        let magenta = UIColor(red: 226/255, green: 0/255, blue: 116/255, alpha: 1)
        refreshControl.tintColor = magenta
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching latest feeds ...")
    }
    
    /// when user did pull to refresh get latest feeds
    @objc func getLatestFeeds() {
        refreshControl.endRefreshing()
        viewModel.configureData()
    }
}
