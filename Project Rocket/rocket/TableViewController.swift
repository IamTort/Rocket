//
//  TableViewController.swift
//  rocket
//
//  Created by angelina on 22.08.2022.
//

import UIKit

/// Контроллер экрана сценария "Запуски ракет"
class TableViewController: UITableViewController {

    let service = Service()
    var rocketNumber:String = ""
    var rocketName: String = ""
// массив запусков
    var launches = [Launch]()
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var navCont: UINavigationItem!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        загружаем в массив кол-во запусков с данными
        service.loadLaunches { launches in
//            фильтруем относительно определенной ракеты
            launches.filter{$0.rocket == self.rocketNumber}
                .forEach { launch in
//                    складываем в массив
                    self.launches.append(launch)
                }
//            в главном потоке отображаем информацию на Экране
            DispatchQueue.main.async {
                self.navCont.self.title = self.rocketName
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return launches.count
    }

//    отображаем данные
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        let launch = launches[indexPath.row]
        cell?.setLaunch(launch: launch)
        
        if launch.success != nil {
            if launch.success == true {
                cell?.successImage.image = UIImage(named: "rocket")
                cell?.check.image = UIImage(named: "checkmark")
            } else if launch.success == false {
                cell?.successImage.image = UIImage(named: "rocketFall")
                cell?.check.image = UIImage(named: "xcheckmark")
            }
        } else {
            cell?.successImage.image = .none
        }
        return cell ?? UITableViewCell()
    }
    
//    кнопка назад
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

