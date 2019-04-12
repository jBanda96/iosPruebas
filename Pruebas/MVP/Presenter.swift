//
//  Presenter.swift
//  Pruebas
//
//  Created by Julio Banda on 4/5/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class Presenter {
    
    var model = MVPModel(liked: false)
    
    var likedButtonTitle: String {
        return model.liked == true ? "Dislike" : "Like"
    }
    
    var color: UIColor {
        return model.liked == true ? .blue : .white
    }
    
    func updateLike() {
        model.liked = !model.liked
    }
    
}
