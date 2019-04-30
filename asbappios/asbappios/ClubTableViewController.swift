//
//  ClubTableViewController.swift
//  asbappios
//
//  Created by David McAllister on 3/19/19.
//  Copyright © 2019 Programming Club. All rights reserved.
//

import UIKit
import Firebase


class ClubTableViewController: UITableViewController {

    var clubList: [Dictionary<String, AnyObject>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = Firebase.Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
//        _ = imageRef.putData(data, metadata: nil, completion: { (metadata,error ) in
//            guard let metadata = metadata else{
//                print(error)
//                return
//            }
//            let downloadURL = metadata.path
//            print(downloadURL)
//        })
        
        db.collection("clubs").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
                    let data = (document.data() as NSDictionary)["clubs_names"] as! NSArray
                    
                    for club in data
                    {
//                        let club = club as Dictionary
                        let club = club as! NSDictionary
                        var dict = Dictionary<String, AnyObject>()
                        dict["name"] = club["name"] as! NSString
                        dict["genre"] = club["genre"] as! NSString
                        dict["identifier"] = club["identifier"] as! NSString
                        print(club["identifier"] as! NSString)
                        self.clubList.append(dict)
                    }
//                    print("dog")
                    self.tableView.reloadData()

                }
            }
        }
        
        
        
        if let path = Bundle.main.path(forResource: "clubjson", ofType: "json")
        {
            
                do {
                    print("Test")
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//
//                    if let jsonResult = jsonResult as! Dictionary<String, AnyObject>
//                    {
//
//
//
//                    }
                    
                    if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let data = jsonResult["data"] as? Dictionary<String, AnyObject> {
                        
                        // do stuff
//                        clubList = data["clubs"] as! [Dictionary<String, AnyObject>]
                        self.tableView.reloadData()
                        print("Read")
                    }
                } catch {
                    // handle error
                    print("Error info: \(error)")
                }
            
            
        }
        else
        {
            print("Bad path")
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.clubList.count < 2
        {
            return 0
        }
        return self.clubList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClubCell", for: indexPath) as! ClubTableViewCell
        
        let club = clubList[indexPath.row]
        
        cell.titleLabel.text = club["name"] as? String
        cell.genreLabel.text = " " + (club["genre"] as! String)
        cell.identifier = club["identifier"] as! String
        cell.addImageURL(identifier: club["identifier"] as! String)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Was selected at row: ")
        print(indexPath.item)
        let rowNum = indexPath.item
        
//        self.performSegue(withIdentifier: "clubDetailSegue")
//        self.navigationController?.performSegue(withIdentifier: "clubDetailSegue", sender: self)
        
//        var detailView = ClubDetailViewController()
//        detailView.clubTitle = "It works"
//        navigationController?.pushViewController(detailView, animated: true)
        
        self.performSegue(withIdentifier: "clubDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("the segue was received")
        let detailController = segue.destination as! ClubDetailViewController
        detailController.clubTitle = "it worked!"
        let indexPath = self.tableView.indexPathForSelectedRow
        let club = clubList[indexPath!.row]
        
        detailController.clubTitle = club["name"] as! String
        
//        if segue.identifier == "showDetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                let controller = segue.destination as! ViewControllerB
//                controller.selectedName = objects[indexPath.row]
//            }
//        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
