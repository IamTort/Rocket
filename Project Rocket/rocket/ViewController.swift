//
//  ViewController.swift
//  rocket
//
//  Created by angelina on 17.08.2022.
//

import UIKit

/// Контроллер экрана сценария "Главный экран"
class ViewController: UIViewController, UIViewControllerTransitioningDelegate, SettingsChangedDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var page: UIPageControl!
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var buttonLaunch: UIButton!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var diameter: UILabel!
    @IBOutlet weak var mass: UILabel!
    @IBOutlet weak var leo: UILabel!
    
    @IBOutlet weak var firstFlight: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var cost: UILabel!
    
    @IBOutlet weak var enginesFirstStage: UILabel!
    @IBOutlet weak var fuelFirstStage: UILabel!
    @IBOutlet weak var burnTimeFirstStage: UILabel!
    
    @IBOutlet weak var enginesSecondStage: UILabel!
    @IBOutlet weak var fuelSecondStage: UILabel!
    @IBOutlet weak var burnTimeSecondStage: UILabel!
    
    
    @IBOutlet weak var heightText: UILabel!
    @IBOutlet weak var diameterText: UILabel!
    @IBOutlet weak var massText: UILabel!
    @IBOutlet weak var leoText: UILabel!
    
    
    let service = Service()
//    массив с общими данными о ракете
    var rockets = [Rocket]()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipesObservers()
        setCornerRadius()
        service.loadRocket { result in
            self.rockets += result
            DispatchQueue.main.async {
                self.displayData(x: 0)
            }
        }
        CofigurationHolder.instance.delegate = self
    }
// метод отвечает, за наблюдением свайпов
    func swipesObservers() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeRight.direction = .right
        self.infoView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeLeft.direction = .left
        self.infoView.addGestureRecognizer(swipeLeft)
        
    }
//    логика свайпов
    @objc func handleSwipes(gester: UISwipeGestureRecognizer) {
        
        switch gester.direction {
        case .right:
            if page.currentPage >= 1 {
            page.currentPage -= 1
                displayData(x: page.currentPage)
                
            }
        case .left:
            if page.currentPage < page.numberOfPages {
            page.currentPage += 1
                displayData(x: page.currentPage)
            }
        default:
            break
        }
    }
//    установка закруглений вьюхам
    func setCornerRadius() {
        infoView.layer.cornerRadius = 30
        buttonLaunch.layer.cornerRadius = 10
        view1.layer.cornerRadius = 30
        view2.layer.cornerRadius = 30
        view3.layer.cornerRadius = 30
        view4.layer.cornerRadius = 30
    }
//    отображение данных
    func displayData(x: Int) {
        
        imageView.loadImage(with: self.rockets[x].flickr_images[0])
        name.text = String(self.rockets[x].name)
        
        height.text = String(self.rockets[x].height.feet)
        diameter.text = String(self.rockets[x].diameter.feet)
        mass.text = String(self.rockets[x].mass.lb)
        leo.text = String(self.rockets[x].payload_weights[0].lb)
        
        firstFlight.text = Date().dateFromApiStr(self.rockets[x].first_flight)?.toRusString
        if x == 0 {
            country.text = "Marshall Islands"
        } else {
            country.text = String(self.rockets[x].country)
        }
        cost.text = "$" + String(self.rockets[x].cost_per_launch/1_000_000) + " млн"
        
        enginesFirstStage.text = String(self.rockets[x].first_stage.engines)
        fuelFirstStage.text = String(self.rockets[x].first_stage.fuel_amount_tons)
        burnTimeFirstStage.text = String(self.rockets[x].first_stage.burn_time_sec ?? 0)
        
        enginesSecondStage.text = String(self.rockets[x].second_stage.engines)
        fuelSecondStage.text = String(self.rockets[x].second_stage.fuel_amount_tons)
        burnTimeSecondStage.text = String(self.rockets[x].second_stage.burn_time_sec ?? 0)
    }
//    делегат изменение настроек
    func onSettingsChange() {
        if CofigurationHolder.instance.height == UnitMeasure.feet{
            height.text = String(self.rockets[page.currentPage].height.feet)
            heightText.text = "Высота, ft"
        } else {
            height.text = String(self.rockets[page.currentPage].height.meters)
            heightText.text = "Высота, m"
        }
        
        diameter.text = CofigurationHolder.instance.diameter == UnitMeasure.feet ?  String(self.rockets[page.currentPage].diameter.feet) : String(self.rockets[page.currentPage].diameter.meters)
        diameterText.text = CofigurationHolder.instance.diameter == UnitMeasure.feet ?  "Диаметр, ft" : "Диаметр, m"
        
        mass.text = CofigurationHolder.instance.mass == UnitMeasure.kg ?  String(self.rockets[page.currentPage].mass.kg) : String(self.rockets[page.currentPage].mass.lb)
        massText.text = CofigurationHolder.instance.mass == UnitMeasure.kg ?  "Масса, kg" : "Масса, lb"
        
        leo.text = CofigurationHolder.instance.leo == UnitMeasure.kg ?  String(self.rockets[page.currentPage].payload_weights[0].kg) : String(self.rockets[page.currentPage].payload_weights[0].lb)
        leoText.text = CofigurationHolder.instance.leo == UnitMeasure.kg ?  "Нагрузка, kg" : "Нагрузка, lb"
    }
    
//    переход на экран настройки
    @IBAction func settings(_ sender: UIButton) {
    }
    
//    переход на экран "Запуски ракет"
    @IBAction func seeLaunches(_ sender: Any) {
        self.performSegue(withIdentifier: "secondControllerView", sender: nil)
    }
    
//    передача информации на другой экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? TableViewController else {return}
        viewController.transitioningDelegate = self
//        номер ракеты, по которому ищем запуски
        viewController.rocketNumber = String(rockets[page.currentPage].id)
//        имя ракеты
        viewController.rocketName = String(rockets[page.currentPage].name)
    }
    
}

//      Анимация перехода на другой контроллер
extension ViewController {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator(presentationStartButton: button, isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator(presentationStartButton: button, isPresenting: false)
    }
    
    
}

