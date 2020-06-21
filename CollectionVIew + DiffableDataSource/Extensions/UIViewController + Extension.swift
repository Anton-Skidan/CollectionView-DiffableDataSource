//
//  UIViewController + Extension.swift
//  CollectionVIew + DiffableDataSource
//
//  Created by Антон Скидан on 20.06.2020.
//  Copyright © 2020 Anton Skidan. All rights reserved.
//

import UIKit

extension UIViewController {
    
           func configure<T: SelfConfCell, U: Hashable>(collectionView: UICollectionView,cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
           
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
               fatalError("Unable to dequeue \(cellType)")
           }
           cell.configure(with: value)
           return cell
       }
}
