//
//  GlobalViewModels.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 18.02.2022.
//

import Foundation
import SwiftUI

struct NoAnim: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}
