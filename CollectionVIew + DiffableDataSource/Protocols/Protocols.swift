//
//  Protocol.swift
//  CollectionVIew + DiffableDataSource
//
//  Created by Антон Скидан on 20.06.2020.
//  Copyright © 2020 Anton Skidan. All rights reserved.
//

import Foundation

protocol SelfConfCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}
