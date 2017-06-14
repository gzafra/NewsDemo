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
    
    func setup(with article: ArticleViewModel) {
        headlineLabel.text = article.headline
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
