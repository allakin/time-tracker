//
//  ProjectListTVCell.swift
//  time_tracker
//
//  Created by Pavel on 11/11/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

class ProjectListTVCell: UITableViewCell {

	@IBOutlet weak var projectName: UILabel!
	@IBOutlet weak var totalTime: UILabel!
	@IBOutlet weak var colorProject: UIView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
