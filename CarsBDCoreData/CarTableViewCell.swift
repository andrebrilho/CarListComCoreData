//
//  CarTableViewCell.swift
//  CarsBDCoreData
//
//  Created by André Brilho on 20/12/19.
//  Copyright © 2019 André Brilho. All rights reserved.
//

import UIKit
import AlamofireImage

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCarro: UIImageView!
    
    @IBOutlet weak var lblNameCar: UILabel!
    
    var carro:CarroEntity?{
        didSet{
            setCarro()
        }
    }
    
    func setCarro(){
        lblNameCar.text = carro?.nome
        imgCarro.image = nil
        imgCarro.af_cancelImageRequest()
        imgCarro.af_setImage(withURL: URL(string: (carro?.url_foto)!)!)
    }
    
}
