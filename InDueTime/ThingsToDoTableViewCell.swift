//
//  ThingsToDoTableViewCell.swift
//  InDueTime
//
//  Created by Kimberly Skipper on 12/20/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
///Users/kimmyskipper/Desktop/checkbox-pressed.png

import UIKit

class ThingsToDoTableViewCell: UITableViewCell
{
    @IBOutlet weak var toDoTitleTextField: UITextField!
    @IBOutlet weak var checkboxButton: UIButton!
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
