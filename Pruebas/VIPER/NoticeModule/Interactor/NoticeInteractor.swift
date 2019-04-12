//
//  NoticeInteractor.swift
//  Pruebas
//
//  Created by Julio Banda on 4/10/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

class NoticeInteractor: PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    
    func fetchNotice() {
        presenter?.noticeFetchedSuccess(noticeModelArray: [NoticeModel(id: "1", title: "idk", brief: "brief", filesource: "fs")])
        //presenter?.noticeFetchFailed()
    }
}
