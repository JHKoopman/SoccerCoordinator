//SoccerCoordinator: A treehouse techdegree project
//By: Jari Koopman

import UIKit

//MARK: Variables and constants declaration

let players: [[String: String]] = [["Name":"Joe Smith", "Height":"42", "Experience":"YES", "Guardian":"Jim and Jan Smith"],
                                   ["Name":"Jill Tanner", "Height":"36", "Experience":"YES", "Guardian":"Clara Tanner"],
                                   ["Name":"Bill Bon", "Height":"43", "Experience":"YES", "Guardian":"Sara and Jenny Bon"],
                                   ["Name":"Eva Gordon", "Height":"45", "Experience":"NO", "Guardian":"Wendy and Mike Gordon"],
                                   ["Name":"Matt Gill", "Height":"40", "Experience":"NO", "Guardian":"Charles and Sylvia Gill"],
                                   ["Name":"Kimmy Stein", "Height":"41", "Experience":"NO", "Guardian":"Bill and Hillary Stein"],
                                   ["Name":"Sammy Adams", "Height":"45", "Experience":"NO", "Guardian":"Jeff Adams"],
                                   ["Name":"Karl Saygan", "Height":"42", "Experience":"YES", "Guardian":"Heather Bledsoe"],
                                   ["Name":"Suzane Greenberg", "Height":"44", "Experience":"YES", "Guardian":"Henrietta Dumas"],
                                   ["Name":"Sal Dali", "Height":"41", "Experience":"NO", "Guardian":"Gala Dali"],
                                   ["Name":"Joe Kavalier", "Height":"39", "Experience":"NO", "Guardian":"Sam and Elaine Kavalier"],
                                   ["Name":"Ben Finkelstein", "Height":"44", "Experience":"NO", "Guardian":"Aaron and Jill Finkelstein"],
                                   ["Name":"Diego Soto", "Height":"41", "Experience":"YES", "Guardian":"Robin and Sarika Soto"],
                                   ["Name":"Chloe Alaska", "Height":"47", "Experience":"NO", "Guardian":"David and Jamie Alaska"],
                                   ["Name":"Arnold Willis", "Height":"43", "Experience":"NO", "Guardian":"Claire Willis"],
                                   ["Name":"Phillip Helm", "Height":"44", "Experience":"YES", "Guardian":"Thomas Helm and Eva Jones"],
                                   ["Name":"Les Clay", "Height":"42", "Experience":"YES", "Guardian":"Wynonna Brown"],
                                   ["Name":"Herschel Krustofski", "Height":"45", "Experience":"YES", "Guardian":"Hyman and Rachel Krustofski"]]

//All player data is stored as ints, these ints are the index values of the player in the Players array, that way I don't have to convert values over and over again
var experiencedPlayers: [Int] = []
var nexperiencedPlayers: [Int] = []
var dragons: [Int] = []
var sharks: [Int] = []
var raptors: [Int] = []
var expDragons: [Int] = []
var expSharks: [Int] = []
var expRaptors: [Int] = []
var nexpDragons: [Int] = []
var nexpSharks: [Int] = []
var nexpRaptors: [Int] = []
var x = 0
var playerDividerCount = 0
var usedNumbers: [Int] = []
var heightsEvenlySpread: Bool = false

//MARK: Function declarations

//Create a random number to divide players over the teams
func numberGenerator(max: Int) -> Int {
    let max = UInt32(max)
    let unasignedRandomNumber = arc4random_uniform(max)
    let randomNumber = Int(unasignedRandomNumber)
    
    return randomNumber
}
//The number created above may have been used already, here that is checked, if the number is used we generate a new one, otherwise we return it
func randomNumberGenerator(usedNumbers: [Int], max: Int) -> Int {
    //Get a number from the numberGenerator
    var randomNumber = numberGenerator(max: max)
    //Check if it's in the usedNumbers array
    while usedNumbers.contains(randomNumber) {
        //The number is already used, create a new one and check again
        randomNumber = numberGenerator(max: max)
    }
    //Return a number that is not used before
    return randomNumber
}
//A function to check if the heights of the teams don't differ too much
func heightSorter(firstHeight: Double, secondHeight: Double, thirdHeight: Double) -> Bool {
    if (firstHeight - secondHeight <= 1.5 && firstHeight - secondHeight >= -1.5) && (secondHeight - thirdHeight <= 1.5 && secondHeight - thirdHeight >= -1.5) && (firstHeight - thirdHeight <= 1.5 && firstHeight >= -1.5) {
        return true
    } else {
        return false
    }
}

//MARK: Creation of teams

// Use a while loop to check if a player is or is not experienced
while x < players.count {
    if players[x]["Experience"] == "YES" {
        // Player is experienced, append to experienced players array
        experiencedPlayers.append(x)
    } else {
        // Player is not experienced, append to not experienced players array
        nexperiencedPlayers.append(x)
    }
    x += 1
}
//A big while loop to check if the heights of the final teams dont differ too much
while heightsEvenlySpread == false {
    sharks = []
    dragons = []
    raptors = []
    //Divide the experienced players over the teams, check the heights to be not too different
    x = 0
    var expSuccessDivided = false
    while x < experiencedPlayers.count {
        //Divide the players over the teams
        while expSuccessDivided == false {
            usedNumbers = []
            expRaptors = []
            expSharks = []
            expDragons = []
            var randomNumber = 0
            while usedNumbers.count < experiencedPlayers.count {
                randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: experiencedPlayers.count)
                expDragons.append(experiencedPlayers[randomNumber])
                usedNumbers.append(randomNumber)
                randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: experiencedPlayers.count)
                expSharks.append(experiencedPlayers[randomNumber])
                usedNumbers.append(randomNumber)
                randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: experiencedPlayers.count)
                expRaptors.append(experiencedPlayers[randomNumber])
                usedNumbers.append(randomNumber)
            }
            //Now get the average heights of all the teams
            var expDragonsAverageHeight: Double{
                var expDragonsTotalHeigt = 0
                for player in expDragons {
                    expDragonsTotalHeigt = expDragonsTotalHeigt + Int(players[player]["Height"]!)!
                }
                return Double(expDragonsTotalHeigt)/Double(expDragons.count)
            }
            var expSharksAverageHeight: Double{
                var expSharksTotalHeight = 0
                for player in expSharks {
                    expSharksTotalHeight = expSharksTotalHeight + Int(players[player]["Height"]!)!
                }
                return Double(expSharksTotalHeight)/Double(expSharks.count)
            }
            var expRaptorsAverageHeight: Double{
                var expRaptorsTotalheight = 0
                for player in expRaptors {
                    expRaptorsTotalheight = expRaptorsTotalheight + Int(players[player]["Height"]!)!
                }
                return Double(expRaptorsTotalheight)/Double(expRaptors.count)
            }
            //Check if the average heights are not too different
            if heightSorter(firstHeight: Double(expRaptorsAverageHeight), secondHeight: Double(expSharksAverageHeight), thirdHeight: Double(expDragonsAverageHeight)) == true {
                expSuccessDivided = true
                var player: Int = 0
                while player < expSharks.count {
                    sharks.append(expSharks[player])
                    dragons.append(expDragons[player])
                    raptors.append(expRaptors[player])
                    player += 1
                }
            } else {
                expSuccessDivided = false
            }
        }
        x += 1
    }
    //Now do exactly the same for the not experienced players
    x = 0
    var nexpSuccessDivided = false
    while x < nexperiencedPlayers.count {
        //Divide the players
        while nexpSuccessDivided == false {
            usedNumbers = []
            nexpSharks = []
            nexpDragons = []
            nexpRaptors = []
            var randomNumber = 0
            while usedNumbers.count < nexperiencedPlayers.count {
                randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: nexperiencedPlayers.count)
                nexpDragons.append(nexperiencedPlayers[randomNumber])
                usedNumbers.append(randomNumber)
                randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: nexperiencedPlayers.count)
                nexpSharks.append(nexperiencedPlayers[randomNumber])
                usedNumbers.append(randomNumber)
                randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: nexperiencedPlayers.count)
                nexpRaptors.append(nexperiencedPlayers[randomNumber])
                usedNumbers.append(randomNumber)
            }
            //Now get the average height of the teams
            var nexpDragonsAverageHeight: Double{
                var nexpDragonsTotalHeight: Int = 0
                for player in nexpDragons {
                    nexpDragonsTotalHeight = nexpDragonsTotalHeight + Int(players[player]["Height"]!)!
                }
                return Double(nexpDragonsTotalHeight)/Double(nexpDragons.count)
            }
            var nexpSharksAverageHeight: Double{
                var nexpSharksTotalHeight: Int = 0
                for player in nexpSharks {
                    nexpSharksTotalHeight = nexpSharksTotalHeight + Int(players[player]["Height"]!)!
                }
                return Double(nexpSharksTotalHeight)/Double(nexpSharks.count)
            }
            var nexpRaptorsAverageHeight: Double{
                var nexpRaptorsTotalHeight: Int = 0
                for player in nexpRaptors {
                    nexpRaptorsTotalHeight = nexpRaptorsTotalHeight + Int(players[player]["Height"]!)!
                }
                return Double(nexpRaptorsTotalHeight)/Double(nexpRaptors.count)
            }
            //Check if the average heights are not too different
            if heightSorter(firstHeight: Double(nexpRaptorsAverageHeight), secondHeight: Double(nexpSharksAverageHeight), thirdHeight: Double(nexpDragonsAverageHeight)) == true {
                nexpSuccessDivided = true
                var player: Int = 0
                while player < nexpSharks.count {
                    sharks.append(nexpSharks[player])
                    dragons.append(nexpDragons[player])
                    raptors.append(nexpRaptors[player])
                    player += 1
                }
            } else {
                nexpSuccessDivided = false
            }
        }
        x += 1
    }
    //Get the total heights of the teams
    var sharksAverageHeight: Double{
        var sharksTotalHeight: Int = 0
        for player in sharks {
            sharksTotalHeight = sharksTotalHeight + Int(players[player]["Height"]!)!
        }
        return Double(sharksTotalHeight)/Double(sharks.count)
    }
    var dragonsAverageHeight: Double {
        var dragonsTotalHeight: Int = 0
        for player in dragons {
            dragonsTotalHeight = dragonsTotalHeight + Int(players[player]["Height"]!)!
        }
        return Double(dragonsTotalHeight)/Double(dragons.count)
    }
    var raptorsAverageHeight: Double{
        var raptorsTotalHeight: Int = 0
        for player in raptors {
            raptorsTotalHeight = raptorsTotalHeight + Int(players[player]["Height"]!)!
        }
        return Double(raptorsTotalHeight)/Double(raptors.count)
    }
    if heightSorter(firstHeight: sharksAverageHeight, secondHeight: dragonsAverageHeight, thirdHeight: raptorsAverageHeight) {
        print("The average heights are:", sharksAverageHeight, dragonsAverageHeight, raptorsAverageHeight)
        heightsEvenlySpread = true
    } else {
        heightsEvenlySpread = false
    }
}

//Mark: Sending of the letters

let practiceTimes: [String: [String: String]] = ["Sharks":["Date": "March 17", "Time": "3PM"],
                                                 "Raptors": ["Date": "March 18", "Time": "1PM"],
                                                 "Dragons": ["Date": "March 17", "Time": "1PM"]]

func sendLetters(team: [Int], teamName: String) {
    for player in team {
        print("\nDear \(players[player]["Guardian"]!),\n \nYour child, \(players[player]["Name"]!), has been added into the \(teamName) team.\nThe training will be on: \(practiceTimes[teamName]!["Date"]!) at \(practiceTimes[teamName]!["Time"]!).\nWe hope to see you there!\n \nKind Regards,\nJari Koopman,\nOrganizer\n")
        print("====================")
        
    }
}
print("Letters:\n")
print("====================")

sendLetters(team: sharks, teamName: "Sharks")
sendLetters(team: raptors, teamName: "Raptors")
sendLetters(team: dragons, teamName: "Dragons")
