//
//  ViewController.swift
//  Weather
//
//  Created by Admin on 19/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var contryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let urlString = "https://api.apixu.com/v1/current.json?key=2fcbca7114dd43fb82e144949180601&q=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))"
        let url = URL(string: urlString)
        var locationName: String?
        var regionName: String?
        var countryName: String?
        var temperature: Int?
        //var icon: AnyObject?
        //var test = String?
        var errorHasOccured: Bool = false
        
        let task = URLSession.shared.dataTask(with: url!){/*[weak self]*/(data,response,error) in
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    as! [String : AnyObject]
                
                if let _ = json["error"]{
                    errorHasOccured = true
                }
                
                if let location = json["location"] {
                    locationName = location["name"] as? String
                    regionName = location["region"] as? String
                    countryName = location["country"] as? String
                }
                
                if let current = json["current"]{
                    temperature = current["temp_c"] as? (Int)
                    
                    //iconv = current["condition"] as? [String: String]
                        //icon = condition["icon"] as? String
                    //test = icon["icon"] as? String
                }
                
                /*if let current = json["current"]{
                    if let condition = current["condition"]{
                        icon = condition["icon"] as? URL
                    }
                }*/
                
                //rerfech in 1 Thead
                DispatchQueue.main.async {
                    if errorHasOccured{
                        self.cityLabel.text = "Error of city name"
                        self.temperatureLabel.isHidden = true
                    }else{
                        self.cityLabel.text = locationName
                        self.temperatureLabel.text = "\(temperature!)°C"
                        self.temperatureLabel.isHidden = false
                        //test
                        self.regionLabel.text = regionName
                        self.contryLabel.text = countryName
                    }
                }
            }
            catch let jsonError{
                print(jsonError)
            }
        }
        task.resume()
    }
}

