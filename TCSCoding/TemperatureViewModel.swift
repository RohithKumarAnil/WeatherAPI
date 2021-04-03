//
//  TemperatureViewModel.swift
//  TCSCoding
//
//  Created by Rohith Kumar on 4/2/21.
//

import Foundation

let tempatureWorkerClass = TempeatureWorkerClass()

class TemperatureViewModel {
    
    init(model: [DetailsOfCity]? = nil) {
        if let inputModel = model {
            cityTemp = inputModel
        }
    }
    var cityTemp = [DetailsOfCity]()
}


extension TemperatureViewModel {
    func getDataFromServer(cityString: String, completionBlock: @escaping (Result<Data, Error>) ->Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?appid=b274c5ce65b3e435688f3098769c6dee&q=\(cityString)"
        tempatureWorkerClass.getValueFromServer(urlValue: urlString) { (result) in
            switch result {
            case .failure(let error):
                print("failure\(error)")
            case .success(let data):
                let decoder = JSONDecoder()
                do
            {
                let internalCityTempatures = try decoder.decode(CityTemperature.self, from: data)
                let cityDetails = DetailsOfCity(tempature: internalCityTempatures, cityName: cityString)
                self.cityTemp.append(cityDetails)
                completionBlock(.success(data))
            } catch {
                print("Catch")
            }
            }
        }
    }
    
    func numberOfRowsInTableView(section: Int) -> Int {
        return self.cityTemp[section].rows.count
    }
}

