//
//  WeatherCell.swift
//  XML PARSER RESTRUCTURING
//
//  Created by (^ㅗ^)7 iMac on 2022/12/01.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    var datalist = [[String:String]]()
    var detaildata = [String:String]()
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
