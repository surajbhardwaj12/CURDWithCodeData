//
//  TableViewCell.swift
//  CoreProject
//
//  Created by IPS-161 on 16/01/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var btnSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnisActive(_ sender: Any) {
        
    }
}
