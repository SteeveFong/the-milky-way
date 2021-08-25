//
//  UIScrollView.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/21.
//

import UIKit

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
