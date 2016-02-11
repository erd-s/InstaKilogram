//
//  PhotoFeedCell.swift
//  InstaKilogram
//
//  Created by Christopher Erdos on 2/5/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit

protocol CommentButtonTappedDelegate {
    
    
    func commentButtonTapped (cell: PhotoFeedCell)
    
}

class PhotoFeedCell: UITableViewCell {
    
    
    var delegate: CommentButtonTappedDelegate?
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var geoLocationLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var likeCountLabel: UILabel!
    @IBOutlet weak var captionTextView: UITextView!
    
    @IBOutlet weak var commentButton: UIButton!
    
    @IBAction func commentButtonPressed(sender: UIButton) {
        if let delegate = self.delegate {
            delegate.commentButtonTapped(self)
            
        }
    }
    
    @IBAction func onLikeButtonPressed(sender: UIButton)
    {
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
