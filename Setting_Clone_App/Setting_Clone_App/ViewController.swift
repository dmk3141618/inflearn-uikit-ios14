//
//  ViewController.swift
//  Setting_Clone_App
//
//  Created by 이치훈 on 2023/02/03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var settingTableView: UITableView!

    var settingModel = [[SettingVO]]()
    
    func makeData(){
        settingModel.append(
        [SettingVO(leftImageName: "person.circle", menuTitle: "Sign in to your iPhone", subTitle: "Set up iCloud, the App Store, and more", rightImageName: nil)]
        )
        
        settingModel.append(
        [SettingVO(leftImageName: "gear", menuTitle: "General", subTitle: nil, rightImageName: "chevron.right"),
        SettingVO(leftImageName: "person.2.fill", menuTitle: "Accessibility", subTitle: nil, rightImageName: "chevron.right"),
        SettingVO(leftImageName: "hand.raised.fill", menuTitle: "Privacy", subTitle: nil, rightImageName: "chevron.right")]
        )
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        settingTableView.backgroundColor = .systemGroupedBackground
        
        settingTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        
        settingTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        
        //navigation setting
        self.title = "Settings"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .systemGroupedBackground
        
        self.makeData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }


}
//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingModel[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //profileCell 속성
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            
            cell.title.text = settingModel[indexPath.section][indexPath.row].menuTitle
            cell.descriptionInfo.text = settingModel[indexPath.section][indexPath.row].subTitle
            cell.profileImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
            
            return cell
        }
        else { //menuCell 속성
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
            
            cell.leftImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
            cell.leftImageView.tintColor = .darkGray
            cell.midTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
            cell.rightImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].rightImageName ?? "")
                                                
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return UITableView.automaticDimension
        }
        return 60
    }
    
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.section == 0{
            let myID = MyIDViewController(nibName: "MyIDViewController", bundle: nil)
            self.present(myID, animated: true)
        }
        else if indexPath.section == 1 && indexPath.row == 0 {
            let generalVC = UIStoryboard(name: "GeneralViewController", bundle: nil).instantiateViewController(withIdentifier: "GeneralVC")
            self.navigationController?.pushViewController(generalVC, animated: true)
        }
    }
}
