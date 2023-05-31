//
//  TrungGianController.swift
//  test1
//
//  Created by Hung Vu on 08/05/2023.
//

import UIKit

class TrungGianController: UIViewController {

    let titles: [String] = ["All genres", "Pop","Electronic","Hip hop"]
  
    let tabTitles: [String] = ["All genres", "Pop","Electronic","Hip hop","BLUE"]
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
        let pageViewController = PageTabMenuViewController(
            
            
            titles: tabTitles,
            options: RoundRectPagerOption())
        
        

        
        self.navigationController?.setViewControllers([pageViewController], animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
