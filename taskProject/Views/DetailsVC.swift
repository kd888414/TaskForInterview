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
    var newsURL = String()

    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: newsURL) else { return }
        webVW.load(URLRequest(url: url))
    }
}
