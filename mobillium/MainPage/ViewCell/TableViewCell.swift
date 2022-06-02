//
//  TableViewCell.swift
//  obss
//
//  Created by T66140 on 30.05.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageViews: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
