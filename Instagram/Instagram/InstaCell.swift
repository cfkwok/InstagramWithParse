//
//  InstaCell.swift
//  Instagram
//
//  Created by Chun Kwok on 2/20/16.
//  Copyright © 2016 Chun Kwok. All rights reserved.
//

import UIKit

class InstaCell: UITableViewCell {

    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var capLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
