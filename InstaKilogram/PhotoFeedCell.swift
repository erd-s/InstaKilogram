//
//  PhotoFeedCell.swift
//  InstaKilogram
//
//  Created by Christopher Erdos on 2/5/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit

class PhotoFeedCell: UITableViewCell {

    

    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var geoLocationLabel: UILabel!
    
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var likeCountLabel: UILabel!
    @IBOutlet weak var captionTextView: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
