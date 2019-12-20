//
//  ViewController.swift
//  CarsBDCoreData
//
//  Created by André Brilho on 20/12/19.
//  Copyright © 2019 André Brilho. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dados:[CarroEntity] = []
    @IBOutlet weak var tbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraTable(table: tbl)
        var carrosFromDB = Dao.getDatafromCoreData()
        if !carrosFromDB.isEmpty{
            self.dados = carrosFromDB
        }else {
            getCars()
        }
    }
    
    func getCars(){
        ApiCarros.fecthCars { (result) in
            switch result {
            case let .Success(resultWithSuccess):
                DispatchQueue.main.async {
                    self.dados = resultWithSuccess
                    self.tbl.reloadData()
                }
            case let .Error(resultWithError):
                Alert.showAlertError(mensagemErro: (resultWithError?.localizedDescription)!, titleMsgErro: "Ops", view: self)
            }
        }
    }
    
    func configuraTable(table:UITableView){
        tbl.dataSource = self
        tbl.delegate = self
        tbl.register(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CarTableViewCell {
            cell.carro = dados[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if editingStyle == .delete {
            do {
                let carToDelete = dados[indexPath.row]
                appDelegate.context.delete(carToDelete)
                try appDelegate.context.save()
                dados.remove(at: indexPath.row)
                tbl.reloadData()
            }catch let error {
                print(error)
            }
        }
    }
    
    @IBAction func updateCars(_ sender: Any) {
        Dao.removeAllObjects()
        getCars()
    }
}

