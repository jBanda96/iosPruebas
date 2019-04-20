//
//  PageViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/18/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let pets = PetsStore.pets
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        setViewControllers([viewControllerForPage(at: 0)], direction: .forward, animated: false, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CustomCardViewController,
            let pageIndex = viewController.index,
            pageIndex > 0 else { return nil }
        
        return viewControllerForPage(at: pageIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CustomCardViewController,
            let pageIndex = viewController.index,
            pageIndex + 1 < pets.count else { return nil }
        
        return viewControllerForPage(at: pageIndex + 1)
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pets.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let viewControllers = pageViewController.viewControllers,
            let currentVC = viewControllers.first as? CustomCardViewController,
            let currentPageIndex = currentVC.index else {
                return 0
        }
        return currentPageIndex
    }
    
    func viewControllerForPage(at index: Int) -> UIViewController {
        let viewController = UIStoryboard.init(name: "CustomTransition", bundle: nil).instantiateViewController(withIdentifier: "CustomCardViewController") as? CustomCardViewController
        
        viewController?.index = index
        viewController?.pet = pets[index]
        
        return viewController!
    }

}
