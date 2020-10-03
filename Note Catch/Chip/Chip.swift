//
//  Chip.swift
//  Chip Catch
//
//  Created by Andy Li on 2/20/19.
//  Copyright © 2019 Andy Li. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class ChipNode: SKShapeNode {
    
    var chip = Chip(attribute: ("chip_0", Chip.Note.Note_C, Chip.Color.Red))
        
}


struct Chip {
 
    var attribute : (String, Note, Color)

    //  var haptic : Haptic
    
    enum Note : Double {
        case Note_C = 261.63
        case Note_D = 293.66
        case Note_E = 329.63
        case Note_F = 349.23
        case Note_G = 392.00
        case Note_A = 440.00
        case Note_B = 493.88
        case Note_hiC = 523.25
        
        static var all = [Note.Note_C, .Note_D, .Note_E, .Note_F, .Note_G, .Note_A, .Note_B, .Note_hiC]
        
}
    enum Color  {
        
        case Red
        case Orange
        case Yellow
        case Green
        case Blue
        case Indigo
        case Violet
        case Black
        
        var color : UIColor {
            switch self {
            case .Red:
                return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            case .Orange:
                return #colorLiteral(red: 1, green: 0.7474035621, blue: 0, alpha: 1)
            case .Yellow:
                return #colorLiteral(red: 0.9352676272, green: 0.9489123225, blue: 0, alpha: 1)
            case .Green:
                return #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            case .Blue:
                return #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            case .Indigo:
                return #colorLiteral(red: 0.1986592114, green: 0, blue: 1, alpha: 1)
            case .Violet:
                return #colorLiteral(red: 0.6267609, green: 0, blue: 0.9857581258, alpha: 1)
            case .Black:
                return #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
            
            }
            
        }
        
        static var all = [Color.Red, .Orange, .Yellow, .Green, .Blue, .Indigo, .Violet, .Black]
}
    static var all = [ ("chip_0", Note.Note_C, Color.Red),
                       ("chip_1", Note.Note_D, Color.Orange),
                       ("chip_2", Note.Note_E, Color.Yellow),
                       ("chip_3", Note.Note_F, Color.Green),
                       ("chip_4", Note.Note_G, Color.Blue),
                       ("chip_5", Note.Note_A, Color.Indigo),
                       ("chip_6", Note.Note_B, Color.Violet),
                       ("chip_7", Note.Note_hiC, Color.Black)]

    
}
