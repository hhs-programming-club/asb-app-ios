//
//  ClubTableViewCell.swift
//  asbappios
//
//  Created by David McAllister on 3/19/19.
//  Copyright © 2019 Programming Club. All rights reserved.
//

import UIKit

class ClubTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomOverlay: UIView!
    
    @IBOutlet weak var innerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.text = "Club"
        
        let cornerRadiusSize = CGFloat.init(12)
        
        self.tintColor = UIColor.gray
        
        innerView.layer.cornerRadius = cornerRadiusSize
        innerView.clipsToBounds = true
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
        blur.frame = bottomOverlay.bounds
        blur.isUserInteractionEnabled = false
        bottomOverlay.insertSubview(blur, at: 0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
