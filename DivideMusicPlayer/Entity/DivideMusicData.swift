//
//  DivideMusicData.swift
//  DivideMusicPlayer
//
//  Created by 鶴本賢太朗 on 2021/06/17.
//

import Foundation
import RealmSwift

class DivideMusicData: Object, ObjectKeyIdentifiable {
    @objc dynamic var _id: String
    @objc dynamic var divideTime: Double
    
    init(id: UInt64, divideTime: Double) {
        self._id = "\(id)"
        self.divideTime = divideTime
    }
    
    override init() {
        self._id = UUID().uuidString
        self.divideTime = 0.0
    }
    
    override class func primaryKey() -> String? {
        "_id"
    }
}
