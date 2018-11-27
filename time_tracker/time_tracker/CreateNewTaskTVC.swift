//
//  CreateNewTaskTVC.swift
//  time_tracker
//
//  Created by Pavel on 27/11/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

class CreateNewTaskTVC: UITableViewCell {
	
	@IBOutlet weak var taskName: UILabel!
	@IBOutlet weak var taskTime: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
