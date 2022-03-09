//
//  ViewController.swift
//  CombineExample
//
//  Created by UW-IN-LPT0108 on 2/5/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
   var viewModel = PostViewModel()
    var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.delegate = self
        
        viewModel.getHomeData()
        print(viewModel.posts)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.titleLable.text = posts[indexPath.row].title
        return cell
    }
}

extension ViewController: PostViewModelDelegate {
    func updateUI() {
        posts = viewModel.posts
        tableView.reloadData()
    }
}

