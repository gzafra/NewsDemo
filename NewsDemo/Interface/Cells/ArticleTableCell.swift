//
//  ArticleTableCell.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import UIKit

class ArticleTableCell: UITableViewCell {
    static let identifier = "ArticleTableCell"
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    
    var viewModel: ArticleViewModel?
    
    func setup(with article: ArticleViewModel) {
        self.viewModel = article
        
        bindViewModel()
    }

    func bindViewModel() {
        thumbnailImage.image = nil
        
        guard let viewModel = viewModel else {
            print("Invalid ViewModel")
                return
        }
        headlineLabel.text = viewModel.headline
        if let image = viewModel.thumbnailImage?.image {
            thumbnailImage.image = image
        }
    }
    
    func beginThumbnailLoad() {
        viewModel?.thumbnailImage?.beginThumbnailRequest(with: { (image) in
            self.thumbnailImage.image = image
        })
    }
    
    func cancelThumbnailLoad() {
        viewModel?.thumbnailImage?.cancelThumbnailRequest()
    }
}
