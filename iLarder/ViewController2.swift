//
//  ViewController.swift
//  SwiftExample
//
//  Created by Belal Khan on 18/11/17.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit
import SQLite3

class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    var db: OpaquePointer?
    var productList = [Product]()
    
    @IBOutlet weak var tableViewProducts: UITableView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldRemaning: UITextField!
    
    @IBAction func buttonSave(_ sender: UIButton) {
        let name = textFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let remaning = textFieldRemaning.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(name?.isEmpty)!{
            textFieldName.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(remaning?.isEmpty)!{
            textFieldName.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        var stmt: OpaquePointer?
        
        let queryString = "INSERT INTO Product (name, remaning) VALUES (?,?)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_double(stmt, 2, (remaning! as NSString).doubleValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }

        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting product: \(errmsg)")
            return
        }
        
        textFieldName.text=""
        textFieldRemaning.text=""
        
        readValues()

        print("Product saved successfully")
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let product: Product
        product = productList[indexPath.row]
        cell.textLabel?.text = product.name
        return cell
    }
    
    
    func readValues(){
        productList.removeAll()

        let queryString = "SELECT * FROM Product"
        
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let rate = sqlite3_column_double(stmt, 2)
            let remanings = sqlite3_column_int(stmt, 3)
            
            productList.append(Product(id: Int(id), name: String(describing: name), rate: Double(rate), remaning: Int(remanings) ))
        }
        
        self.tableViewProducts.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("ProductDatabase.sqlite")
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Product (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, remaning DOUBLE, rate INTEGER)", nil, nil, nil ) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        readValues()
    }
}

