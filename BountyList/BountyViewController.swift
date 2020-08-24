//
//  BountyViewController.swift
//  BountyList
//
//  Created by 손한비 on 2020/08/20.
//  Copyright © 2020 kr.co.hist. All rights reserved.
//

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Model
    // - BountyInfo
    // > BountyInfo 만들기

    // View
    // - ListCell
    // > ListCell 필요한 정보를 ViewModel에서 받기
    // > ListCell은 ViewModel로부터 받은 정보로 뷰 업데이트 하기

    // ViewModel
    // - BountyViewModel
    // > BountyViewModel 만들고, 뷰레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기(BountyInfo 들...)
    
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 44000000),
        BountyInfo(name: "luffy", bounty: 300000000),
        BountyInfo(name: "nami", bounty: 1600000),
        BountyInfo(name: "robin", bounty: 80000000),
        BountyInfo(name: "sanji", bounty: 77000000),
        BountyInfo(name: "zoro", bounty: 120000000),
    ]
    
//    let nameList = ["brook", "chopper", "franky", "luffy", "nami", "robin", "sanji", "zoro"]
//    let bountyList = [33000000, 50, 44000000, 300000000, 1600000, 80000000, 77000000, 120000000]
    
    // 세그웨이 수행되기 직전에 준비하는 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            
            if let index = sender as? Int {
                
                let bountyInfo = bountyInfoList[index]
//                vc?.name = bountyInfo.name
//                vc?.bounty = bountyInfo.bounty
                vc?.bountyInfo = bountyInfo

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // UITableViewDatasource에 포함된 필수 protocol
    // 총 몇 개의 row로 이루어 지는지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bountyInfoList.count
    }
    
    // 어떤 셀로 보여줄건지
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        
        let bountyInfo = bountyInfoList[indexPath.row]
        
        let img = bountyInfo.image
        cell.imgView.image = img
        cell.nameLabel.text = bountyInfo.name
        cell.bountyLabel.text = "\(bountyInfo.bounty)"
        
        return cell
    }
    
    // UITableViewDelegate에 포함된 protocol
    // 클릭 시 어떻게 동작할지
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--> \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
}

// Custom cell
class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
}

// Model: BountyInfo
struct BountyInfo{
    let name: String
    let bounty: Int
    
    var image: UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init(name: String, bounty: Int) {
        self.name = name
        self.bounty = bounty
    }
}
