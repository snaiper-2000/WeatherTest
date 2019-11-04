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
            
        let urlString = "http://api.weatherstack.com/current?access_key=cc40be1666bb95f8db58ffc8d909683d&query=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))"
            print(urlString)
            let url = URL(string: urlString)
            
            var errorHasOccured: Bool = false
            
            let task = URLSession.shared.dataTask(with: url!){(data,response,error) in
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                        as?  [String : AnyObject]{
                            
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
                                weather.temperature = current["temperature"] as? (Int)
                                if weather.temperature == nil{
                                    weather.temperature = -500
                                }
                                weather.isDay = current["is_day"] as? (Int)
                                weather.weather_descriptions = current["weather_descriptions"] as? [String]
                                weather.weather_icons = current["weather_icons"] as? [String]
                                
                                let condition = current["condition"] as? [String: AnyObject]
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
                                    
                                    self.textLabel.text = weather.weather_descriptions?.joined(separator:" ")
                                    self.textLabel.isHidden = false
                                    
                                    let url = URL(string: (weather.weather_icons?.joined(separator:" "))!)
                                    self.iconImage.kf.indicatorType = .activity
                                    self.iconImage.kf.setImage(with: url)
                                    self.iconImage.isHidden = false
                                }
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
    
    /*func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var weather = Weather()
        
        searchBar.resignFirstResponder()
        let urlString = "http://api.weatherstack.com/current?access_key=cc40be1666bb95f8db58ffc8d909683d&query=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))"
        let url = URL(string: urlString)
        print(url)
        var errorHasOccured: Bool = false
        
        let task = URLSession.shared.dataTask(with: url!){(data,response,error) in
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                        as?  [String : AnyObject]{
                        
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
                            weather.temperature = current["temperature"] as? (Int)
                            if weather.temperature == nil{
                                weather.temperature = -500
                            }
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
                    
                }
                catch let jsonError{
                    print(jsonError)
                }
            }
        
            task.resume()
        }*/

