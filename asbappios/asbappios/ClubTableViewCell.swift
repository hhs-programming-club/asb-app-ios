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
    public var identifier: String = ""
    @IBOutlet weak var backImage: UIImageView!
    var imageDownloaded: Bool = false
    
    //https://firebasestorage.googleapis.com/v0/b/homesteadasbapp.appspot.com/o/images%2Fboba.jpg?alt=media&token=259bfa83-eeb4-435f-8ab9-c8abddd6d77d
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var innerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.text = "Club"
        
        let cornerRadiusSize = CGFloat.init(12)
        
        self.tintColor = UIColor.gray
        
        innerView.layer.cornerRadius = cornerRadiusSize
        innerView.clipsToBounds = true
        
        genreLabel.layer.cornerRadius = 4
        genreLabel.clipsToBounds = true
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blur.frame = bottomOverlay.bounds
        blur.frame = super.bounds
        blur.isUserInteractionEnabled = false
        bottomOverlay.insertSubview(blur, at: 0)
        self.isHidden = true
        
//        print(identifier)
        
        
    }
    
    func addImageURL(identifier: String)
    {
        
        let urlPath = "https://firebasestorage.googleapis.com/v0/b/homesteadasbapp.appspot.com/o/images%2F" + identifier + ".jpg?alt=media"
        
        let url = URL.init(string: urlPath)
        if(!self.imageDownloaded)
        {
        self.imageDownloaded = true
        downloadImage(from: url!)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
//        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.backImage.image = UIImage(data: data)
                self.isHidden = false
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
