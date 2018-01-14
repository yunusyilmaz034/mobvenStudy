//
//  ViewController.swift
//  mobvenStudy
//
//  Created by YUNUS YILMAZ on 12.01.2018.
//  Copyright © 2018 YUNUS YILMAZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(city.getFromCityFile())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

