//
//  TracksTableViewCell.swift
//  MyDocTask
//
//  Created by mahesh.varadara on 13/1/20.
//  Copyright © 2020 mahesh.varadara. All rights reserved.
//

import UIKit

class TracksTableViewCell: UITableViewCell {
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func updateLabel(data: PVMTracks) {
        labelTitle.text = data.artistName
        let image = ImageFromPath()
        let trackImage = image.getImageFromPath(imagePath: data.trackImage ?? "")
//        let imageUrl = URL(fileURLWithPath: data.trackImage ?? "")
//        let image = UIImage(contentsOfFile: imageUrl.path)
        trackImageView.image = trackImage
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
struct ImageFromPath {
    func getImageFromPath(imagePath: String?) -> UIImage? {
        let imageUrl = URL(fileURLWithPath: imagePath ?? "")
        let image = UIImage(contentsOfFile: imageUrl.path)
        return image
    }
}
