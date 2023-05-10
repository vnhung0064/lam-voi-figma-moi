//
//  TrungGianController.swift
//  test1
//
//  Created by Hung Vu on 08/05/2023.
//

import UIKit

class TrungGianController: UIViewController {

    let titles: [String] = ["All genres", "Pop","Electronic","Hip hop"]
    
    let items: [[String]] = [
        ["Apple", "Apricot", "Avocado", "Banana", "Blackberry"],
        ["Blueberry", "Cantaloupe", "Cherry", "Cherimoya", "Clementine", "Coconut", "Cranberry", "Cucumber",
         "Custard apple", "Damson", "Date", "Dragonfruit", "Durian", "Elderberry", "Feijoa",],
        ["Fig", "Grape", "Grapefruit", "Guava", "Udara", "Honeyberry", "Huckleberry", "Jabuticaba"],
        ["Jackfruit", "Juniper berry", "Kiwi fruit", "Lemon", "Lime", "Lychee", "Mandarine",],
        ["Mango", "Marionberry"],
        ["Melon", "Nance", "Nectarine", "Olive", "Orange", "Papaya", "Peach"],
        ["Pear", "Pineapple", "Raspberry", "Strawberry", "Tamarillo", "Tamarind", "Tomato", "Ugli fruit", "Yuzu"]
    ]

    let tabTitles: [String] = ["All genres", "Pop","Electronic","Hip hop"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let pageViewController = PageTabMenuViewController(
            items: items,
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
