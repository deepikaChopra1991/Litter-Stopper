//
//  GroupsCell.swift
//  Litter Stopper
//
//  Created by Applr on 20/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class GroupsCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet var lblName : UILabel!
    @IBOutlet weak var img_NextArrow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
