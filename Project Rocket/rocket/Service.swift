//
//  Service.swift
//  rocket
//
//  Created by angelina on 22.08.2022.
//

import Foundation

/// Класс, отвечающий за загрузку даннных с сервера на контроллер "Главная страница"
final class Service {
    //создаем сессию, выполняется только при вызове
        private lazy var session: URLSession = {
            let session = URLSession(configuration: .default)
            return session
        }()
   // метод для загрузки данных Ракет(главный контроллер), с замыканием
    func loadRocket(completion: @escaping ([Rocket]) -> Void) {
        
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return }
        
        let task = session.dataTask(with: url) { data, _, _ in
            
            guard let data = data else {
                return
            }
           
//            десериализируем данные и закидываем в модель
            do {
                let result = try JSONDecoder().decode([Rocket].self, from: data)
                completion(result)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
// метод для загрузки данных Запуска Ракет(контроллер со списком), с замыканием
    func loadLaunches(completion: @escaping ([Launch]) -> Void) {
        
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches") else { return }
        
        let task = session.dataTask(with: url) { data, _, _ in
            
            guard let data = data else {
                return
            }
           
//            print(String(data: data, encoding: .utf8))
            do {
                let result = try JSONDecoder().decode([Launch].self, from: data)
                completion(result)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}


