//
//  RestaurantTableViewCell.swift
//  ZidaneFood
//
//  Created by Mohamed Salah Zidane on 8/28/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var usernameLabel:UILabel!
    @IBOutlet var aboutLabel: UILabel!
    @IBOutlet var timePostedLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!

    @IBOutlet var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
