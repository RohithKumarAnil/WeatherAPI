//
//  ViewController.swift
//  TCSCoding
//
//  Created by Rohith Kumar on 4/2/21.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityName : UILabel!
    @IBOutlet weak var cityWeather: UILabel!
    
    func setUIData(name: String, weatherCondition: String) {
        cityName.text = name
        cityWeather.text = weatherCondition
    }
}

class ViewController: UIViewController {
    private var viewModel = TemperatureViewModel()
    @IBOutlet weak var cityTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        viewModel.getDataFromServer(cityString: "Chicago") { (result) in
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        viewModel.getDataFromServer(cityString: "Irving") { (result) in
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard self != nil else { return }
            self?.cityTableView.reloadData()
        }
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInTableView(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.cityTemp.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.viewModel.cityTemp[section].cityNameValue
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = indexPath.row == 0 ? "HeaderCell" : "customCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let cityTemperatureData = self.viewModel.cityTemp[indexPath.section]
        if(indexPath.row == 0){
            (cell as? HeaderTableViewCell)?.setUIData(name:cityTemperatureData.cityNameValue , weatherCondition: cityTemperatureData.description)
        }
        else {
            (cell as? TempatureCell)?.updateCellData(with: cityTemperatureData, forIndexPath: indexPath)
        }
        return cell
    }
}
