//
//  SettingsViewController.swift
//  rocket
//
//  Created by angelina on 21.08.2022.
//

import UIKit

/// Контроллер экрана сценария "Настройки"
class SettingsViewController: UIViewController {

    @IBOutlet weak var height: UISegmentedControl!
    @IBOutlet weak var diameter: UISegmentedControl!
    @IBOutlet weak var mass: UISegmentedControl!
    @IBOutlet weak var leo: UISegmentedControl!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setSettings()
        
        colorSegmentedControl(item: height)
        colorSegmentedControl(item: diameter)
        colorSegmentedControl(item: mass)
        colorSegmentedControl(item: leo)
        
//      следим за переключениями SegmentedControl
        height.addTarget(self, action: #selector(heightChanged(_:)), for: .valueChanged)
        diameter.addTarget(self, action: #selector(diameterChanged(_:)), for: .valueChanged)
        mass.addTarget(self, action: #selector(massChanged(_:)), for: .valueChanged)
        leo.addTarget(self, action: #selector(leoChanged(_:)), for: .valueChanged)
    }
    
//  установка настроек согласно синглтоны, в котором храниться запись о состоянии
    func setSettings(){
        height.selectedSegmentIndex = CofigurationHolder.instance.height == UnitMeasure.meters ? 0 : 1
        diameter.selectedSegmentIndex = CofigurationHolder.instance.diameter == UnitMeasure.meters ? 0 : 1
        mass.selectedSegmentIndex = CofigurationHolder.instance.mass == UnitMeasure.kg ? 0 : 1
        leo.selectedSegmentIndex = CofigurationHolder.instance.leo == UnitMeasure.kg ? 0 : 1
    }
    
//    установка значений SegmentedControl в синглтон конфигурации
    @objc func heightChanged(_ sender: UISegmentedControl) {
        CofigurationHolder.instance.height = sender.selectedSegmentIndex == 0 ? UnitMeasure.meters : UnitMeasure.feet
        CofigurationHolder.instance.delegate?.onSettingsChange()
    }
    
    @objc func diameterChanged(_ sender: UISegmentedControl) {
        CofigurationHolder.instance.diameter = sender.selectedSegmentIndex == 0 ? UnitMeasure.meters : UnitMeasure.feet
        CofigurationHolder.instance.delegate?.onSettingsChange()
    }
    
    @objc func massChanged(_ sender: UISegmentedControl) {
        CofigurationHolder.instance.mass = sender.selectedSegmentIndex == 0 ? UnitMeasure.kg : UnitMeasure.lb
        CofigurationHolder.instance.delegate?.onSettingsChange()
    }
    
    @objc func leoChanged(_ sender: UISegmentedControl) {
        CofigurationHolder.instance.leo = sender.selectedSegmentIndex == 0 ? UnitMeasure.kg : UnitMeasure.lb
        CofigurationHolder.instance.delegate?.onSettingsChange()
    }
    
//    красивое отображение SegmentedControl согласно настройкам
    func colorSegmentedControl(item: UISegmentedControl) {
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
    }
    
    
//    закрыть вью
    @IBAction func cancelScreen(_ sender: UIBarButtonItem) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
}
