//
//  ModelLaunch.swift
//  rocket
//
//  Created by angelina on 24.08.2022.
//

import Foundation

/// Модель запуска ракеты
class Launch: Decodable {
    let name: String
    let date_utc: String
    let rocket: String
    let success: Bool?
}
