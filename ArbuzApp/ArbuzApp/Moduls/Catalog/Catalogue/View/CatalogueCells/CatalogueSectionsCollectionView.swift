//
//  PosterCollectionView.swift
//  ArbuzApp
//
//  Created by Tommy on 5/20/23.
//

import UIKit
import SnapKit

class CatalogueSectionsCollectionView: UITableViewCell {
    
    var presenter: CataloguePresenterProtocol!
    var products: [String: [Product]]?
    let sections = ["Молочные продукты", "Фрукты", "Овощи"]
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
            
            let supplementaryViews  = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(50)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
            ]
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.4),
                    heightDimension: .absolute(200)),
                subitem: item,
                count: 1)

            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryViews

            return section
    }))

    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        contentView.layer.masksToBounds = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup views and constraints
    
    func setupUI() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CatalogueSectionsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let continent = presenter.categoryProducts!.keys.sorted()[section]
        return presenter.categoryProducts![continent]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: presenter.getModel(by: indexPath))
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.categoryProducts!.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as! SectionHeader
            sectionHeader.label.text = sections[indexPath.section]
                return sectionHeader
            } else {
                 return UICollectionReusableView()
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.cellTappedAt(indexPath)
    }
}
