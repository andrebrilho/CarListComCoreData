//
//  Models.swift
//  CarsBDCoreData
//
//  Created by André Brilho on 20/12/19.
//  Copyright © 2019 André Brilho. All rights reserved.
//

import Foundation

    class Carro:Decodable{
        var nome:String
        var desc:String
        var url_foto:String
    }

    class Carros:Decodable {
        var carro:[Carro]
    }

    class CarrosResponse: Decodable {
        var carros:Carros
    }



//enum Main {
//
//    struct Carro:Decodable{
//        var nome:String
//        var desc:String
//        var url_foto:String
//    }
//
//    struct Carros:Decodable {
//        var carro:[Carro]
//    }
//
//    struct CarrosResponse: Decodable {
//        var carros:Carros
//    }
//}
