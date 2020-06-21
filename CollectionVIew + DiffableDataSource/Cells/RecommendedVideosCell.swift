//
//  RecommendedVideosCell.swift
//  CollectionVIew + DiffableDataSource
//
//  Created by Антон Скидан on 20.06.2020.
//  Copyright © 2020 Anton Skidan. All rights reserved.
//

import UIKit


class RecommendedVideosCell: UICollectionViewCell, SelfConfCell {
    
    static var reuseId: String = "RecommendedVideosCell"
    let imageView = UIImageView()
    let name = UILabel(text: "name", font: .laoSangamMN12())
    let type = UILabel(text: "Type", font: .avenir10())
    let desc = UILabel(text: "Description", font: .laoSangamMN12())
    
    func configure<U>(with value: U) where U : Hashable {
        guard let value: Videos = value as? Videos else { return }
        imageView.image = UIImage(named: value.image)
        name.text = value.name
        type.text = value.type
        desc.text = value.description
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
        
        self.layer.cornerRadius = 2
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecommendedVideosCell {
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        type.translatesAutoresizingMaskIntoConstraints = false
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.numberOfLines = 6
        
        addSubview(imageView)
        addSubview(name)
        addSubview(type)
        addSubview(desc)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            name.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            
        ])
        
        NSLayoutConstraint.activate([
            type.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 1),
            type.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            
        ])
        
        NSLayoutConstraint.activate([
            desc.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            desc.leadingAnchor.constraint(equalTo: type.leadingAnchor),
            desc.heightAnchor.constraint(equalToConstant: 50),
            desc.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct RecommendedVideosCellProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<RecommendedVideosCellProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: RecommendedVideosCellProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<RecommendedVideosCellProvider.ContainerView>) {
            
        }
    }
}
