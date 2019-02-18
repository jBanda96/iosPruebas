//
//  MoreAppsViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 2/17/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class MoreAppsViewController: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!
}

extension MoreAppsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        print("Content offset: \(scrollView.contentOffset.x)\nPage width: \(pageWidth)")
        pageControl.currentPage = Int(scrollView.contentOffset.x / pageWidth)
    }
}
