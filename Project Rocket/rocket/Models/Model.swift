//
//  Model.swift
//  rocket
//
//  Created by angelina on 22.08.2022.
//

import Foundation

/// Модель ракеты
class Rocket: Decodable {
    ///Высота ракеты
    let height : Height
    ///Диаметр ракеты
    let diameter: Diameter
    ///Масса ракеты
    let mass: Mass
    ///Инфа о первой ступени
    let first_stage: FirstStage
    ///Инфа о второй ступени
    let second_stage: SecondStage
    ///Вес полезной нагрузки
    let payload_weights: [Leo]
    ///Массив картинок
    let flickr_images: [String]
    ///Название ракеты
    let name: String
    ///Стоимость запуска
    let cost_per_launch: Double
    ///Первый полет
    let first_flight: String
    ///Страна
    let country: String
    ///Идентификационный номер ракеты
    let id: String
}

///Инфа о весе
class Height: Decodable {
    let meters: Double
    let feet: Double
}
///Инфа о диаметре
class Diameter: Decodable {
    let meters: Double
    let feet: Double
}
///Инфа о массе
class Mass: Decodable {
    let kg: Int
    let lb: Int
}
///Инфа о первой ступени
class FirstStage: Decodable {
    let engines: Int
    let fuel_amount_tons: Double
    let burn_time_sec: Int?
}
///Инфа о второй ступени
class SecondStage: Decodable {
    let engines: Int
    let fuel_amount_tons: Double
    let burn_time_sec: Int?
}
///Инфа о масса полезной нагрузки
class Leo: Decodable {
    let id: String
    let kg: Int
    let lb: Int
}

