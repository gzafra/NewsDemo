//
//  DetailViewController.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var showFullArticleButton: UIButton!
    @IBOutlet weak var creationDateLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: ArticleViewModel!
    var articleUrl: URL!
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bindViewMode()
    }

    func setup(with articleViewModel: ArticleViewModel) {
        self.viewModel = articleViewModel
    }
    
    func bindViewMode() {
        if let imageUrl = viewModel.image?.urlString,
            let url = URL(string: imageUrl) {
            mainImage.af_setImage(withURL: url)
        }
        titleLabel.text = viewModel.headline
        creationDateLabel.text = viewModel.creationDate
        authorLabel.text = viewModel.author
        descriptionTextView.text = viewModel.description
        
        guard let url = URL(string: viewModel.articleUrl) else {
            showFullArticleButton.isHidden = true
            return
        }
        articleUrl = url
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let fullArticleViewController = segue.destination as! FullArticleViewController

        fullArticleViewController.setup(with: articleUrl)
    }

}
