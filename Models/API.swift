//
//  API.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 14.01.2022.
//

import Foundation
import SwiftUI

enum APICompletion: Error {
    case ServerOffline
    case NoData
    case NonValidStatusCode(statusCode: Int)
    case SerializationErrorWithWrongData(data: String)
}

class API {
    
    private let server = "https://gserv.herokuapp.com"
    
    //  Получение услуг
    func getexecs(service: gService, completition: @escaping ([ExecutorOneService]) -> ()) {
        let url = URL(string: "\(server)/api/execs?parrentserviceid=\(service.id)")!
        let _ = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                print(APICompletion.ServerOffline)
                return
            }
            guard let data = data else {
                print(APICompletion.NoData)
                return
            }
            guard (200 ... 299) ~= response.statusCode else {
                print(APICompletion.NonValidStatusCode(statusCode: response.statusCode))
                return
            }
            if let execs = try? JSONDecoder().decode([ExecutorOneService].self, from: data) {
                
                completition(execs)
                
            } else {
                print(APICompletion.SerializationErrorWithWrongData(data: String(data: data, encoding: .utf8)!))
                return
            }
        }.resume()
    }
    
    //  Получение отзывов
    func getfeeds(service: gService, completition: @escaping ([UserFeedback]) -> ()) {
        let url = URL(string: "\(server)/api/feeds?serviceid=\(service.id)")!
        let _ = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                print(APICompletion.ServerOffline)
                return
            }
            guard let data = data else {
                print(APICompletion.NoData)
                return
            }
            guard (200 ... 299) ~= response.statusCode else {
                print(APICompletion.NonValidStatusCode(statusCode: response.statusCode))
                return
            }
            if let feeds = try? JSONDecoder().decode([UserFeedback].self, from: data) {
                
                completition(feeds)
                
            } else {
                print(APICompletion.SerializationErrorWithWrongData(data: String(data: data, encoding: .utf8)!))
                return
            }
        }.resume()
    }
    
    //  Получение фильтров
    func getfilters(completition: @escaping ([Filter]) -> ()) {
        let url = URL(string: "\(server)/api/filters")!
        let _ = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                print(APICompletion.ServerOffline)
                return
            }
            guard let data = data else {
                print(APICompletion.NoData)
                return
            }
            guard (200 ... 299) ~= response.statusCode else {
                print(APICompletion.NonValidStatusCode(statusCode: response.statusCode))
                return
            }
            if let filters = try? JSONDecoder().decode([Filter].self, from: data) {
                
                completition(filters)
                
            } else {
                print(APICompletion.SerializationErrorWithWrongData(data: String(data: data, encoding: .utf8)!))
                return
            }
        }.resume()
    }
    
    //  Получение сервисов
    func getservices(completition: @escaping ([gService]) -> ()) {
        let url = URL(string: "\(server)/api/services")!
        let _ = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                print(APICompletion.ServerOffline)
                return
            }
            guard let data = data else {
                print(APICompletion.NoData)
                return
            }
            guard (200 ... 299) ~= response.statusCode else {
                print(APICompletion.NonValidStatusCode(statusCode: response.statusCode))
                return
            }
            if let services = try? JSONDecoder().decode([gService].self, from: data) {
                
                completition(services)
                
            } else {
                print(APICompletion.SerializationErrorWithWrongData(data: String(data: data, encoding: .utf8)!))
                return
            }
        }.resume()
    }
    
    //  Получение заказов
    func getorders(user: User, completition: @escaping ([UserOrder]) -> ()) {
        let url = URL(string: "\(server)/api/orders?userid=\(user.id)")!
        let _ = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                print(APICompletion.ServerOffline)
                return
            }
            guard let data = data else {
                print(APICompletion.NoData)
                return
            }
            guard (200 ... 299) ~= response.statusCode else {
                print(APICompletion.NonValidStatusCode(statusCode: response.statusCode))
                return
            }
            if let orders = try? JSONDecoder().decode([UserOrder].self, from: data) {
                
                completition(orders)
                
            } else {
                print(APICompletion.SerializationErrorWithWrongData(data: String(data: data, encoding: .utf8)!))
                return
            }
        }.resume()
    }
    
    //  Отправка отзывов
    func postfeed(feed: UserFeedback, completition: @escaping (Int) -> ()) {
        let url = URL(string: "\(server)/api/feeds")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(feed)
        
        let _ = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else
            {
                print(APICompletion.ServerOffline)
                return
            }
            guard let data = data else {
                print(APICompletion.NoData)
                return
            }
            guard (200 ... 299) ~= response.statusCode else {
                print(APICompletion.NonValidStatusCode(statusCode: response.statusCode))
                return
            }
            print("postfeed data: \(String(describing: String(data: data, encoding: .utf8)))")
            completition(response.statusCode)
            //            check
            //            check
        }.resume()
    }
    
    //  Запрос одного сервиса (для рекламы)
    func getservice(serviceid: Int, completition: @escaping (gService) -> ()) {
        let url = URL(string: "\(server)/api/service?serviceid=\(serviceid)")!
        let _ = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                print(APICompletion.ServerOffline)
                return
            }
            guard let data = data else {
                print(APICompletion.NoData)
                return
            }
            guard (200 ... 299) ~= response.statusCode else {
                print(APICompletion.NonValidStatusCode(statusCode: response.statusCode))
                return
            }
            if let service = try? JSONDecoder().decode(gService.self, from: data) {
                
                completition(service)
                
            } else {
                print(APICompletion.SerializationErrorWithWrongData(data: String(data: data, encoding: .utf8)!))
                return
            }
        }.resume()
    }
    
    
    func postorder(order: PostOrder, completition: @escaping (Int) -> ()) {
        let url = URL(string: "\(server)/api/orders")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(order)
        
        let _ = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else
            {
                print(APICompletion.ServerOffline)
                return
            }
            guard let data = data else {
                print(APICompletion.NoData)
                return
            }
            guard (200 ... 299) ~= response.statusCode else {
                print(APICompletion.NonValidStatusCode(statusCode: response.statusCode))
                return
            }
            print("postorder data: \(String(describing: String(data: data, encoding: .utf8)))")
            completition(response.statusCode)
            //            check
            //            check
        }.resume()
    }
    
    
    func postuser(user: CreatedUser, numberSent: Bool, completition: @escaping (Int) -> ()) {
        let url = URL(string: !numberSent ? "\(server)/api/user" : "\(server)/api/verification")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(user)
        
        let _ = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else
            {
                print(APICompletion.ServerOffline)
                return
            }
            guard let data = data else {
                print(APICompletion.NoData)
                return
            }
            guard (200 ... 299) ~= response.statusCode else {
                print(APICompletion.NonValidStatusCode(statusCode: response.statusCode))
                return
            }
            if numberSent {
                if let user = try? JSONDecoder().decode(User.self, from: data) {
                    print(user)
//                    check check
                } else {
                    print(APICompletion.SerializationErrorWithWrongData(data: String(data: data, encoding: .utf8)!))
                }
            }
            print("createuser firts step data: \(String(describing: String(data: data, encoding: .utf8)))")
            completition(response.statusCode)
            //            check
            //            check
        }.resume()
    }
}
