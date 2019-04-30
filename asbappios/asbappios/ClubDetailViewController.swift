//
//  ClubDetailViewController.swift
//  asbappios
//
//  Created by David McAllister on 4/2/19.
//  Copyright © 2019 Programming Club. All rights reserved.
//

import UIKit

class ClubDetailViewController: UIViewController {

    @IBOutlet weak var clubTitleLabel: UILabel!
    var clubTitle: String = "dd"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clubTitleLabel.text = clubTitle
        navigationItem.title = clubTitle

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
