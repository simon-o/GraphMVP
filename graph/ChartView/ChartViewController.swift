//
//  ChartViewController.swift
//  graph
//
//  Created by Antoine Simon on 12/02/2018.
//  Copyright © 2018 antoine simon. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    @IBOutlet weak var barChartView: BarChartView!
    
    private let presenter = ChartPresenter(model: ChartModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initBarChartView()
        presenter.attachView(self)
        presenter.getInfoForChart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*!
     @method      initBarChartView()
     
     @abstract
     Init that bar chart to match the choosen design
     */
    func initBarChartView(){
        let color =  UIColor.init(red: 26/255, green: 209/255, blue: 255/255, alpha: 1.0)
        barChartView.backgroundColor = color
        view.backgroundColor = color
        
        //Set chart design parameters
        barChartView.chartDescription?.enabled = false
        barChartView.pinchZoomEnabled = false
        barChartView.dragEnabled = false
        barChartView.highlightPerTapEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.enabled = false
        barChartView.xAxis.enabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.legend.enabled = false
    }
    
    /*!
     @method      errorMessageToDisplay(_ msg: String)
     
     @abstract
     display a message if there is an error with the chart
  
     @param
     the message that needs to be display
     */
    func errorMessageToDisplay(_ msg: String){
        barChartView.noDataText = msg
        barChartView.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.white
    }
    
    /*!
     @method      setChart(index: [Int], values: [Int])
     
     @abstract
     Display the bar in the chart
     
     @param
     The values for the bar size
     */
    func setChart(values: [Int]) {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: nil)
        //Set bar design parameters
        chartDataSet.setColor(UIColor.white)
        
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setDrawValues(false)
        //Set bar design parameters
        chartData.barWidth = 0.6
        
        barChartView.data = chartData
    }
}
