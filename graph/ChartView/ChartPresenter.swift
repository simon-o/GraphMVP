//
//  ChartPresenter.swift
//  graph
//
//  Created by Antoine Simon on 12/02/2018.
//  Copyright © 2018 antoine simon. All rights reserved.
//

import UIKit
import Alamofire

class ChartPresenter: NSObject {
    
    private var view : ChartViewController?
    private let chartModel : ChartModel?
    
    init(model: ChartModel) {
        chartModel = model
    }
    
    func attachView(_ viewToAttach: ChartViewController){
        view = viewToAttach
    }
    
    /*!
     @method      getInfoForChart()
     
     @abstract
     Fetch the data from the URL
     
     @result
     It will call the next function to display the chart from the receive data
     
     @todo
     write the url in a const file
     */
    func getInfoForChart(){
        if let url = URL(string: "https://api.myjson.com/bins/ipz6h"){
            Alamofire.request(url,
                              method: .get,
                              parameters: nil).validate()
                .responseJSON(completionHandler: { (response) in
                    guard response.result.isSuccess else{
                        self.errorMessage()
                        return
                    }
                    guard let tmpValue = response.value as? Dictionary<String, Array<Dictionary<String, Int>>> else {
                        self.errorMessage()
                        return
                    }
                    if self.chartModel?.initWithDictionnary(tmpValue) == false{
                        self.errorMessage()
                        return
                    }
                    if let tmpValue = self.chartModel?.values, let tmpIndex = self.chartModel?.indexs{
                        self.view?.setChart(values: tmpValue)
                    }
                })
        }else{
            errorMessage()
        }
    }
    
    /*!
     @method      errorMessage()
     
     @abstract
     display a message if there is an error with the chart
     */
    private func errorMessage(){
        //TODO write the message in a localizable file
        self.view?.errorMessageToDisplay("There is a problem with your connection or with the link")
    }
    
}
