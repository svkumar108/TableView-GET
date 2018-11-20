//
//  ViewController.swift
//  TableViewGET
//
//  Created by sivakumar on 20/11/18.
//  Copyright © 2018 sivakumar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var appNamesArray:[String] = []
    var appImgArray:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getData()
    
    }
    
    func getData(){
        
        let myURL = "https://rss.itunes.apple.com/api/v1/in/ios-apps/top-free/all/10/explicit.json"
        
        Alamofire.request(myURL, method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                
                let data:JSON = JSON(response.result.value!)
                let resultArray = data["feed"]["results"]
                
                
                for i in 0..<resultArray.count{
                    let namesArray = resultArray[i]["name"].string
                    self.appNamesArray.append(namesArray!)
                    let imgArray = resultArray[i]["artworkUrl100"].string
                    self.appImgArray.append(imgArray!)
                    
                    self.tableView.reloadData()
                    print(imgArray!)
                   
                }
               
              //  print(self.appNamesArray)
               
               
                
            }else{
                print("error")
            }
            
           
        }
        
        
    
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return appNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.myLabel.text = self.appNamesArray[indexPath.row]
        cell.imgView.image = UIImage(data: try! Data(contentsOf: URL(string: appImgArray[indexPath.row])!))
        
        
        
           return cell
    }


}

