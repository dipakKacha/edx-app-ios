//
//  FreeVideoListViewController.swift
//  edX
//
//  Created by Quixom Technology on 17/09/18.
//  Copyright © 2018 edX. All rights reserved.
//

import UIKit

class STBFreeVideoListViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var tvFreeVideos: UITableView!
    
    // MARK: Variables
    var courseId:String?
    var arrVideoList:[FreeVideoResults] = []
    
    // MARK: UIViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = Strings.CourseDetail.freeVideos
        
        getFreeVideos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: WebServices
    func getFreeVideos() {
        FreeVideoAPI.getFreeVideos(courseId: courseId!) { (videos) in
            if let arrVideos = videos.results, arrVideos.count > 0 {
                self.arrVideoList = arrVideos
                DispatchQueue.main.async {
                    self.tvFreeVideos.reloadData()
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension STBFreeVideoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrVideoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FreeVideoCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = arrVideoList[indexPath.row].display_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
