//
//  Extension.swift
//  rocket
//
//  Created by angelina on 24.08.2022.
//

import UIKit
//расширение для загрузки ФОТО
extension UIImageView {
    func loadImage(with url: String, placeHolder: UIImage? = nil) {
        self.image = nil
//        конфигурация урла
        let iconUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//        проверка урла на валидность, разворачиваем из опционала
        if let url = URL(string: iconUrl) {
//      выделяем новый поток для выполнения кода ниже
            URLSession.shared.dataTask(with: url) { data, response, error in
//                если выкинуло ошибку
                if error != nil {
//                возвращаемся в главный поток, чтоб изменить элемент интерфейса
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
//                если всё прошло хорошо и данные получены
                DispatchQueue.main.async {
                    if let data = data {
                        if let image = UIImage(data: data) {
                            self.image = image
                        }
                    }
                }
            }.resume()
        }
    }
}

//для конвертации даты в формат Даты
extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ssZ")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru-RU")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
}

//для конвертации даты
extension Date {
//    в русскую дату определенного формата стороки
    var toRusString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }

    func dateFromApiStr(_ eventDate: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateFormatter.date(from: eventDate)
        return date
    }
    
    
    func dateFromApiString(_ eventDate: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateFormatter.date(from: eventDate)
        return date
    }
    
}
