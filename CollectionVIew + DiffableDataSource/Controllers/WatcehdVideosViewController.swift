//
//  PeopleViewController.swift
//  CollectionVIew + DiffableDataSource
//
//  Created by Антон Скидан on 20.06.2020.
//  Copyright © 2020 Anton Skidan. All rights reserved.
//

import UIKit

class WatchedVideosViewController: UIViewController {
    
    let watchedVideos = Bundle.main.decode([WatchedVideos].self, from: "watched videos.json")
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,WatchedVideos>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupCollectionView()
        createDataSource()
        reloadData(searchText: nil)
        setupSearchBar()
        
    }
    
    enum Section: Int, CaseIterable {
        case watchedVideos
        
        func description(videosCount: Int) -> String {
            switch self {
                
            case .watchedVideos:
                return "\(videosCount) videos watched"
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.8953681588, green: 0.8053836823, blue: 0.9332148433, alpha: 1)
        view.addSubview(collectionView)
        
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        collectionView.register(WatchedVideosCell.self, forCellWithReuseIdentifier: WatchedVideosCell.reuseId)
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.905806601, green: 0.9178900719, blue: 0.9583516717, alpha: 1)
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
}

//MARK: - SetupCompositionalLayout
extension WatchedVideosViewController {
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .watchedVideos:
                return self.createWatchedVideosSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    private func createWatchedVideosSection() -> NSCollectionLayoutSection{
        let spacing = CGFloat(15)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 15, bottom: 0, trailing: 15)
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
// MARK: - DataSource + reloadData
extension WatchedVideosViewController {
    
    private func createDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section,WatchedVideos>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, video) -> UICollectionViewCell? in
            
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .watchedVideos:
                return self.configure(collectionView: collectionView, cellType: WatchedVideosCell.self, with: video, for: indexPath)
            }
        })
        dataSource?.supplementaryViewProvider = {
            collectionView,kind, indexPath in
            
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { fatalError("Can not create new section header")}
            
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind")}
            
            let items = self.dataSource.snapshot().itemIdentifiers(inSection: .watchedVideos)
            sectionHeader.configure(text: section.description(videosCount: items.count), font: .avenir24(), textColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
            return sectionHeader
        }
    }
    private func reloadData(searchText: String?) {
        
        let filtered = watchedVideos.filter { (video) -> Bool in
            video.contains(filter: searchText)
        }
        var snapshot = NSDiffableDataSourceSnapshot<Section, WatchedVideos>()
        snapshot.appendSections([.watchedVideos])
        snapshot.appendItems(filtered, toSection: .watchedVideos)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UISearchBarDelegate
extension WatchedVideosViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadData(searchText: searchText)
    }
}


// MARK: - SwiftUI
import SwiftUI

struct PeopleVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<PeopleVCProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: PeopleVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PeopleVCProvider.ContainerView>) {
            
        }
    }
}
