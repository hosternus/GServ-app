//
//  ServiceModel.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 03.12.2021.
//

import Foundation
import MapKit


struct DataTime: Codable {
    var year, month, date, hour, minute: Int
    var second: Double
}


struct gService: Codable, Identifiable {
    var id, category, phone: Int
    var name, description, address: String
    var rating: Double
    var longitude, latitude: CLLocationDegrees
}


struct Filter: Codable, Identifiable {
    var id: Int
    var name: String
}


struct User: Codable {
    var phone, id: Int
    var name, surname, address, favorites: String
}


struct CreatedUser: Codable {
    var phone: Int
    var code: Int?
}


struct UserFeedback: Codable, Identifiable {
    var mark: Int
    var feed: String
    var name: String?
    var userid, id, serviceid: Int?
}


struct PostOrder: Codable {
    var runtime: String
    var uslugaid, userid: Int
}


struct UserOrder: Codable, Identifiable {
    var id, serviceid: Int
    var ename, sname: String
    var price: Double
    var isCompleted, accepted: Bool
}


struct ExecutorOneService: Codable, Identifiable {
    var id: Int
    var name, description: String
    var price: Double
}


struct MapPoint: Identifiable {
    let id = UUID()
    var coordinates = CLLocationCoordinate2D()
}
