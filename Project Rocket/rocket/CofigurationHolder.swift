//
//  CofigurationHolder.swift
//  rocket
//
//  Created by angelina on 24.08.2022.
//

import Foundation
//протокол для делегата
protocol SettingsChangedDelegate {
    func onSettingsChange()
}

//синглтон, для изменения значений на главном экране с помощью делегата
final class CofigurationHolder {
    
    static let instance = CofigurationHolder()
    
    private init() {}
    
    var delegate: SettingsChangedDelegate?
    
    var height: UnitMeasure?
    var diameter: UnitMeasure?
    var mass: UnitMeasure?
    var leo: UnitMeasure?
}
