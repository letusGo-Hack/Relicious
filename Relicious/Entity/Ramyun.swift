//
//  Ramyun.swift
//  Relicious
//
//  Created by Milkyo on 6/10/23.
//

import Foundation
import Combine

struct Ramyun: Identifiable, Codable {
    let id: UUID
    /// 라면 이름
    let name: String
    /// 라면 이미지 이름(사용자가 추가한 라면일 경우 nil)
    let imageName: String?
    /// 라면 이미지 데이터(사용자가 추가한 라면일 경우에만 존재)
    let image: Data?
    // 라면 칼로리
    let calorie: Int?
    // 라면 시간
    let time: Int
    
    var isRunnging: Bool = false
    
    var counter = 0
    
    var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    
    init(
        name: String,
        imageName: String? = nil,
        image: Data? = nil,
        calorie: Int? = nil,
        time: Int
    ) {
        self.id = UUID()
        self.name = name
        self.imageName = imageName
        self.image = image
        self.calorie = calorie
        self.time = time
    }
}
