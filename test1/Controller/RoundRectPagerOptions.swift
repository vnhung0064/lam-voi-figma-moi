//
//  RoundRectPageMenuOptions.swift
//  PageMenuExample
//
//  Created by Tamanyan on 3/10/29 H.
//  Copyright © 29 Heisei Tamanyan. All rights reserved.
//

import Foundation
import SwiftPageMenu
import UIKit

struct RoundRectPagerOption: PageMenuOptions {

    var isInfinite: Bool = false

    var tabMenuPosition: TabMenuPosition = .top

    var menuItemSize: PageMenuItemSize {
        return .sizeToFit(minWidth: 80, height: 30)
    }

    var menuTitleColor: UIColor {
        return .systemBackground
    }

    var menuTitleSelectedColor: UIColor {
        return .blue
    }

    var menuCursor: PageMenuCursor {
        return .roundRect(rectColor: .white, cornerRadius: 16, height: 32, borderWidth: nil, borderColor: nil)
    }

    var font: UIFont {
        return UIFont.systemFont(ofSize: UIFont.systemFontSize)
    }

    var menuItemMargin: CGFloat {
        return 8
    }

    var tabMenuBackgroundColor: UIColor {
        return UIColor(red: 0.506, green: 0.384, blue: 0.976, alpha: 1)
    }

    var tabMenuContentInset: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }

    public init(isInfinite: Bool = false, tabMenuPosition: TabMenuPosition = .top) {
        self.isInfinite = isInfinite
        self.tabMenuPosition = tabMenuPosition
    }
}
