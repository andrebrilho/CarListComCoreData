//
//  Result.swift
//  CarsBDCoreData
//
//  Created by André Brilho on 20/12/19.
//  Copyright © 2019 André Brilho. All rights reserved.
//

import Foundation

extension ApiCarros {
    
    public enum Result<CarroEntity, Error> {
        case Success(CarroEntity)
        case Error(Error?)
    }
    
}
