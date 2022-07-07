//
//  PartialAuditCell.swift
//  Litter Stopper
//
//  Created by Apple01 on 9/6/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class PartialAuditCell: UICollectionViewCell {
    var count = Int()
    
    @IBOutlet weak var lbl_Count: UILabel!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var View_cell: UIView!
    @IBOutlet weak var img_Content: UIImageView!
    @IBOutlet weak var img_selectedImg: UIImageView!

    override var isSelected: Bool{
        didSet{
            if self.isSelected {
                self.img_selectedImg.isHidden = false
            }
            else{
                self.img_selectedImg.isHidden = true
            }
        }
    }
}
