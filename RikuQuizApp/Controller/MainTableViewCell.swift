//
//  MainTableViewCell.swift
//  RikuQuizApp
//
//  Created by Cookie-san on 2022/02/11.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var kekkaImage: UIImageView!
    @IBOutlet weak var seikaiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
