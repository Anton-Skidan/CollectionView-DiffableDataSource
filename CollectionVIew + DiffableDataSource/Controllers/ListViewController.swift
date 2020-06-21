//
//  ViewController.swift
//  CollectionVIew + DiffableDataSource
//
//  Created by Антон Скидан on 20.06.2020.
//  Copyright © 2020 Anton Skidan. All rights reserved.
//

import UIKit
class ListViewController: UIViewController {
    
   
    var collectionView: UICollectionView!
    let allVideos = Bundle.main.decode([Videos].self, from: "videos.json")
    let recommendedVideos = Bundle.main.decode([Videos].self, from: "recommended videos.json")
    var dataSource: UICollectionViewDiffableDataSource<Section, Videos>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupCollectionView()
        createDataSource()
        reloadData(searchText: nil)
    }
    
    enum Section: Int, CaseIterable {
        case recommendedVideos
        case videos
        
        
        func description() -> String {
            switch self {
            case .recommendedVideos:
                return "Recommended Videos"
            case .videos:
                return "All Videos"
            }
        }
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.8953681588, green: 0.8053836823, blue: 0.9332148433, alpha: 1)
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.8953681588, green: 0.8053836823, blue: 0.9332148433, alpha: 1)
        view.addSubview(collectionView)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        collectionView.register(VideosCell.self, forCellWithReuseIdentifier: VideosCell.reuseId)
        collectionView.register(RecommendedVideosCell.self, forCellWithReuseIdentifier: RecommendedVideosCell.reuseId)
        
    }
    
}

// MARK: - DataSource + reloadData
extension ListViewController {
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Videos>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, videos) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .videos:
                return self.configure(collectionView: collectionView, cellType: VideosCell.self,with: videos, for: indexPath)
            case .recommendedVideos:
                return self.configure(collectionView: collectionView, cellType: RecommendedVideosCell.self,with: videos, for: indexPath)
            }
        })
        
        dataSource?.supplementaryViewProvider = {
            collectionView,kind, indexPath in
            
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { fatalError("Can not create new section header")}
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind")}
            
            
            sectionHeader.configure(text: section.description(), font: .laoSangamMN22(), textColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
            return sectionHeader
        }
    }
    
    private func reloadData(searchText: String?) {
            let filtered = allVideos.filter { (video) -> Bool in
            video.contains(filter: searchText)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Videos>()
        snapshot.appendSections([.recommendedVideos, .videos])
        snapshot.appendItems(recommendedVideos, toSection: .recommendedVideos)
        snapshot.appendItems(filtered, toSection: .videos)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - SetupCompositionalLayout
extension ListViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .videos:
                return self.createVideos()
            case .recommendedVideos:
                return self.createRecommendedVideos()
            }
            
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    private func createVideos() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(84))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createRecommendedVideos() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 15
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadData(searchText: searchText)
    }
}

// MARK: - SwiftUI
import SwiftUI

struct ListVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ListVCProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: ListVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ListVCProvider.ContainerView>) {
            
        }
    }
}

