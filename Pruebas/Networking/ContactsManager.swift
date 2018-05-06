//
//  ContactsManager.swift
//  Pruebas
//
//  Created by Julio Banda on 06/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

typealias CompletionHandler = (_ success: Bool, _ contacts: [Contact]) -> ()
typealias CompletionHandlerUser = (_ success: Bool, _ contacts: Response) -> ()

class ContactsManager: NSObject {

    func fetchContacts(page: Int, pageSize: Int, handler: @escaping CompletionHandler) {
        
        let session = URLSession.shared
        
        if let url = URL(string: "https://randomuser.me/api/?page\(page)&result=\(pageSize)") {
         
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    return handler(false, [])
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    var success = false
                    var allContacts = [Contact]()
                    
                    if httpResponse.statusCode == 200 {
                        
                        if let responseData = data {
                            
                            do {
                                
                                let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? Dictionary<String, Any>
                                let contacts = self.parseContactsJSON(json: json!)
                                allContacts.append(contentsOf: contacts)
                                
                                success = true
                                
                                
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                        }
                        
                        handler(success, allContacts)
                        
                    }
                    
                }
                
            }
            
            dataTask.resume()
            
        }
        
    }
    
    func parseContactsJSON(json: Dictionary<String, Any>) -> [Contact] {
        var contacts = [Contact]()
        
        if let contactsJSON = json["results"] as? [Dictionary<String, Any>] {
            
            for contactObj in contactsJSON {
                let contact = Contact.init(json: contactObj)
                contacts.append(contact)
            }
        }
        
        return contacts
    }
    
    
    func downloadUsers(page: Int, pageSize: Int = 10, completionHandler: @escaping CompletionHandlerUser) {
        
        let url =  URL(string: "https://randomuser.me/api/?page\(page)&result=\(pageSize)")
        let session = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            print(String.init(data: data!, encoding: .utf8))
            
            do {
                completionHandler(true, try JSONDecoder().decode(Response.self, from: data!))
            } catch {
                print(error.localizedDescription)
            }
            
        }
        session.resume()
        
        
        
    }
    
}
