 //
//  GeneralViewController.swift
//  Setting_Clone_App
//
//  Created by 이치훈 on 2023/02/05.
//

import UIKit

class GeneralViewController: UIViewController {

    @IBOutlet weak var generalTableView: UITableView!
    
    var generalmodel = [[GeneralVO]]()
    
    func makeData(){
        generalmodel.append(
        [GeneralVO(leftTitle: "About")]
        )
        generalmodel.append(
        [GeneralVO(leftTitle: "Keyboard"),
        GeneralVO(leftTitle: "Game Controller"),
        GeneralVO(leftTitle: "Fonts"),
        GeneralVO(leftTitle: "Language & Region"),
        GeneralVO(leftTitle: "Dictionary")]
        )
        generalmodel.append([GeneralVO(leftTitle: "Reset")])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generalTableView.delegate = self
        generalTableView.dataSource = self
        generalTableView.backgroundColor = .systemGroupedBackground
        
        generalTableView.register(UINib(nibName: "GeneralCell", bundle: nil), forCellReuseIdentifier: "GeneralCell")
     
        //self.title = "General"
        self.view.backgroundColor = .systemGroupedBackground
        
        self.makeData()
    }
    

}
//MARK: - UITableViewDataSource
extension GeneralViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generalmodel[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        generalmodel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralCell") as! GeneralCell
        cell.leftTitle.text = generalmodel[indexPath.section][indexPath.row].leftTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
extension GeneralViewController: UITableViewDelegate{
    
}
