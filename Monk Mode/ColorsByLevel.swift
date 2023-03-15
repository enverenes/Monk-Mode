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
                    return Color(hex: 0xD76A03)
                case "level2":
                    return Color(hex: 0x0F0E0E)
                case "level3":
                    return Color(hex: 0x005F95)
                case "level4":
                    return Color(hex: 0x050504)
                case "level5":
                    return Color(hex: 0x7A0209)
                case "level6":
                    return Color(hex: 0x152299)
                case "level7":
                    return Color(hex: 0x0C0808)
                case "level8":
                    return Color(hex: 0x1740AA)
                case "level9":
                    return Color(hex: 0x800A11)
                case "level10":
                    return Color(hex: 0xD76A03)
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
                return Color(hex: 0x231C15)
            case "level2":
                return Color(hex: 0x000C0C)
            case "level3":
                return Color(hex: 0x0F5D6F)
            case "level4":
                return Color(hex: 0x0A080C)
            case "level5":
                return Color(hex: 0x021736)
            case "level6":
                return Color(hex: 0x6C3806)
            case "level7":
                return Color(hex: 0x0F0B06)
            case "level8":
                return Color(hex: 0x252322)
            case "level9":
                return Color(hex: 0x834308)
            case "level10":
                return Color(hex: 0x231C15)
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
                return Color(hex: 0x005F95)
            case "level2":
                return Color(hex: 0x417A08)
            case "level3":
                return Color(hex: 0x970B0B)
            case "level4":
                return Color(hex: 0x0A0171)
            case "level5":
                return Color(hex: 0x70790D)
            case "level6":
                return Color(hex: 0x020601)
            case "level7":
                return Color(hex: 0x8E0101)
            case "level8":
                return Color(hex: 0xB10707)
            case "level9":
                return Color(hex: 0x0F0C0D)
            case "level10":
                return Color(hex: 0x005F95)
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
                    return Color(hex: 0x131771)
                case "level2":
                    return Color(hex: 0x0D1E58)
                case "level3":
                    return Color(hex: 0x1C3019)
                case "level4":
                    return Color(hex: 0x3C210E)
                case "level5":
                    return Color(hex: 0x031E0E)
                case "level6":
                    return Color(hex: 0x120202)
                case "level7":
                    return Color(hex: 0x00223A)
                case "level8":
                    return Color(hex: 0x0D0B08)
                case "level9":
                    return Color(hex: 0x0F1257)
                case "level10":
                    return Color(hex: 0x131771)
                default:
                    return Color.black // default color
            }
        }
    }
}




