//
//  LoginViewController.swift
//  GitHubSample
//
//  Created by Anusha Kottiyal on 7/23/19.
//  Copyright © 2019 NextDigit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fetchCommits()
    }
    
    func fetchCommits() {
        
        guard let url = URL(string: Constants.API.baseURL) else { return }
        DispatchQueue.global(qos: .background).async {
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = session.dataTask(with: request) { data, response, error in
                guard let jsonData = data else { return }
                do {
                    let reqJSONStr = String(data: jsonData, encoding: .utf8)
                    print(reqJSONStr ?? "No Data")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmailCell", for: indexPath) as? UITableViewCell else { fatalError("Cell not designed")}
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.UI.loginFieldsRowHeight
    }
}
