//
//  TransactionsViewModel.swift
//  DemoApp
//
//  Created by julio vargas bautista on 7/9/19.
//  Copyright © 2019 Platzi. All rights reserved.
//

import Foundation
import FirebaseFirestore
import DemoAppCore
protocol TransactionViewModelDelegate {
    func reloadData()
}
class TransactionsViewModel {
    private var items: [DemoAppCore.Transaction] = []
    
    private var db: Firestore {
        let db = Firestore.firestore()
        let settings = db.settings
        settings.isPersistenceEnabled = true
        db.settings = settings
        return db
    }
    
    var numberOfitems: Int {
        return items.count
    }
    
    var delegate: TransactionViewModelDelegate?
    
    init() {
        db.collection("transactions").getDocuments { [weak self] (snapshot, error) in
            guard let self = self else{
            return
            }
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.items.removeAll()
            
            try? snapshot?.documents.forEach({ (snapshot) in
                let json = snapshot.data()
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                
                guard let transaction = try? JSONDecoder().decode(Transaction.self, from: jsonData) else {
                    return
                }
                
                self.items.append(transaction)
                self.delegate?.reloadData()
            })
        }
    }
}
