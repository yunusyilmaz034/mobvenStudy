//
//  HistoryTableViewController.swift
//  mobvenStudy
//
//  Created by EMRE YILMAZ on 14.01.2018.
//  Copyright © 2018 YUNUS YILMAZ. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    var historyCities = [String]()
    var cities = [city]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let plistPath = delegate.plistPathDocuments
        
        if let dict = NSMutableDictionary(contentsOfFile: plistPath) {
            var loadString = dict.object(forKey: "New item") as! String
            //var loadString = try String(contentsOfFile: plistPath)
            //print("pure load: " + loadString)
            loadString = loadString.replacingOccurrences(of: " ", with: "")
            //
            
            
            
            historyCities = loadString.components(separatedBy: ",")
            if historyCities[0].description == "" {
                historyCities.remove(at: 0)
            }
            //print("seperated: " + loadString.components(separatedBy: ",").description)
            //print("history: " + historyCities.description)
            
            for item in historyCities {
                let _city = city(id: (item.components(separatedBy: ".")[0].description as NSString).integerValue, of: item.components(separatedBy: ".")[1].description, from: item.components(separatedBy: ".")[2].description)
                cities.append(_city)
            }
            //print(cities)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return historyCities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = cities[indexPath.row].name
        return cell
    }
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHistory" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let m_city = cities[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailCity = m_city
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
 
}
