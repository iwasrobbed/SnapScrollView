//
//  UIScrollView+ChefBrain.swift
//  ChefBrain
//
//  Created by Rob Phillips on 4/16/17.
//  Copyright © 2017 ChefBrain Inc. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    /// Insets the scroll view and it's scroll indicator by the given amount, 
    /// overwriting any existing values
    ///
    /// - Parameters:
    ///   - topOffset: the offset for the top of the scroll view
    ///   - bottomOffset: the offset for the bottom of the scroll view
    func cb_insetScrollView(topOffset: CGFloat = 0, bottomOffset: CGFloat = 0) {
        var contentInsets = contentInset
        contentInsets.top = topOffset
        contentInsets.bottom = bottomOffset
        contentInset = contentInsets
        
        var indicatorInsets = scrollIndicatorInsets
        indicatorInsets.top = topOffset
        indicatorInsets.bottom = bottomOffset
        scrollIndicatorInsets = indicatorInsets
    }
    
}
