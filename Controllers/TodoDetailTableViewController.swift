//
//  TodoDetailTableViewController.swift
//  Todo
//
//  Created by Arthit Thongpan on 27/3/2564 BE.
//

import UIKit

class TodoDetailTableViewController: UITableViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var createAtLabel: UILabel!
    
    var todo: Todo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        if let imageData = todo.image {
            imageView.image = imageData
            imageView.isHidden = false
        } else {
            imageView.isHidden = true
        }
        
        descriptionLabel.text = todo.description
        createAtLabel.text = todo.displayCreateAt ?? "-"
    }

}
