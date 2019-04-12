//
//  NoticePresenter.swift
//  Pruebas
//
//  Created by Julio Banda on 4/10/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

class NoticePresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingNotice() {
        interactor?.fetchNotice()
    }
    
    func showMovieController(navigationController: UINavigationController) {
        router?.pushToMovieScreen(navigationController: navigationController)
    }
    
}

extension NoticePresenter: InteractorToPresenterProtocol {
    func noticeFetchedSuccess(noticeModelArray: Array<NoticeModel>) {
        view?.showNotice(noticeArray: noticeModelArray)
    }
    
    func noticeFetchFailed() {
        view?.showError()
    }
}
