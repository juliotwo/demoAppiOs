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
import FirebaseAuth
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
        getdata()
        NotificationCenter.default.addObserver(self, selector: #selector(getdata), name: Notification.Name("AddedNewData"), object: nil)
    }
    @objc private func getdata(){
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("transactions")
            .whereField("ownerId", isEqualTo: uid)
            .order(by: "date",descending: true)
            .addSnapshotListener { [weak self] (snapshot, error) in
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
                    transaction.firebaseId = snapshot.documentID
                    self.items.append(transaction)
                    
                })
                self.delegate?.reloadData()
        }
    }
    func item(at indexPath: IndexPath) -> TransactionViewModel {
        return TransactionViewModel(transaction: items[indexPath.row])
    }
    func remove(at indexpath: IndexPath) {
        let item = items.remove(at: indexpath.row)
        guard let firebaseId = item.firebaseId else{
            return
        }
        db.collection("transactions").document(firebaseId).delete()
    }
    
}
class TransactionViewModel {
    private var transaction: DemoAppCore.Transaction
    
    var name: String{
        return transaction.name
    }
    var value: String{
        return transaction.value.currency()
    }
    var date: String{
        let formatter = DateFormatter()
        formatter.dateFormat="dd-MM-yyy"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: transaction.date)
    }
    var time: String{
        let formatter = DateFormatter()
        formatter.dateFormat="hh:mm"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: transaction.date)
    }
    init(transaction:DemoAppCore.Transaction) {
        self.transaction = transaction
    }
    
    
}
