//
//  ColorsByLevel.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 9.03.2023.
//

import Foundation
import SwiftUI


struct AppColors {
    struct TopBar {
       
        
        static var topBarColor: Color {
            @AppStorage("userLevel") var userLevel = "level1"
            switch userLevel {
                            case "level1":
                                return Color(hex: 0x1363DF)
                            case "level2":
                                return Color(hex: 0x01005E)
                            case "level3":
                                return Color(hex: 0x51557E)
                            case "level4":
                                return Color(hex: 0x413543)
                            case "level5":
                                return Color(hex: 0x3D314A)
                            case "level6":
                                return Color(hex: 0x1E5128)
                            case "level7":
                                return Color(hex: 0x382933)
                            case "level8":
                                return Color(hex: 0x4D4847)
                            case "level9":
                                return Color(hex: 0xA27B5C)
                            case "level10":
                                return Color(hex: 0xA47E3B)
                            default:
                                return Color.black // default color
                        }
        }
    }
    
    struct Inside {
        static var insideColor: Color {
            @AppStorage("userLevel") var userLevel = "level1"
            switch userLevel {
                            case "level1":
                                return Color(hex: 0x1363DF)
                            case "level2":
                                return Color(hex: 0x01005E)
                            case "level3":
                                return Color(hex: 0x51557E)
                            case "level4":
                                return Color(hex: 0x413543)
                            case "level5":
                                return Color(hex: 0x3D314A)
                            case "level6":
                                return Color(hex: 0x1E5128)
                            case "level7":
                                return Color(hex: 0x382933)
                            case "level8":
                                return Color(hex: 0x4D4847)
                            case "level9":
                                return Color(hex: 0xA27B5C)
                            case "level10":
                                return Color(hex: 0xA47E3B)
                            default:
                                return Color.black // default color
                        }
        }
    }
    
    struct BarInside {
        static var barInsideColor: Color {
            @AppStorage("userLevel") var userLevel = "level1"
            switch userLevel {
                           case "level1":
                               return Color(hex: 0x47B5FF)
                           case "level2":
                               return Color(hex: 0x28518A)
                           case "level3":
                               return Color(hex: 0x816797)
                           case "level4":
                               return Color(hex: 0x8F43EE)
                           case "level5":
                               return Color(hex: 0x684756)
                           case "level6":
                               return Color(hex: 0x4E9F3D)
                           case "level7":
                               return Color(hex: 0x519872)
                           case "level8":
                               return Color(hex: 0x000F08)
                           case "level9":
                               return Color(hex: 0x3F4E4F)
                           case "level10":
                               return Color(hex: 0xE6B325)
                           default:
                               return Color.black // default color
                       }
        }
    }
    
    struct Back {
        static var backgroundColor: Color {
            @AppStorage("userLevel") var userLevel = "level1"
            switch userLevel {
                case "level1":
                    return Color(hex: 0x06283D)
                case "level2":
                    return Color(hex: 0x22267B)
                case "level3":
                    return Color(hex: 0x1B2430)
                case "level4":
                    return Color(hex: 0x3C210E)
                case "level5":
                    return Color(hex: 0x1A1423)
                case "level6":
                    return Color(hex: 0x191A19)
                case "level7":
                    return Color(hex: 0x3B5249)
                case "level8":
                    return Color(hex: 0x1C3738)
                case "level9":
                    return Color(hex: 0x2C3639)
                case "level10":
                    return Color(hex: 0x61481C)
                default:
                    return Color.black // default color
            }
        }
    }
}




