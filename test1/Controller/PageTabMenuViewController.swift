//
//  PageTabMenuViewController.swift
//  PageMenuExample
//
//  Created by Tamanyan on 3/7/17.
//  Copyright © 2017 Tamanyan. All rights reserved.
//

import UIKit
import SwiftPageMenu

class PageTabMenuViewController: PageMenuController {

    

    let titles: [String]

    init( titles: [String], options: PageMenuOptions? = nil) {
        
        self.titles = titles
        super.init(options: options)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       

        
        
        self.edgesForExtendedLayout = []
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1) // your colour here

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]


        if options.layout == .layoutGuide && options.tabMenuPosition == .bottom {
            self.view.backgroundColor = .red
        } else {
            self.view.backgroundColor = UIColor(red: 0.506, green: 0.384, blue: 0.976, alpha: 1)
        }

        if self.options.tabMenuPosition == .custom {
            self.view.addSubview(self.tabMenuView)
            self.tabMenuView.translatesAutoresizingMaskIntoConstraints = false

            self.tabMenuView.heightAnchor.constraint(equalToConstant: self.options.menuItemSize.height).isActive = true
            self.tabMenuView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            self.tabMenuView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            if #available(iOS 11.0, *) {
                self.tabMenuView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            } else {
                self.tabMenuView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            }
        }

        self.delegate = self
        self.dataSource = self
    }
}

extension PageTabMenuViewController: PageMenuControllerDataSource {
    func viewControllers(forPageMenuController pageMenuController: PageMenuController) -> [UIViewController] {
        return [HomeViewController.makeSelf(),HomeViewController.makeSelf(),UIViewController(),UIViewController()]
    }

    func menuTitles(forPageMenuController pageMenuController: PageMenuController) -> [String] {
        return self.titles
    }

    func defaultPageIndex(forPageMenuController pageMenuController: PageMenuController) -> Int {
        return 0
    }
}

extension PageTabMenuViewController: PageMenuControllerDelegate {
    func pageMenuController(_ pageMenuController: PageMenuController, didScrollToPageAtIndex index: Int, direction: PageMenuNavigationDirection) {
        // The page view controller will begin scrolling to a new page.
//        print("didScrollToPageAtIndex index:\(index)")
    }

    func pageMenuController(_ pageMenuController: PageMenuController, willScrollToPageAtIndex index: Int, direction: PageMenuNavigationDirection) {
        // The page view controller scroll progress between pages.
//        print("willScrollToPageAtIndex index:\(index)")
    }

    func pageMenuController(_ pageMenuController: PageMenuController, scrollingProgress progress: CGFloat, direction: PageMenuNavigationDirection) {
        // The page view controller did complete scroll to a new page.
//        print("scrollingProgress progress: \(progress)")
    }

    func pageMenuController(_ pageMenuController: PageMenuController, didSelectMenuItem index: Int, direction: PageMenuNavigationDirection) {
//        print("didSelectMenuItem index: \(index)")
    }
}
