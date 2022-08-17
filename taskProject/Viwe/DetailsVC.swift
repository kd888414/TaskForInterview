//
//  DetailsVC.swift
//  taskProject
//
//  Created by apple on 16/08/22.
//

import UIKit
import WebKit

class DetailsVC: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var webVW: WKWebView!
    
    //MARK:- Constants and Variables
    var selectedImgURL = String()

    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webVW.load(URLRequest(url: URL(string: selectedImgURL)!))
    }
}
