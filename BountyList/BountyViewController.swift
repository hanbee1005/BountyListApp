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
    
    let viewModel = BountyViewModel()
    
    // 세그웨이 수행되기 직전에 준비하는 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            
            if let index = sender as? Int {
                
                let bountyInfo = viewModel.bountyInfo(at: index)
                vc?.viewModel.update(model: bountyInfo)

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // UITableViewDatasource에 포함된 필수 protocol
    // 총 몇 개의 row로 이루어 지는지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    // 어떤 셀로 보여줄건지
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        
        let bountyInfo = viewModel.bountyInfo(at: indexPath.row)
        cell.update(info: bountyInfo)
        
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
    
    func update(info: BountyInfo) {
        let img = info.image
        imgView.image = img
        nameLabel.text = info.name
        bountyLabel.text = "\(info.bounty)"
    }
}

// ViewModel: BountyViewModel
class BountyViewModel{
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
    
    // 현상금이 높은 순으로 정렬된 리스트
    var sortedList: [BountyInfo] {
        let sortedList = bountyInfoList.sorted { prev, next  in
            return prev.bounty > next.bounty
        }
        
        return sortedList
    }
    
    var numOfBountyInfoList: Int {
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int) -> BountyInfo {
        return sortedList[index]
    }
}
