//
//  CollectionView.swift
//  SnapScrollView
//
//  Created by Rob Phillips on 6/19/17.
//  Copyright © 2017 ChefBrain Inc. All rights reserved.
//

import UIKit

final class CollectionView: UICollectionView, OffsetableScrollingView {
    
    // MARK: - Lifecycle
    
    init(viewToFade: UIView) {
        self.viewToFade = viewToFade
        
        super.init(frame: .zero, collectionViewLayout: CollectionViewLayout())
        
        _setupView()
    }
    
    // MARK: - OffsetableScrollingView
    
    var isScrollingToTop = false
    
    // MARK: - Private Properties
    
    fileprivate let viewToFade: UIView
    
    // MARK: - Unsupported Initializers
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}

// MARK: - OffsetableScrollingView

extension CollectionView {
    
    func scrollToTop(_ scrollView: UIScrollView) {
        isScrollingToTop = true
        scrollView.setContentOffset(CGPoint(x: 0, y: -scrollView.contentInset.top), animated: true)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.isScrollingToTop = false
    }
    
}

// MARK: - UIScrollViewDelegate

extension CollectionView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        fade(viewToFade, whenOffsetReachedIn: scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        snapToOffsetIfNecessary(scrollView)
    }
    
}

// MARK: - UICollectionViewDelegate

extension CollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        // Do something
    }
    
}

// MARK: - UICollectionViewDataSource

extension CollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellReuseIdentifier, for: indexPath) as! CollectionViewCell
    }
    
}

// MARK: - Private API

fileprivate extension CollectionView {
    
    // MARK: - View Setup
    
    func _setupView() {
        backgroundColor = .clear
        
        showsHorizontalScrollIndicator = false
        register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.cellReuseIdentifier)
        
        delegate = self
        dataSource = self
    }
    
}

// MARK: - CollectionViewLayout

final class CollectionViewLayout: UICollectionViewFlowLayout {
    
    // MARK: - Instantiation
    
    override init() {
        super.init()
        
        itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: CollectionViewCell.cellHeight)
        scrollDirection = .vertical
    }
    
    // MARK: - Unsupported Initializers
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
