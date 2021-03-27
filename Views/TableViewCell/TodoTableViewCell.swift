//
//  TodoTableViewCell.swift
//  Todo
//
//  Created by Arthit Thongpan on 27/3/2564 BE.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var createAtLabel: UILabel!
    
    var todo: Todo! {
        didSet {
            if let image = todo.image {
                photoImageView.image = image
                photoImageView.isHidden = false
            }
            descLabel.text = todo.description
            createAtLabel.text = todo.displayCreateAt ?? "-"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        photoImageView.isHidden = true
        descLabel.text = nil
        createAtLabel.text = nil
    }
}
