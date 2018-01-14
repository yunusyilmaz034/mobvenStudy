//
//  DetailViewController.swift
//  mobvenStudy
//
//  Created by EMRE YILMAZ on 14.01.2018.
//  Copyright © 2018 YUNUS YILMAZ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class DetailViewController: UIViewController {

    @IBOutlet weak var cityTitle: UILabel!
    typealias JSONStandard = Dictionary<String, AnyObject>
    
    @IBOutlet weak var endPicker: UIDatePicker!
    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    var _temp = String()
    var _weather = String()
    var _location = String()
    var _date = Double()
    
    var detailCity: city? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailCity = detailCity {
            if let cityTitle = cityTitle {
                cityTitle.text = detailCity.name
                title = detailCity.country
                self.saveToPlistFile(detailCity)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        downloadFile {
            self.updateUI()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateUI() {
        date.text = self._date.description
        weather.text = self._weather
        temp.text = self._temp
        location.text = self._location
    }
    func saveToPlistFile(_ city: city)
    {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let pathForThePlistFile = delegate.plistPathDocuments
        do {
            //let result = NSMutableDictionary(contentsOfFile: pathForThePlistFile)
            //print("result: \(result?.description)")
            var text = ""
            if let dict = NSMutableDictionary(contentsOfFile: pathForThePlistFile) {
                text = dict.object(forKey: "New item") as! String
            
                print("text: " + text)
                text = "\(text),\(city.id).\(city.name).\(city.country)"
                dict.setValue(text, forKey: "New item")
                
                dict.write(toFile: pathForThePlistFile, atomically: false)
            }
        }
    }
    //dowloand file
    func downloadFile(completedRefresh: @escaping ()-> ()) {
        var cityName = String(); //default
        if let detailCity = detailCity {
            cityName = detailCity.name
        }
        
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=0fbc6164b4e2157f65b7c65e3680ba80"
        print("url: \(url)")
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            let result = response.result
                    if let dict = result.value as? JSONStandard, let main = dict["main"] as? JSONStandard, let temp = main["temp"] as? Double, let weatherArray = dict["weather"] as? [JSONStandard], let weather = weatherArray[0]["main"] as? String, let name = dict["name"] as? String, let sys = dict["sys"] as? JSONStandard, let country = sys["country"] as? String, let dt = dict["dt"] as? Double {
 
                        self._temp = String(format: "%.0f °C", temp - 273.15)
                        self._weather = weather
                        self._location = "\(name), \(country)"
                        self._date = dt

                    }
                    else{
                        print("HATA! not parse")
                    }
            completedRefresh()
            })
    }

    @IBAction func accordingToDateSendBtn(_ sender: UIButton) {
        print(startPicker.date.timeIntervalSinceNow.description)
        downloadDateFile(startPicker.date.timeIntervalSinceNow.description, endTime: endPicker.date.timeIntervalSinceNow.description) {
            self.updateUI()
        }
        
    }
    
    //dowloand date file
    func downloadDateFile(_ startTime: String, endTime: String, completedRefresh: @escaping ()-> ()) {
        var cityName = String(); //default
        if let detailCity = detailCity {
            cityName = detailCity.name
        }
        
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&start=\(startTime)&end=\(endTime)&APPID=0fbc6164b4e2157f65b7c65e3680ba80"
        print("url: \(url)")
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            let result = response.result
            if let dict = result.value as? JSONStandard, let main = dict["main"] as? JSONStandard, let temp = main["temp"] as? Double, let weatherArray = dict["weather"] as? [JSONStandard], let weather = weatherArray[0]["main"] as? String, let name = dict["name"] as? String, let sys = dict["sys"] as? JSONStandard, let country = sys["country"] as? String, let dt = dict["dt"] as? Double {
                
                self._temp = String(format: "%.0f °C", temp)
                self._weather = weather
                self._location = "\(name), \(country)"
                self._date = dt
                
            }
            else{
                print("HATA! not parse")
            }
            completedRefresh()
        })
    }
    
}
