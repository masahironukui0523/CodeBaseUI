//
//  Page.swift
//  autolayout
//
//  Created by 抜井正寛 on 2019/02/10.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import Foundation

struct Page {
    
    let imageName: String
    let headerText: String
    let bodyText: String
    
    init(imageName: String, headerText: String, bodyText: String) {
        self.imageName = imageName
        self.headerText = headerText
        self.bodyText = bodyText
    }
    
}
