//
//  ListTVC.swift
//  taskProject
//
//  Created by apple on 16/08/22.
//

import UIKit

class ListTVC: UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var cardVw: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTtitle: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView(view: cardVw, corner: 8, shadow: 2)
    }
    
    func shadowView(view: UIView,corner: CGFloat,shadow: CGFloat){
        view.layer.cornerRadius = corner
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = shadow
    }
}


