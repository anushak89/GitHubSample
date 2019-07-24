//
//  CommitListViewModel.swift
//  GitHubSample
//
//  Created by Anusha Kottiyal on 7/24/19.
//  Copyright © 2019 NextDigit. All rights reserved.
//

import Foundation

class CommitListViewModel {
    
    // To fetch and manage commits
    let apiManager: APIManager
    
    // Closures to inform actions
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    // To hold all cell viewModels with relevant data
    private var cellViewModels = [CommitCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
    
    func fetchCommits(_ user: String, repo: String) {
        self.isLoading = true
        apiManager.fetchCommits(user, repo: repo) { [weak self] (success, commits, error) in
            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                self?.processFetchedCommitResponses(commits)
            }
        }
    }
    
    private func processFetchedCommitResponses(_ responses: [CommitResponse]) {
        var viewModels = [CommitCellViewModel]()
        for response in responses {
            viewModels.append(createCellViewModel(response))
        }
        self.cellViewModels = viewModels
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> CommitCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel(_ commitInfo: CommitResponse) -> CommitCellViewModel {
        return CommitCellViewModel(author: commitInfo.commit.author.name, hash: commitInfo.hash, message: commitInfo.commit.message)
    }
}
