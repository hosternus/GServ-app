//
//  Extensions.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 18.02.2022.
//

import Foundation

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
