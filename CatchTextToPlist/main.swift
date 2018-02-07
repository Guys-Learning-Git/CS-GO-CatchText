//
//  main.swift
//  CatchTextToPlist
//
//  Created by 蕭安億 on 2017/7/17.
//  Copyright © 2017年 5hiny. All rights reserved.
//

import Foundation
//let begin = clock()

//擷取部分文字 2018.02.07
func shortenItsInfo (beSearchText:String, startKeyWord:String, endKeyWord:String) -> String {
    var text = beSearchText
    text.removeSubrange(text.startIndex..<(text.range(of: startKeyWord)?.lowerBound)!)
    text.removeSubrange((text.range(of: endKeyWord)?.upperBound)!..<text.endIndex)
    return text
}

func findItsValue (beSearchText:String, keyWord:String, quotationMarksReserve:Bool) -> String {
    let keyWordPositionUpperBound = beSearchText.range(of: keyWord)?.upperBound
    //防止沒有 keyWord
    guard keyWordPositionUpperBound != nil else {
        return "No Value"
    }
    
    var catchChar:String? = nil
    var result:String = ""
    var quotationMarks:String?
    if (quotationMarksReserve == true) {
        quotationMarks = nil
    } else {
        quotationMarks = "\""
    }
   

    var movePosition:String.IndexDistance = 0
    var moveStartPostion:String.Index
    var moveEndPostion:String.Index

    while (catchChar == nil) {
        moveStartPostion = beSearchText.index(keyWordPositionUpperBound!, offsetBy: movePosition)
        moveEndPostion = beSearchText.index(keyWordPositionUpperBound!, offsetBy: movePosition + 1)
        catchChar = beSearchText.substring(with: moveStartPostion..<moveEndPostion)
        if (catchChar == "\t")||(catchChar == quotationMarks)||(catchChar == " ") {
            catchChar = nil
            movePosition += 1
        } else {
            repeat {
                result = result + catchChar!
//                print("字節：",catchChar!)
                movePosition += 1
                moveStartPostion = beSearchText.index(keyWordPositionUpperBound!, offsetBy: movePosition)
                moveEndPostion = beSearchText.index(keyWordPositionUpperBound!, offsetBy: movePosition + 1)
                catchChar = beSearchText.substring(with: moveStartPostion..<moveEndPostion)
            } while (catchChar != "\t")&&(catchChar != quotationMarks)&&(catchChar != "\r\n")&&(catchChar != " ")
        }
    }
//    if (catchChar != nil) {catchChar = nil}
    return result
}

//typealias WeaponList = [WeaponFeature]
typealias WeaponList = [String:WeaponFeature]
typealias WeaponFeature = [String:String]



/*   CSGO Update 廢棄不做使用
let weaponsFeatureName = [
    "Team",
    "MaxPlayerSpeed",
    "WeaponPrice",
    "KillAward",
    "WeaponArmorRatio",
    
    "Penetration",
    "Damage",
    "Range",
    "RangeModifier"/*子彈衰減*/,
    "Bullets",
    "CycleTime",
    "TimeToIdle",/*??????*/
    "IdleInterval",/*??????*/
    
    "Spread"/*子彈偏移率*/,
    "InaccuracyCrouch"/*蹲*/,
    "InaccuracyStand"/*站*/,
    "InaccuracyJump"/*跳*/,
    "InaccuracyLand"/*著陸*/,
    "InaccuracyLadder"/*梯子*/,
    "InaccuracyFire",
    "InaccuracyMove"/*移動*/,
    
    "RecoveryTimeCrouch"/*恢復*/,
    "RecoveryTimeStand",
    
    "clip_size"/*彈夾子彈*/
]

let weaponsPathOf = "/Users/5hiny_44/Library/Application Support/Steam/steamapps/common/Counter-Strike Global Offensive/csgo/scripts/"
 */
let weaponsNameCatch = [
//    "weapon_knife_prefab",
    "\"melee\"",
    "weapon_taser_prefab",
//    "weapon_knifegg_prefab",
    
    "weapon_glock_prefab",
    "weapon_hkp2000_prefab",
    "weapon_usp_silencer_prefab",
    "weapon_elite_prefab",
    "weapon_p250_prefab",
    "weapon_cz75a_prefab",
    "weapon_tec9_prefab",
    "weapon_fiveseven_prefab",
    "weapon_deagle_prefab",
    "weapon_revolver_prefab",
    
    "weapon_nova_prefab",
    "weapon_xm1014_prefab",
    "weapon_sawedoff_prefab",
    "weapon_mag7_prefab",
    "weapon_m249_prefab",
    "weapon_negev_prefab",
    
    "weapon_mac10_prefab",
    "weapon_mp9_prefab",
    "weapon_mp7_prefab",
    "weapon_ump45_prefab",
    "weapon_p90_prefab",
    "weapon_bizon_prefab",
    
//    "weapon_rifle_prefab",
    "weapon_galilar_prefab",
    "weapon_famas_prefab",
    "weapon_ak47_prefab",
    "weapon_m4a1_prefab",
    "weapon_m4a1_silencer_prefab",
    "weapon_ssg08_prefab",
    "weapon_sg556_prefab",
    "weapon_aug_prefab",
    "weapon_awp_prefab",
    "weapon_g3sg1_prefab",
    "weapon_scar20_prefab",
    
    "weapon_molotov_prefab",
    "weapon_incgrenade_prefab",
    "weapon_decoy_prefab",
    "weapon_flashbang_prefab",
    "weapon_hegrenade_prefab",
    "weapon_smokegrenade_prefab",
//    "weapon_tagrenade_prefab",
    
    "\"c4\""
//    "weapon_cubemap_prefab",
//    "weapon_healthshot_prefab",
]
//"items":"items/items_game.txt"


let weaponsFeatureName = [
    
    "addon scale",
    "allow hand flipping",
    "armor ratio",
    "attack movespeed factor",
    "bot audible range",
    "bullets",
    "cannot shoot underwater",
    "crosshair delta distance",
    "crosshair min distance",
    "cycletime",
    "damage",
    "flinch velocity modifier large",
    "flinch velocity modifier small",
    "has burst mode",
    "has silencer",
    "heat per shot",
    "hide view model zoomed",
    "idle interval",
    "inaccuracy crouch",
    "inaccuracy fire",
    "inaccuracy jump",
    "inaccuracy jump initial",
    "inaccuracy ladder",
    "inaccuracy land",
    "inaccuracy move",
    "inaccuracy reload",
    "inaccuracy stand",
    "inaccuracy pitch shift",
    "is full auto",
    "is melee weapon",
    "is revolver",
    "itemflag select on empty",
    "itemflag no auto reload",
    "itemflag no auto switch empty",
    "itemflag limit in world",
    "itemflag exhaustible",
    "itemflag do hit location dmg",
    "itemflag no ammo pickups",
    "itemflag no item pickup",
    "kill award",
    "max player speed",
    "model right handed",
    "penetration",
    "primary clip size",
    "primary default clip size",
    "primary reserve ammo max",
    "range",
    "range modifier",
    "recoil angle",
    "recoil angle variance",
    "recoil magnitude",
    "recoil magnitude variance",
    "recovery time crouch",
    "recovery time crouch final",
    "recovery time stand",
    "recovery time stand final",
    "recovery transition end bullet",
    "recovery transition start bullet",
    "rumble effect",
    "secondary clip size",
    "secondary default clip size",
    "secondary reserve ammo max",
    "spread",
    "time to idle",
    "tracer frequency",
    "unzoom after shot",
    "weapon weight",
    
    "cycletime alt",
    "inaccuracy crouch alt",
    "inaccuracy fire alt",
    "inaccuracy jump alt",
    "inaccuracy ladder alt",
    "inaccuracy land alt",
    "inaccuracy move alt",
    "inaccuracy stand alt",
    "inaccuracy alt sound threshold",
    "max player speed alt",
    "recoil angle alt",
    "recoil angle variance alt",
    "recoil magnitude alt",
    "recoil magnitude variance alt",
    "spread alt",
    
    "zoom fov 1",
    "zoom fov 2",
    "zoom levels",
    "zoom time 0",
    "zoom time 1",
    "zoom time 2"
]

let weaponsName = [
    "knife",
    "Zeus x27",
    //    "weapon_knifegg.txt",
    
    "Glock-18",
    "P2000",
    "USP-S",
    "Dual Berettas",
    "P250",
    "CZ75-Auto",
    "Tec-9",
    "Five-Seven",
    "Desert Eagle",
    "R8 Revolver",
    
    "Nova",
    "XM1014",
    "Sawed-Off",
    "MAG-7",
    "M249",
    "Negev",
    
    "MAC-10",
    "MP9",
    "MP7",
    "UMP-45",
    "P90",
    "PP-Bizon",
    
    //    "weapon_rifle.txt",
    "Galil AR",
    "FAMAS",
    "AK-47",
    "M4A4",
    "M4A1-S",
    "SSG 08",
    "SG 553",
    "AUG",
    "AWP",
    "G3SG1",
    "SCAR-20",
    
    "Molotov",
    "Incendiary Grenade",
    "Decoy Grenade",
    "Falshbang",
    "High Explosive Grenade",
    "Smoke Grenade",
    //    "weapon_tagrenade.txt",
    
    "C4"
    //    "weapon_cubemap.txt",
    //    "weapon_healthshot.txt",
    
]

var testCatchText:String
var weaponsList:WeaponList = [:]
var secondaryWeaponList:WeaponList = [:]
//var weaponsFeature:WeaponFeature = [:]


let items_game = try String(contentsOfFile: "/Users/5hiny_44/Library/Application Support/Steam/steamapps/common/Counter-Strike Global Offensive/csgo/scripts/items/items_game.txt")

for weaponsNameCatch in weaponsNameCatch {
    
    var weaponsFeature:WeaponFeature = [:]
    var prefab:[String] = []
    var prefabNumberCounter:Int = 0
    prefab.append(weaponsNameCatch)
    print("=======================================================")
    print(prefabNumberCounter,".",prefab[prefabNumberCounter])
    
    while (secondaryWeaponList.keys.contains(prefab[prefabNumberCounter]) != true) {
//        print (weaponsNameCatch,":",prefab[prefabNumberCounter])
        testCatchText = shortenItsInfo(beSearchText: items_game, startKeyWord: prefab[prefabNumberCounter], endKeyWord: "}\r\n\t\t}")
        
        for weaponsFeatureName in weaponsFeatureName {
            weaponsFeature[weaponsFeatureName] = findItsValue(beSearchText: testCatchText, keyWord: weaponsFeatureName + "\"", quotationMarksReserve:false)
        }
        secondaryWeaponList[prefab[prefabNumberCounter]] = weaponsFeature
        prefab.append(findItsValue(beSearchText: testCatchText, keyWord: "\"prefab\"", quotationMarksReserve: true))
        prefabNumberCounter += 1
        
        print(prefabNumberCounter,".",prefab[prefabNumberCounter])
        
        if (prefab[prefabNumberCounter] == "No Value") {prefabNumberCounter -= 1;break}
    }
    
    repeat {
        var temporaryString:String?
        for weaponsFeatureName in weaponsFeatureName {
            if (secondaryWeaponList[prefab[prefabNumberCounter-1]]?[weaponsFeatureName] == "No Value") {
                temporaryString = secondaryWeaponList[prefab[prefabNumberCounter]]?[weaponsFeatureName]
                secondaryWeaponList[prefab[prefabNumberCounter-1]]?[weaponsFeatureName] = temporaryString
            }
        }
        prefabNumberCounter -= 1
    } while(prefabNumberCounter > 0)
    
    weaponsList[weaponsNameCatch] = secondaryWeaponList[weaponsNameCatch]
}

let olderWeaponsList = NSDictionary(contentsOfFile:"/Users/5hiny_44/Documents/CatchTextToPlist/CatchTextToPlist/WeaponsList.plist")!

print("========================比較列表==========================")
for weaponsNameCatch in weaponsNameCatch {
    let olderWeapons = olderWeaponsList[weaponsNameCatch] as! WeaponFeature
    print(weaponsNameCatch,":")
    for weaponsFeatureName in weaponsFeatureName {
        let olderWeaponsFeature = olderWeapons[weaponsFeatureName]!
        if (weaponsList[weaponsNameCatch]?[weaponsFeatureName] != olderWeaponsFeature ) {
            print("\t",weaponsFeatureName,":",olderWeaponsFeature,"->",weaponsList[weaponsNameCatch]![weaponsFeatureName]!)
        }
    }
}
print("========================================================")

//建立plist
print("是否複寫檔案？(YES/NO)")
let yesOrNo = readLine()
if (yesOrNo == "YES") {
    (weaponsList as NSDictionary).write(toFile: "/Users/5hiny_44/Documents/CatchTextToPlist/CatchTextToPlist/WeaponsList.plist", atomically: false)
    print("成功儲存")
} else {
    print("沒有儲存")
}

//// time
//let diff = Double(clock() - begin) / Double(CLOCKS_PER_SEC)
//print("time:",diff)


//print("\n\n\n========================下面測試用========================")
//let name = "Marie Curie"
//let firstSpace = name.characters.index(of: " ")!
//let test = firstSpace.samePosition(in: name.unicodeScalars)
//print(test)
//let firstName = String(name.characters.prefix(upTo: firstSpace))
//print(firstName)
//print(Array(name.characters.prefix(upTo: firstSpace)))
//// Prints "Marie"
//
////let firstSpaceUTF8 = name.utf8.index(of: <#T##UTF8.CodeUnit#>)!
//let firstSpaceUTF8 = firstSpace.samePosition(in: name.utf8)
//print(firstSpaceUTF8)
//print(Array(name.utf8.prefix(upTo: firstSpaceUTF8)))
//// Prints "[77, 97, 114, 105, 101]"
//
//let test1 = "abc".customMirror.description
//let test2 = name.decomposedStringWithCanonicalMapping
//let test3 = name.precomposedStringWithCompatibilityMapping
//let test4 = name.decomposedStringWithCompatibilityMapping
//
//print("測試：",test1,"\n",test2)
//print("測試：",test3,"\n",test4)
//
//var nameFanc = name
//nameFanc.append("abc")
//print(nameFanc)
//print (nameFanc.contains("abc"))
//
//print (firstSpace)
//print (name.index(after: firstSpace))
//print (name.substring(to: firstSpace))
//print (name.substring(to: name.index(after: firstSpace)))
////var myCompare:CompareOption
////print("結果：",nameFanc.commonPrefix(with:"Marie Curie",options:NSString.CompareOptions(1)))
//
////let start = name.index(name.startIndex, offsetBy:2)
////let end = name.index(name.startIndex, offsetBy:3)
////let range = start..<end
////let myDistance = name.distance(from: start, to: end)
////print("Distance:",myDistance)
////print("在範圍裡是：",name.substring(with: range))
//let numberString:String.IndexDistance = 10
//
//var aaa = ["a":"1","b":"2","c":"3"]
//print(aaa.keys.contains("a"))
