//
//  BountyInfo.swift
//  BountyList
//
//  Created by 손한비 on 2020/08/26.
//  Copyright © 2020 kr.co.hist. All rights reserved.
//

import UIKit

// Model: BountyInfo
struct BountyInfo{
    let name: String
    let bounty: Int
    
    var image: UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init(name: String, bounty: Int) {
        self.name = name
        self.bounty = bounty
    }
}
