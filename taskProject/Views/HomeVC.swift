//
//  HomeVC.swift
//  taskProject
//
//  Created by apple on 16/08/22.
//

import UIKit
import Alamofire
import SDWebImage

class HomeVC: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var listTblVW: UITableView!
    
    //MARK:- Constants and Variables
    var arrData = [Article]()
    var refreshControl = UIRefreshControl()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        callApi()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        listTblVW.addSubview(refreshControl)
    }
    
    //MARK:- Additional Functions
    @objc func refresh(_ sender: AnyObject) {
        callApi()
        refreshControl.endRefreshing()
    }
    
    func callApi() {
        showActivityIndicator()
        let urlStr = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=d005f9379b2942008bd6526da475d46f"
        AF.request(urlStr, method: .get).responseJSON{ response in
            self.hideActivityIndicator()
            guard let data = response.data else { return }
            do {
                let responseData = try JSONDecoder().decode(DataModel.self, from: data)
                self.arrData = responseData.articles
                DispatchQueue.main.async {
                    self.listTblVW.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
   
}

//MARK:- UITableViewDelegate And UITableViewDataSource
extension HomeVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listTblVW.dequeueReusableCell(withIdentifier: "ListTVC", for: indexPath) as? ListTVC else {
            return UITableViewCell()
        }
        cell.lblTtitle.text = "Title:  \(arrData[indexPath.row].title )"
        cell.contentLbl.text = "News: \(arrData[indexPath.row].content )"
        cell.authorLbl.text = "Author: \(arrData[indexPath.row].author )"
        cell.img.sd_setImage(with: URL(string: arrData[indexPath.row].urlToImage ))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "DetailsVC") as? DetailsVC else { return }
        nextVC.newsURL = arrData[indexPath.row].url
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        activityIndicator.tag = 100
        for subview in view.subviews {
            if subview.tag == 100 {
                print("already added")
                return
            }
        }
        view.addSubview(activityIndicator)
    }

    func hideActivityIndicator() {
        let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView
        view.isUserInteractionEnabled = true
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
    }
}
