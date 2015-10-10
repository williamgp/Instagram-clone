//
//  cell.swift
//  ParseStarterProject-Swift
//
//  Created by William Peregoy on 2015/10/10.
//  Copyright © 2015年 Parse. All rights reserved.
//

import UIKit

class cell: UITableViewCell {

    @IBOutlet weak var postedImage: UIImageView!
    
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var username: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
