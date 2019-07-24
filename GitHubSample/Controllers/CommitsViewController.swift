//
//  CommitsViewController.swift
//  GitHubSample
//
//  Created by Anusha Kottiyal on 7/23/19.
//  Copyright © 2019 NextDigit. All rights reserved.
//

import UIKit

class CommitsViewController: UITableViewController {

    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    lazy var viewModel: CommitListViewModel = {
        return CommitListViewModel()
    }()
    
    private var user: String = ""
    private var repo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure View
        configureView()
        // Configure Commit List ViewModel
        configureViewModel()
    }
    func configureView() {
        // Update Title
        self.title = Constants.ViewTitle.commits.rawValue
        
        // Set up activity indicator
        self.setupActivityIndicator()
    }
    func configure(with user: String, repo: String) {
        self.user = user
        self.repo = repo
    }
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
    }
    
    func configureViewModel() {
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 0.3
                    })
                } else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        // Fetch all the commits
        viewModel.fetchCommits(user, repo: repo)
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Table view data source and Delegates
extension CommitsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommitCell", for: indexPath) as? CommitCell else { fatalError("Cell not designed")}
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.UI.commitRowHeight
    }
}
