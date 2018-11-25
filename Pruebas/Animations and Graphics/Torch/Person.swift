//
//  Person.swift
//  Pruebas
//
//  Created by Julio Banda on 11/18/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import Foundation

struct Person {
    
    let name:   String
    let age:    Int
    let image:  UIImage
    
}

let people: [Person] = [
    Person(name: "Irais Krystell",      age: 21,    image: #imageLiteral(resourceName: "person0")),
    Person(name: "Viridiana Ortega",    age: 25,    image: #imageLiteral(resourceName: "person1")),
    Person(name: "Adriana Aguilar",     age: 23,    image: #imageLiteral(resourceName: "person2.jpg")),
    Person(name: "Julio Banda",         age: 23,    image: #imageLiteral(resourceName: "person3")),
    Person(name: "Ricardo Sámano",      age: 23,    image: #imageLiteral(resourceName: "person4"))
]
