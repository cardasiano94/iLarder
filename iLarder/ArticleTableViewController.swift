//
//  ArticleTableViewController.swift
//  iLarder
//
//  Created by Cristobal Galleguillos on 06-12-17.
//  Copyright © 2017 URSis. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    
    @IBAction func addProduct(_ sender: Any) {
        var Name: UITextField?
        var Remaning: UITextField?
        var Rate: UITextField?
        
        let alertController = UIAlertController(
            title: "Nuevo Articulo",
            message: "Ingresar datos del articulo",
            preferredStyle: UIAlertControllerStyle.alert)
        
        let addAction = UIAlertAction(
        title: "Agregar", style: UIAlertActionStyle.default){
            (action) -> Void in
        }
        
        
        alertController.addTextField{(textField: UITextField) in
            textField.placeholder = "Nombre"
        }
        alertController.addTextField{(textField: UITextField) in
            textField.placeholder = "Cantidad"
        }
        alertController.addTextField{(textField: UITextField) in
            textField.placeholder = "Consumo"
        }
        alertController.addAction(addAction)
        self.present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //code to execute on click
    }

}
