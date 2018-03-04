//
//  ChartModel.swift
//  graph
//
//  Created by Antoine Simon on 12/02/2018.
//  Copyright © 2018 antoine simon. All rights reserved.
//

import UIKit
//TODO Use an object mapper

class ChartModel {
    var indexs = Array<Int>()
    var values = Array<Int>()
    
    /*!
     @method      initWithDictionnary(_ dict: Dictionary<String, Array<Dictionary<String, Int>>>) -> Bool
     
     @abstract
     parse the dicitonnary
     
     @param
     the dictionnary receive from the JSON
     
     @result
     return false if there is an error
     
     @todo
     find a more generic way, because the JSON architecture can change
     */
    func initWithDictionnary(_ dict: Dictionary<String, Array<Dictionary<String, Int>>>) -> Bool{
        if let tmpGraph = dict["graph"]{
            let sorted = tmpGraph.sorted(by: { (dict1, dict2) -> Bool in
                if let tmpIndex1 = dict1["index"], let tmpIndex2 = dict2["index"]{
                    if (tmpIndex1 < tmpIndex2){
                        return true
                    }
                    return false
                }
                return true
            })
            for secondaryDict in sorted{
                if let tmpIndex = secondaryDict["index"], let tmpValue = secondaryDict["value"]{
                    indexs.append(tmpIndex)
                    values.append(tmpValue)
                }
            }
            return true
        }
        return false
    }
}
