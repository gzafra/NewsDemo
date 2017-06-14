//
//  TopStoriesViewController.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import UIKit

class TopStoriesViewController: UITableViewController {

    var viewModels: [ArticleViewModel] = [
        ArticleViewModel(headline: "Article 1"),
        ArticleViewModel(headline: "Article 2"),
        ArticleViewModel(headline: "Article 3"),
        ArticleViewModel(headline: "Article 4"),
        ArticleViewModel(headline: "Article 5"),
        ArticleViewModel(headline: "Article 6")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataManager = DataManager()
        dataManager.fetchTopStories(resultBlock: { (articles) in
            for article in articles {
                let viewModel = ArticleViewModel(with: article)
                self.viewModels.append(viewModel)
            }
            
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
