//
//  TableViewCell.swift
//  rocket
//
//  Created by angelina on 22.08.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tableCellView: UIView!
    
    @IBOutlet private weak var missionName: UILabel!
    @IBOutlet private weak var missionDate: UILabel!
    @IBOutlet weak var successImage: UIImageView!
    @IBOutlet weak var check: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableCellView.layer.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLaunch(launch: Launch) {
        missionName.text = launch.name
        missionDate.text = Date().dateFromApiString(launch.date_utc)?.toRusString
    }
}
