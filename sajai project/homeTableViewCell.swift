//
//  homeTableViewCell.swift
//  sajai projectUITests
//
//  Created by iroid on 19/12/23.
//  Copyright © 2023 iroid. All rights reserved.
//

import UIKit

class homeTableViewCell: UITableViewCell {
    @IBOutlet weak var imgtv: UIImageView!
    
    @IBOutlet weak var lbltv: UILabel!
    @IBOutlet weak var texvtv: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
