//
//  ElementsModel.swift
//  Test
//
//  Created by Sergey Starchenkov on 09.03.2021.
//

import Foundation

struct ElementsModel: Decodable {
    let data: [DataElements]
    let view: [String]
}

struct DataElements: Decodable {
    let name: String
    let data: Elements
}

struct Elements: Decodable {
    let text: String?
    let url: String?
    let selectedId: Int?
    let variants: [Selector]?
}

struct Selector: Decodable {
    let id: Int
    let text: String
}
