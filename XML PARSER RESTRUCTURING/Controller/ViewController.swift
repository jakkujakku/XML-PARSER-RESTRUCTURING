//
//  ViewController.swift
//  XML PARSER RESTRUCTURING
//
//  Created by (^ㅗ^)7 iMac on 2022/12/01.
//

import UIKit

class ViewController: UIViewController {
    
    var datalist = [[String:String]]()
    var detaildata = [String:String]()
    var elementTemp: String = ""
    var blank: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // url String
        let urlString = "https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/weather.xml"
        
        // base url
        guard let baseURL = URL(string: urlString) else {
            print("URL error")
            return
        }
        guard let parser = XMLParser(contentsOf: baseURL) else {
            print("Can't read data")
            return
        }
        parser.delegate = self
        if !parser.parse() {
            print("Parse failure")
        }
    }

}

//MARK: - UiTableViewDatasource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datalist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell
        
        let dicTemp = datalist[indexPath.row]
        
        cell.countryLabel.text = dicTemp["country"]
        let weatherStr = dicTemp["weather"]
        
        cell.weatherLabel.text = weatherStr
        cell.temperatureLabel.text = dicTemp["temperature"]
        if weatherStr == "맑음" {
            cell.imgView.image = UIImage(systemName: "sun.max")
            cell.imgView.tintColor = UIColor.red
        } else if weatherStr == "비" {
            cell.imgView.image = UIImage(systemName: "cloud.rain.fill")
            cell.imgView.tintColor = UIColor.systemBlue
        } else if weatherStr == "흐림" {
            cell.imgView.image = UIImage(systemName: "cloud")
            cell.imgView.tintColor = UIColor.gray
        } else if weatherStr == "눈" {
            cell.imgView.image = UIImage(systemName: "cloud.snow")
            cell.imgView.tintColor = UIColor.systemMint
        } else {
            cell.imgView.image = UIImage(systemName: "cloud.sleet")
            cell.imgView.tintColor = UIColor.black
        }
        return cell
    }
}

//MARK: - XMLParserDelegate
extension ViewController: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        elementTemp = elementName
        blank = true
        print("start: \(elementName)")
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if blank == true && elementTemp != "local" && elementTemp != "weatherinfo" {
            detaildata[elementTemp] = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        print("string: \(string)")
        print("detaildata: \(detaildata)")
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "local" {
            datalist += [detaildata]
        }
        blank = false
        print("end : \(elementName)")
    }
}



