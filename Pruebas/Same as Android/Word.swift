//
//  Word.swift
//  Pruebas
//
//  Created by Julio Banda on 08/06/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class Word {
    
    /** Default translation for the word */
    let mDefaultTranslation: String;
    
    /** Spanish translation for the word */
    let mSpanishTranslation: String;
    
    /** Resource ID from image to show */
    var mImageResourceId: UIImage?;
    
    init(mDefaultTranslation: String, mSpanishTranslation: String) {
        self.mDefaultTranslation = mDefaultTranslation;
        self.mSpanishTranslation = mSpanishTranslation;
    }
    
    init(mDefaultTranslation: String, mSpanishTranslation: String, mImageResourceId: UIImage) {
        self.mDefaultTranslation = mDefaultTranslation;
        self.mSpanishTranslation = mSpanishTranslation;
        self.mImageResourceId = mImageResourceId;
    }
    
}
