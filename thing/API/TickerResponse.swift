//
//  TicketItem.swift
//  thing
//
//  Created by John Pothier on 10/21/21.
//

import Foundation

struct TickerItem : Decodable {
    let name: String
    let symbol: String
}

struct TickerResponse : Decodable {
    let data: [TickerItem]
}
