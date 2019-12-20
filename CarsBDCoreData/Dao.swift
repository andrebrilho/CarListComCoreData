//
//  Dao.swift
//  CarsBDCoreData
//
//  Created by André Brilho on 20/12/19.
//  Copyright © 2019 André Brilho. All rights reserved.
//

import UIKit
import CoreData

class Dao {
    
    private static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private static let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CarroEntity")
    
    static func getDatafromCoreData()->[CarroEntity]{

        do {
            let result = try appDelegate.persistentContainer.viewContext.fetch(request)
            for data in result as! [CarroEntity]{
            }
            return result as! [CarroEntity]
        }catch {
            print("failet")
            return []
        }
    }
    
    static func saveCarsInBD(carrosCount:[Carro]) -> [CarroEntity] {
        
        let entity = NSEntityDescription.entity(forEntityName: "CarroEntity", in: appDelegate.context)
        var totalCarsResult:[CarroEntity] = []
        
        for car in carrosCount {
            
            let newCarro = NSManagedObject(entity: entity!, insertInto: appDelegate.context) as! CarroEntity
            newCarro.nome = car.nome
            newCarro.desc = car.desc
            newCarro.url_foto = car.url_foto
            totalCarsResult.append(newCarro)
        }
        
        do {
            try appDelegate.context.save()
        }catch{
            print("deu erro ao salvar carros no DB")
        }
        return totalCarsResult
    }
    
    static func removeAllObjects(){
        let fetchDelete = NSFetchRequest<NSFetchRequestResult>(entityName: "CarroEntity")
        let delete = NSBatchDeleteRequest(fetchRequest: fetchDelete)
        do {
            try appDelegate.context.execute(delete)
        } catch {
            print("deu ruim pra excluir")
        }
    }
}
