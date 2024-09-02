//
//  CardTest.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 8/31/24.
//

import Foundation

struct CardTest {
    var front: String
    var back: String
    
    init(front: String = "Front", back: String = "Back") {
        self.front = front
        self.back = back
    }
    
    static let example = CardTest(front: "This is the front", back: "This is the back")
}
