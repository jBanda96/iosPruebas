//
//  Protocols.swift
//  Pruebas
//
//  Created by Julio Banda on 4/10/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

protocol ViewToPresenterProtocol: class {
    var view:       PresenterToViewProtocol? { get set }
    var interactor: PresenterToInteractorProtocol? { get set }
    var router:     PresenterToRouterProtocol? { get set }
    
    func startFetchingNotice()
    func showMovieController(navigationController: UINavigationController)
}

protocol PresenterToViewProtocol: class {
    func showNotice(noticeArray: Array<NoticeModel>)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule() -> NoticeViewController
    func pushToMovieScreen(navigationController: UINavigationController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? { get set }
    
    func fetchNotice()
}

protocol InteractorToPresenterProtocol: class {
    func noticeFetchedSuccess(noticeModelArray: Array<NoticeModel>)
    func noticeFetchFailed()
}
