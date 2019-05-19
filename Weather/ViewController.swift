//
//  ViewController.swift
//  Weather
//
//  Created by Admin on 19/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //searchBar.resignFirstResponder()
        let urlString = "https://api.apixu.com/v1/current.json?key=2fcbca7114dd43fb82e144949180601&q=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))"
        let url = URL(string: urlString)
        var locationName: String?
        var temperature: Double?
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
                }
                if let current = json["current"]{
                    temperature = current["temp_c"] as? Double
                }
                //rerfech in 1 Thead
                DispatchQueue.main.async {
                    if errorHasOccured{
                        self.cityLabel.text = "Error city of name"
                        self.temperatureLabel.isHidden = true
                    }else{
                        self.cityLabel.text = locationName
                        self.temperatureLabel.text = "\(temperature!)"
                        self.temperatureLabel.isHidden = false
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

