//
//  ViewController.swift
//  Weather
//
//  Created by Admin on 19/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet var textLabel: UILabel!
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet var contryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var weather = Weather()
        
        searchBar.resignFirstResponder()
        let urlString = "https://api.apixu.com/v1/current.json?key=2fcbca7114dd43fb82e144949180601&q=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))"
        let url = URL(string: urlString)
        var errorHasOccured: Bool = false
        
        let task = URLSession.shared.dataTask(with: url!){/*[weak self]*/(data,response,error) in
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    as! [String : AnyObject]
                
                if let _ = json["error"]{
                    errorHasOccured = true
                }
                
                if let location = json["location"] {
                    weather.locationName = location["name"] as? String
                    weather.regionName = location["region"] as? String
                    weather.countryName = location["country"] as? String
                    weather.localTime = location["localtime"] as? String
                }
                
                if let current = json["current"]{
                    weather.temperature = current["temp_c"] as? (Int)
                    weather.isDay = current["is_day"] as? (Int)
                    
                    let condition = current["condition"] as? [String: AnyObject]
                    weather.text = condition?["text"] as? String
                    weather.icon = condition?["icon"] as? String
                    weather.code = condition?["code"] as? (Int)
                }
                
                //rerfech in 1 Thead
                DispatchQueue.main.async {
                    if errorHasOccured{
                        self.cityLabel.text = "Error of city name"
                        self.temperatureLabel.isHidden = true
                        self.regionLabel.isHidden = true
                        self.contryLabel.isHidden = true
                        self.textLabel.isHidden = true
                        self.iconImage.isHidden = true
                    }else{
                        self.cityLabel.text = weather.locationName
                        self.temperatureLabel.text = "\(weather.temperature!)°C"
                        self.temperatureLabel.isHidden = false
                        //test
                        self.regionLabel.text = "Region: \(weather.regionName!)"
                        self.regionLabel.isHidden = false
                        self.contryLabel.text = "Contry: \(weather.countryName!)"
                        self.contryLabel.isHidden = false
                        
                        self.textLabel.text = weather.text!
                        self.textLabel.isHidden = false
                        
                        let url = URL(string: "https:\(weather.icon!)")
                        self.iconImage.kf.indicatorType = .activity
                        self.iconImage.kf.setImage(with: url)
                        self.iconImage.isHidden = false
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
