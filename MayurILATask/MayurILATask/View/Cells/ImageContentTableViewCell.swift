//
//  ImageContentTableViewCell.swift
//  MayurILATask
//
//  Created by Neosoft on 16/05/22.
//

import UIKit

class ImageContentTableViewCell: UITableViewCell {

    //MARK: - IBOutlets -
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imgContent: UIImageView!
    
    //MARK: - Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(data: ListData) {
        labelTitle.text = data.title
        imgContent.image = UIImage(named: data.thumbnailImage)
    }
}
