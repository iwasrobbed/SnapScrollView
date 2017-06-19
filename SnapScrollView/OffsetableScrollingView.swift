//
//  OffsettableScrollView.swift
//  ChefBrain
//
//  Created by Rob Phillips on 4/16/17.
//  Copyright © 2017 ChefBrain Inc. All rights reserved.
//

import UIKit

protocol OffsetableScrollingView {
    
    /// Sets up the scroll view by appending the top and bottom offset to the existing inset values
    /// 
    /// Note: the bottom inset should be set such that it allows the content to scroll over the top area
    ///
    /// - parameter topOffset:    The offset for the top of the scroll view
    /// - parameter bottomOffset: The offset for the bottom of the scroll view
    /// - parameter scrollView:   The scroll view to act upon
    func setup(topOffset: CGFloat, bottomOffset: CGFloat, scrollView: UIScrollView)
    
    /// Fades out the given view when the top offset is reached for the scroll view
    ///
    /// - parameter view:       The view to fade out
    /// - parameter scrollView: The scroll view to measure off of
    func fade(_ view: UIView, whenOffsetReachedIn scrollView: UIScrollView)
    
    /// Snaps the scroll view to the offset or to the top, if necessary
    ///
    /// - parameter scrollView: The scroll view to snap
    func snapToOffsetIfNecessary(_ scrollView: UIScrollView)
    
    // MARK: - Scrolling to Top
    
    /// Whether or not we are currently scrolling to top (and should therefore delay doing certain scroll-based actions)
    var isScrollingToTop: Bool { get set }
    
    /// Scrolls the given scroll view to top
    ///
    /// - parameter scrollView: A UIScrollview
    func scrollToTop(_ scrollView: UIScrollView)
}

extension OffsetableScrollingView {
    
    func setup(topOffset: CGFloat, bottomOffset: CGFloat, scrollView: UIScrollView) {
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.cb_insetScrollView(topOffset: topOffset, bottomOffset: bottomOffset)
    }
    
    func fade(_ view: UIView, whenOffsetReachedIn scrollView: UIScrollView) {
        let percentage = _offsetPercentage(scrollView)
        view.alpha = 1 - 1.8 * percentage // Fades out relatively quickly
        view.transform = CGAffineTransform(translationX: 0, y: percentage * 70)
    }
    
    func snapToOffsetIfNecessary(_ scrollView: UIScrollView) {
        let percentage = _offsetPercentage(scrollView)
        
        if percentage <= 0.4 {
            scrollToTop(scrollView)
        } else if percentage > 0.4 && percentage < 1 {
            // Snap it to the offset value (zero) with some padding
            scrollView.setContentOffset(CGPoint(x: 0, y: -10), animated: true)
        }
    }
    
    func scrollToTop(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: -scrollView.contentInset.top), animated: true)
    }
    
}

private extension OffsetableScrollingView {
    
    /// Pinned between 0 (not scrolled) and 1 (scrolled at or past the offset)
    func _offsetPercentage(_ scrollView: UIScrollView) -> CGFloat {
        let offset = scrollView.contentOffset.y
        guard offset <= 0 else { return 1 }
        
        let percentage = 1 - abs(offset) / scrollView.contentInset.top
        return max(0, min(percentage, 1))
    }
    
}
