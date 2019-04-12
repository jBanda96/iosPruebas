//
//  NoticeRouter.swift
//  Pruebas
//
//  Created by Julio Banda on 4/10/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

class NoticeRouter: PresenterToRouterProtocol {
    static func createModule() -> NoticeViewController {
        
        let view = storyboard.instantiateInitialViewController() as! NoticeViewController
        
        let presenter:  ViewToPresenterProtocol & InteractorToPresenterProtocol = NoticePresenter()
        let interactor: PresenterToInteractorProtocol                           = NoticeInteractor()
        let router:     PresenterToRouterProtocol                               = NoticeRouter()
        
        view.presenter          = presenter
        presenter.interactor    = interactor
        presenter.router        = router
        presenter.view          = view
        interactor.presenter    = presenter
        
        return view
    }
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "VIPER", bundle: nil)
    }
    
    func pushToMovieScreen(navigationController: UINavigationController) {
        
    }
}
