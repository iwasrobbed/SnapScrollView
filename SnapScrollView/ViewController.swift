//
//  ViewController.swift
//  SnapScrollView
//
//  Created by Rob Phillips on 6/19/17.
//  Copyright © 2017 ChefBrain Inc. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Instantiation
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        _setupView()
    }

    // MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _setupScrollSnapping()
    }
    
    // MARK: - Private View Properties
    
    fileprivate lazy var headerView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    fileprivate lazy var scrollingView: CollectionView = { [unowned self] in
        return CollectionView(viewToFade: self.headerView)
    }()
    
    // MARK: - Unsupported Initializers
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}

// MARK: - Private API

fileprivate extension ViewController {
    
    // MARK: - View Setup
    
    func _setupView() {
        view.addSubview(headerView)
        view.addSubview(scrollingView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.right.equalTo(view)
            make.height.equalTo(200)
        }
        
        scrollingView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    // MARK: - Scroll Snapping
    
    func _setupScrollSnapping() {
        let headerHeight = headerView.frame.size.height // If your header height is driven by autolayout, you'll need to check it here once it's been laid out in viewDidLayoutSubviews
        let topInset = headerHeight
        
        // Calculate if we need to scroll at all for larger screens
        let collectionViewContentHeight = scrollingView.collectionViewLayout.collectionViewContentSize.height
        let contentHeight = headerHeight + collectionViewContentHeight
        let isContentShorterThanScreen = contentHeight + 15 /* extra padding */ < UIScreen.main.bounds.size.height
        let bottomInset = headerHeight
        
        scrollingView.setup(topOffset: topInset, bottomOffset: isContentShorterThanScreen ? 0 : bottomInset, scrollView: scrollingView)
    }
    
}

