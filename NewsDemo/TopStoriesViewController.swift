//
//  TopStoriesViewController.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import UIKit

class TopStoriesViewController: UITableViewController {

    var viewModels = [ArticleViewModel]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadInitialData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.refreshControl?.beginRefreshing()
        reloadData()
    }
    
    func loadInitialData() {
        // Load initial data from offline storage
        for article in DataManager.shared.cachedTopStories() {
            let viewModel = ArticleViewModel(with: article)
            self.viewModels.append(viewModel)
        }
    }
    
    func reloadData() {
        self.viewModels.removeAll()
        
        DataManager.shared.fetchTopStories(resultBlock: { (articles) in
            for article in articles {
                let viewModel = ArticleViewModel(with: article)
                self.viewModels.append(viewModel)
            }
            
            self.tableView.reloadData()
            self.loadImageForVisibleCells()
            self.refreshControl?.endRefreshing()
        }) { (error) in
            print("Error fetching articles")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableCell.identifier, for: indexPath) as? ArticleTableCell else {
            return UITableViewCell()
        }
        
        cell.setup(with: viewModels[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! ArticleTableCell).cancelThumbnailLoad()
    }
    
    @IBAction func handleRefresh(_ sender: UIRefreshControl) {
        reloadData()
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImageForVisibleCells()
    }
    
    func loadImageForVisibleCells() {
        for case let cell as ArticleTableCell in tableView.visibleCells {
            cell.beginThumbnailLoad()
        }
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemDetailViewController = segue.destination as! DetailViewController
        guard let cell = sender as? ArticleTableCell, let viewModel = cell.viewModel else {
            return
        }
        itemDetailViewController.setup(with: viewModel)
    }

}
