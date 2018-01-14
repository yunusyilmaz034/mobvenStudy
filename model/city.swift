//
//  city.swift
//  mobvenStudy
//
//  Created by EMRE YILMAZ on 13.01.2018.
//  Copyright © 2018 YUNUS YILMAZ. All rights reserved.
//

import Foundation


struct city {
    var id : Int
    var name : String
    var country : String
    
    init(id: Int, of name:String, from country: String) {
        self.id = id
        self.name = name
        self.country = country
    }
}
