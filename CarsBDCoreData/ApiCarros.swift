//
//  ApiCarros.swift
//  CarsBDCoreData
//
//  Created by André Brilho on 20/12/19.
//  Copyright © 2019 André Brilho. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class ApiCarros {
    
    static func fecthCars(completion:@escaping(Result<[CarroEntity], Error>)-> Void ){
        
        var arrayCarrosToDB:[CarroEntity] = []
        
        if let url = URL(string: Constants.URL_BASE_FULL) {
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
            Alamofire.request(request).responseData { (response) in
                
                let statusCode = response.response?.statusCode
                
                switch statusCode {
                    case 200:
                        do {
                            let objResponse = try JSONDecoder().decode(CarrosResponse.self, from: response.data!)
                            var carroFromDB = Dao.saveCarsInBD(carrosCount: objResponse.carros.carro)
                            
//                            let totalCarsResult = objResponse.carros.carro
//
//                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                            let entity = NSEntityDescription.entity(forEntityName: "CarroEntity", in: appDelegate.context)
//
//                            for car in totalCarsResult {
//
//                                let newCarro = NSManagedObject(entity: entity!, insertInto: appDelegate.context) as! CarroEntity
//                                newCarro.nome = car.nome
//                                newCarro.desc = car.desc
//                                newCarro.url_foto = car.url_foto
//                                arrayCarrosToDB.append(newCarro)
//                            }
//
//                            do {
//                                try appDelegate.context.save()
//                            }catch{
//                                print("deu erro ao salvar carros no DB")
//                            }
                            completion(.Success(carroFromDB))
                        }catch{
                            print("error generic")
                    }
                default:
                    completion(.Error(response.error))
                    print("error")
                    }
                }
            }
        } 
    }

