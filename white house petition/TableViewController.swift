//
//  ViewController.swift
//  white house petition
//
//  Created by Darren on 7/9/17.
//  Copyright © 2017 Darren. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController  {

    var petitions = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        if let url = URL(string: urlString){
            
            if let data = try? Data(contentsOf: url){
            
            let json = JSON(data)
                
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    
                    //ok to parse
                    parse(json: json)
                }
                
            }
            
        }
        
        
        
        
    }

    func parse(json:JSON){
        
        for result in json["results"].arrayValue{
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title": title, "body": body, "signature Count": sigs]
            
            petitions.append(obj)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // since the dictionary is an array of dictionaries, we need to pick the first dictionary
        //  which is the first indexPath whcih is 1 and add it in.
        //let petition = petitions[indexPath.row]
        cell.textLabel?.text = "title"
        cell.detailTextLabel?.text = "body"
        return cell
    }
    
    
    
}

