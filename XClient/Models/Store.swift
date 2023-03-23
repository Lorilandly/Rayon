//
//  Store.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/21.
//

import Foundation

class Store: ObservableObject {
    @Published var servers: [OutboundObject] = []
}
