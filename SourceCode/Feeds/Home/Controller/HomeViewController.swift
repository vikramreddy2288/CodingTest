//
//  ViewController.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel = HomeViewModel.sharedInstance
    var loadingViewController : HomeLoadingViewController?
    var tableViewController : HomeTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.configureData()
        if let loadingViewController = getLoadingViewController() {
            add(loadingViewController)
            loadingViewController.startShimmering(title: "Welcome, Fetching Feeds...")
            self.loadingViewController = loadingViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Feeds"
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = UIColor.white
        let magenta = UIColor(red: 226/255, green: 0/255, blue: 116/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: magenta]
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func getLoadingViewController() -> HomeLoadingViewController? {
        let storyBoard = UIStoryboard(name: "Home", bundle: Bundle.main)
        let viewController = storyBoard.instantiateViewController(identifier: "HomeLoadingViewController") as? HomeLoadingViewController
        return viewController
    }
    
    func getHomeTableViewController() -> HomeTableViewController? {
        let storyBoard = UIStoryboard(name: "Home", bundle: Bundle.main)
        let viewController = storyBoard.instantiateViewController(identifier: "HomeTableViewController") as? HomeTableViewController
        return viewController
    }
}

extension HomeViewController: HomeViewModelDelegate {
    
    func reloadView(tableOptions: [TableOption]) {
        if tableOptions.count == 0 {
            loadErrorScreen()
        } else {
            loadTableView()
        }
    }

    func loadTableView() {
        if let tableViewController = tableViewController {
            tableViewController.reloadTableView()
        } else {
            if let tableViewController = getHomeTableViewController() {
                add(tableViewController)
                self.tableViewController  = tableViewController
            }
        }
        loadingViewController?.remove()
        loadingViewController = nil
    }
    
    func loadErrorScreen() {
        if let loadingViewController = loadingViewController {
            loadingViewController.stopShimmering()
            loadingViewController.showErrorMessage(getErrorMessage())
        } else {
            if let loadingViewController = getLoadingViewController() {
                add(loadingViewController)
                self.loadingViewController = loadingViewController
            }
        }
        tableViewController?.remove()
        tableViewController = nil
    }
    
    func getErrorMessage() -> String {
        if Reachability()?.connection == Reachability.Connection.none {
            return "Appears to be offline, please check your network"
        }
        return "OOPs, Something went wrong. Try after some time"
    }
}
