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

var experiencedPlayers: [[String: String]] = []
var nexperiencedPlayers: [[String: String]] = []
var dragons: [[String: String]] = []
var sharks: [[String: String]] = []
var raptors: [[String: String]] = []
var expDragons: [[String: String]] = []
var expSharks: [[String: String]] = []
var expRaptors: [[String: String]] = []
var nexpDragons: [[String: String]] = []
var nexpSharks: [[String: String]] = []
var nexpRaptors: [[String: String]] = []
var heightsEvenlySpread = false
var x = 0
var usedNumbers: [Int] = []

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

//Loop trough all of the players to sort them on experience (exp) or no experience (nexp)
for player in players {
    if player["Experience"] == "YES" {
        //Player is experienced, add to the exp array
        experiencedPlayers.append(player)
    } else {
        //Player is nexperienced, add to the nexp array
        nexperiencedPlayers.append(player)
    }
}

//A big while loop to check if the heights of the final teams dont differ too much
while heightsEvenlySpread == false {
    //Empty out the teams since we are dividing all over again
    sharks.removeAll()
    dragons.removeAll()
    raptors.removeAll()
    //Divide the experienced players
    var expSuccessDivided = false
        while expSuccessDivided == false {
            //Empty out the teams since we are dividing all over again
            usedNumbers.removeAll()
            expRaptors.removeAll()
            expSharks.removeAll()
            expDragons.removeAll()
            //Divide them
            var randomNumber: Int
            while usedNumbers.count < experiencedPlayers.count {
                randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: experiencedPlayers.count)
                usedNumbers.append(randomNumber)
                expSharks.append(experiencedPlayers[randomNumber])
                randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: experiencedPlayers.count)
                usedNumbers.append(randomNumber)
                expDragons.append(experiencedPlayers[randomNumber])
                randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: experiencedPlayers.count)
                usedNumbers.append(randomNumber)
                expRaptors.append(experiencedPlayers[randomNumber])
            }
            //Now check all of the height data
            var expSharksAverageHeight: Double {
                var expSharkTotalHeight: Double = 0
                for player in expSharks {
                    expSharkTotalHeight += Double(player["Height"]!)!
                }
                return expSharkTotalHeight/Double(expSharks.count)
            }
            var expDragonsAverageHeight: Double {
                var expDragosTotalHeight: Double = 0
                for player in expDragons {
                    expDragosTotalHeight += Double(player["Height"]!)!
                }
                return expDragosTotalHeight/Double(expDragons.count)
            }
            var expRaptorsAverageHeight: Double {
                var expRaptorsTotalHeight: Double = 0
                for player in expRaptors {
                    expRaptorsTotalHeight += Double(player["Height"]!)!
                }
                return expRaptorsTotalHeight/Double(expRaptors.count)
            }
            //Check if the average heights are not too different
            if heightSorter(firstHeight: expSharksAverageHeight, secondHeight: expDragonsAverageHeight, thirdHeight: expRaptorsAverageHeight) == true {
                expSuccessDivided = true
                for player in expSharks {
                    sharks.append(player)
                }
                for player in expDragons {
                    dragons.append(player)
                }
                for player in expRaptors {
                    raptors.append(player)
                }
            } else {
                expSuccessDivided = false
            }
        }
    //Now do the same for the nexp players
    x = 0
    var nexpSuccessDivided = false
        while nexpSuccessDivided == false {
            //Empty out the teams since we are dividing all over again
            usedNumbers.removeAll()
            nexpSharks.removeAll()
            nexpDragons.removeAll()
            nexpRaptors.removeAll()
            var randomNumber: Int
            while usedNumbers.count < nexperiencedPlayers.count {
                randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: experiencedPlayers.count)
                usedNumbers.append(randomNumber)
                nexpSharks.append(nexperiencedPlayers[randomNumber])
                randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: experiencedPlayers.count)
                usedNumbers.append(randomNumber)
                nexpDragons.append(nexperiencedPlayers[randomNumber])
                randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: experiencedPlayers.count)
                usedNumbers.append(randomNumber)
                nexpRaptors.append(nexperiencedPlayers[randomNumber])
            }
            //Now check all the height data
            var nexpSharksAverageHeight: Double {
                var nexpSharkTotalHeight: Double = 0
                for player in nexpSharks {
                    nexpSharkTotalHeight += Double(player["Height"]!)!
                }
                return nexpSharkTotalHeight/Double(nexpSharks.count)
            }
            var nexpDragonsAverageHeight: Double {
                var nexpDragosTotalHeight: Double = 0
                for player in nexpDragons {
                    nexpDragosTotalHeight += Double(player["Height"]!)!
                }
                return nexpDragosTotalHeight/Double(nexpDragons.count)
            }
            var nexpRaptorsAverageHeight: Double {
                var nexpRaptorsTotalHeight: Double = 0
                for player in nexpRaptors {
                    nexpRaptorsTotalHeight += Double(player["Height"]!)!
                }
                return nexpRaptorsTotalHeight/Double(nexpRaptors.count)
            }
            if heightSorter(firstHeight: nexpSharksAverageHeight, secondHeight: nexpDragonsAverageHeight, thirdHeight: nexpRaptorsAverageHeight) == true {
                nexpSuccessDivided = true
                for player in nexpSharks {
                    sharks.append(player)
                }
                for player in nexpDragons {
                    dragons.append(player)
                }
                for player in nexpRaptors {
                    raptors.append(player)
                }
            } else {
                nexpSuccessDivided = false
            }
        }
    //Now that we have the teams lets check if the heights are not too different
    var sharksAverageHeight: Double {
        var sharksTotalHeight: Double = 0
        for player in sharks {
            sharksTotalHeight += Double(player["Height"]!)!
        }
        return sharksTotalHeight/Double(sharks.count)
    }
    var dragonsAverageHeight: Double {
        var dragonsTotalHeight: Double = 0
        for player in dragons {
            dragonsTotalHeight += Double(player["Height"]!)!
        }
        return dragonsTotalHeight/Double(dragons.count)
    }
    var raptorsAverageHeight: Double {
        var raptorsTotalHeight: Double = 0
        for player in raptors {
            raptorsTotalHeight += Double(player["Height"]!)!
        }
        return raptorsTotalHeight/Double(raptors.count)
    }
    if heightSorter(firstHeight: sharksAverageHeight, secondHeight: dragonsAverageHeight, thirdHeight: raptorsAverageHeight) == true {
        heightsEvenlySpread = true
        print("The average heights are:", sharksAverageHeight, dragonsAverageHeight, raptorsAverageHeight)
    } else {
        heightsEvenlySpread = false
    }
}

//Mark: Sending of the letters

let practiceTimes: [String: [String: String]] = ["Sharks":["Date": "March 17", "Time": "3PM"],
                                                 "Raptors": ["Date": "March 18", "Time": "1PM"],
                                                 "Dragons": ["Date": "March 17", "Time": "1PM"]]

func sendLetters(team: [[String: String]], teamName: String) {
    for player in team {
        print("\nDear \(player["Guardian"]!),\n \nYour child, \(player["Name"]!), has been added into the \(teamName) team.\nThe training will be on: \(practiceTimes[teamName]!["Date"]!) at \(practiceTimes[teamName]!["Time"]!).\nWe hope to see you there!\n \nKind Regards,\nJari Koopman,\nOrganizer\n")
        print("====================")
    }
}
print("Letters:\n")
print("====================")

sendLetters(team: sharks, teamName: "Sharks")
sendLetters(team: raptors, teamName: "Raptors")
sendLetters(team: dragons, teamName: "Dragons")