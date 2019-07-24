//
//  LoginViewController.swift
//  GitHubSample
//
//  Created by Anusha Kottiyal on 7/23/19.
//  Copyright © 2019 NextDigit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    private var user = "anushak89"
    private var repo = "GitHubSample"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func fetchCommits() {
        let endPoint = String(format: Constants.API.endPoint.commits.rawValue, user, repo)
        let urlString = Constants.API.baseURL + endPoint
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global(qos: .background).async {
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = session.dataTask(with: request) { data, response, error in
                guard let jsonData = data else { return }
                do {
                    // Decode data to object
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode([CommitResponse].self, from:
                        jsonData)
                    print(result)
                } catch {
                    print("Error")
                }
            }
            task.resume()
        }
    }
}

// MARK: - Table view data source and Delegates
extension LoginViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? TextFieldCell else { fatalError("Cell not designed")}
            cell.fieldType = .user
            cell.delegate = self
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as? TextFieldCell else { fatalError("Cell not designed")}
            cell.fieldType = .repo
            cell.delegate = self
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoginCell", for: indexPath) as? ButtonCell else { fatalError("Cell not designed")}
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.UI.loginFieldsRowHeight
    }
}

// MARK: - Handle Button Cell Delegate Method
extension LoginViewController: ButtonCellDeleagte {
    func didPressExploreButton(_ cell: ButtonCell) {
        if isValidCredentials() {
            
            let commitsViewController = self.storyboard?.instantiateViewController(withIdentifier: "CommitsViewController") as! CommitsViewController
            commitsViewController.configure(with: user, repo: repo)
            let navigationControler = UINavigationController(rootViewController: commitsViewController)
            self.present(navigationControler, animated: true, completion: nil)
        } else {
            // Show Error
            
        }
    }
}

// MARK: - Handle TextField Cell Delegate Methods
extension LoginViewController: TextFieldCellDeleagte {
    func textFieldCell(_ cell: TextFieldCell, didEnterText text: String) {
        if cell.fieldType == .user {
            user = text
        } else {
            repo = text
        }
    }
}

extension LoginViewController {
    func isValidCredentials() -> Bool {
        return user.count > 0 && repo.count > 0
    }
}
