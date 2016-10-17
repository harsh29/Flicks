//
//  MovieViewCell.swift
//  Flicks
//
//  Created by Harsh Trivedi on 10/17/16.
//  Copyright © 2016 Harsh Trivedi. All rights reserved.
//

import UIKit

class MovieViewCell: UITableViewCell {

    @IBOutlet weak var movieCellTitle: UILabel!
    @IBOutlet weak var movieCellOverview: UILabel!
    
    
    @IBOutlet weak var movieCellPosterView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
