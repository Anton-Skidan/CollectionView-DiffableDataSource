//
//  WatchedVideosCell.swift
//  CollectionVIew + DiffableDataSource
//
//  Created by Антон Скидан on 20.06.2020.
//  Copyright © 2020 Anton Skidan. All rights reserved.
//

import UIKit


class WatchedVideosCell: UICollectionViewCell, SelfConfCell {
    
    static var reuseId: String = "WatchedVideosCell"
       let imageView = UIImageView()
       let name = UILabel(text: "name", font: .laoSangamMN22())
       let type = UILabel(text: "Type", font: .avenir20())
       let containerView = UIView()
       
    func configure<U>(with value: U) where U : Hashable {
         guard let value: WatchedVideos = value as? WatchedVideos else { return }
                    imageView.image = UIImage(named: value.image)
                    name.text = value.name
                    type.text = value.type
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
        
        self.layer.cornerRadius = 2
        self.layer.shadowColor = #colorLiteral(red: 0.8542706966, green: 0.8357756138, blue: 0.9470306039, alpha: 1)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.layer.cornerRadius = 2
        self.containerView.clipsToBounds = true
    }
}

extension WatchedVideosCell {

private func setupConstraints() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    name.translatesAutoresizingMaskIntoConstraints = false
    type.translatesAutoresizingMaskIntoConstraints = false
    containerView.translatesAutoresizingMaskIntoConstraints = false

    addSubview(containerView)
    containerView.addSubview(imageView)
    containerView.addSubview(name)
    containerView.addSubview(type)

    
    
    NSLayoutConstraint.activate([
        containerView.topAnchor.constraint(equalTo: self.topAnchor),
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    NSLayoutConstraint.activate([
           imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
           imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
           imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
           imageView.heightAnchor.constraint(equalTo: containerView.widthAnchor, constant: -10)
               ])
    
    NSLayoutConstraint.activate([
    name.topAnchor.constraint(equalTo: imageView.bottomAnchor),
    name.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
    name.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
    name.bottomAnchor.constraint(equalTo: type.topAnchor)
        ])
    NSLayoutConstraint.activate([
              type.topAnchor.constraint(equalTo: name.bottomAnchor),
              type.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
              type.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
              type.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
                  ])
        }
    }

// MARK: - SwiftUI
import SwiftUI

struct WatchedVideosCellProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<WatchedVideosCellProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: WatchedVideosCellProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<WatchedVideosCellProvider.ContainerView>) {
            
        }
    }
}
