//
//  VideosCell.swift
//  CollectionVIew + DiffableDataSource
//
//  Created by Антон Скидан on 20.06.2020.
//  Copyright © 2020 Anton Skidan. All rights reserved.
//

import UIKit


class VideosCell: UICollectionViewCell, SelfConfCell {
    
    static var reuseId: String = "VideosCell"
    let imageView = UIImageView()
    let name = UILabel(text: "Name", font: .laoSangamMN22())
    let type = UILabel(text: "Type", font: .laoSangamMN18())
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

extension VideosCell {
    
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
            imageView.heightAnchor.constraint(equalToConstant: 84),
            imageView.widthAnchor.constraint(equalToConstant: 78)
        ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            name.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: desc.leadingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            type.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            type.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            type.trailingAnchor.constraint(equalTo: desc.leadingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            desc.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -15),
            desc.leadingAnchor.constraint(equalTo: name.trailingAnchor,constant: 15),
            desc.heightAnchor.constraint(equalToConstant: 84),
            desc.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
// MARK: - SwiftUI
import SwiftUI

struct VideosCellProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<VideosCellProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: VideosCellProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<VideosCellProvider.ContainerView>) {
            
        }
    }
}
