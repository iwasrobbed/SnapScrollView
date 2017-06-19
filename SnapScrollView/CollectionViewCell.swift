//
//  CollectionViewCell.swift
//  SnapScrollView
//
//  Created by Rob Phillips on 6/19/17.
//  Copyright © 2017 ChefBrain Inc. All rights reserved.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Instantiation
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        _setupView()
    }
    
    // MARK: - Constants
    
    static let cellReuseIdentifier = "CollectionViewCell"
    static var cellHeight: CGFloat { return 85 }
    
    // MARK: - Unsupported Initializers
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}

// MARK: - Private API

fileprivate extension CollectionViewCell {
    
    // MARK: - View Setup
    
    func _setupView() {
        backgroundColor = .purple
    }
    
}
