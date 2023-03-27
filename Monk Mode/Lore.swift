//
//  Lore.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 2023-03-25.
//

import Foundation

struct DisciplineLevels {
    
    var level : String
    
    static let youngBlood = [        "Level 1: As a Young Blood, you are just beginning your journey towards a more disciplined and mindful life. You have chosen to incorporate new habits into your daily routine that align with your values and goals. You are learning to prioritize your well-being and to resist some of the distractions and temptations of modern life."    ]
    
    static let seasonedWarrior = [        "Level 2: As a Seasoned Warrior, you have made progress in developing your willpower and focus. You have added more habits to your routine that challenge you and help you to grow. You are learning to resist more of the unhealthy habits and distractions that can hold you back."    ]
    
    static let eliteGuardian = [        "Level 3: As an Elite Guardian, you have become a master of self-discipline and focus. You have added more challenging habits to your routine that reflect your deepest values and goals. You are learning to take control of your life and to live more intentionally."    ]
    
    static let masterSlayer = [        "Level 4: As a Master Slayer, you have conquered many of the obstacles that can prevent people from living their best lives. You have refined your habits and routines to reflect your deepest values and goals. You are learning to maintain your focus and discipline even in the face of difficult circumstances."    ]
    
    static let legendaryHero = [        "Level 5: As a Legendary Hero, you have become an inspiration to others through your example and your achievements. You have built a strong foundation of healthy habits and self-discipline that allows you to live a more fulfilling and purposeful life. You are learning to use your skills and strengths to make a positive impact on the world."    ]
    
    static let demigodOfWar = [        "Level 6: As a Demigod of War, you have attained an almost superhuman level of focus and discipline. You have pushed yourself to the limit in order to achieve your goals and to become the best version of yourself. You are learning to balance your personal growth with your obligations to others."    ]
    
    static let immortalChampion = [        "Level 7: As an Immortal Champion, you have transcended the limitations of the mortal world and become a true master of your own destiny. You have integrated your habits and routines into every aspect of your life, and you inspire others through your unwavering commitment to excellence. You are learning to live a life of purpose and meaning that goes beyond your individual accomplishments."    ]
    
    static let divineAvatar = [        "Level 8: As a Divine Avatar, you have achieved a level of spiritual and personal development that is rare and extraordinary. You have become a beacon of light and inspiration to those around you, and you have dedicated your life to serving others. You are learning to embody the highest ideals and values of your tradition and to use your gifts and talents to make the world a better place."    ]
    
    static let titanOfPower = [        "Level 9: As a Titan of Power, you have attained a level of mastery and insight that few others can match. You have transcended the boundaries of the self and connected with the deepest truths of existence. You are learning to use your wisdom and power to help others find their own paths towards fulfillment and enlightenment."    ]
    
    static let godOfThunder = ["As a God of Thunder, you have become a force of nature, a symbol of the boundless potential of the human spirit. You have achieved a level of personal development and enlightenment that is beyond measure. You are learning to use your power and influence to create a more just, compassionate, and sustainable world for all beings."]
    
    
    func getParagraph() -> [String] {
        switch self.level {
        case "level1":
            return DisciplineLevels.youngBlood
        case "level2":
            return DisciplineLevels.seasonedWarrior
        case "level3":
            return DisciplineLevels.eliteGuardian
        case "level4":
            return DisciplineLevels.masterSlayer
        case "level5":
            return DisciplineLevels.legendaryHero
        case "level6":
            return DisciplineLevels.demigodOfWar
        case "level7":
            return DisciplineLevels.immortalChampion
        case "level8":
            return DisciplineLevels.divineAvatar
        case "level9":
            return DisciplineLevels.titanOfPower
        case "level99":
            return DisciplineLevels.godOfThunder
        default:
            return []
        }
    }

    
}
