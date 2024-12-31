//
//  Constants.swift
//  AppBase
//
//  Created by Quân Nguyễn on 31/12/24.
//

import Foundation
import UIKit

struct K {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    
    struct Format {
        static let fullDateTime         = "dd/MM/yyyy HH:mm:ss"
        
        static let dateTime             = "dd/MM/yyyy HH:mm"
        static let dateTime1            = "dd-MM-yyyy HH:mm"
        static let dateTime2            = "d 'thg' M yyyy H'h' mm'p'"
        
        static let date                 = "dd/MM/yyyy"
        static let date1                = "d 'thg' M yyyy"
        
        static let time                 = "HH:mm:ss"
        static let time1                = "HH:mm"
        static let time2                = "H 'giờ' m 'phút'"
        static let minute               = "m 'phút'"
        
        static let fullDate             = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

    }
    
    struct Colors {
        static let backgroundColor = UIColor(named: "BackgroundColor")
    }
}
