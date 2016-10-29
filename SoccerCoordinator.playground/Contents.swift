//: Playground - noun: a place where people can play

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
var notExperiencedPlayers: [Int] = []
var dragons: [Int] = []
var sharks: [Int] = []
var raptors: [Int] = []
var expDragons: [Int] = []
var expSharks: [Int] = []
var expRaptors: [Int] = []
var x = 0
//The first int in the Heights dict is the place in the Players array, the second one is the height of that player
var expHeights: [Int: Int] = [:]
var playerDividerCount = 0
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


//MARK: Creation of teams

// Use a while loop to check if a player is or is not experienced

while x < players.count {
    if players[x]["Experience"] == "YES" {
        // Player is experienced, append to experienced players array
        experiencedPlayers.append(x)
    } else {
        // Player is not experienced, append to not experienced players array
        notExperiencedPlayers.append(x)
    }
    x += 1
}

//Divide the experienced players over the teams, check the heights to be not too different

x = 0
var expSuccesDivided = false
expHeights.removeAll()
while x < experiencedPlayers.count {
    //Let's first get all the heights of the players
    expHeights.updateValue(Int(players[experiencedPlayers[x]]["Height"]!)!, forKey: experiencedPlayers[x])
    //Now divide the players over the teams
    while expSuccesDivided == false {
        var randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: experiencedPlayers.count)
        while usedNumbers.count < experiencedPlayers.count {
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
        var expDragonsAverageHeight: Int{
            var expDragonsTotalHeigt = 0
            for player in expDragons {
                expDragonsTotalHeigt = expDragonsTotalHeigt + Int(players[player]["Height"]!)!
            }
            return expDragonsTotalHeigt/expDragons.count
        }
        var expSharksAverageHeight: Int{
            var expSharksTotalHeight = 0
            for player in expSharks {
                expSharksTotalHeight = expSharksTotalHeight + Int(players[player]["Height"]!)!
            }
            return expSharksTotalHeight/expSharks.count
        }
        var expRaptorsAverageHeight: Int{
            var expRaptorsTotalheight = 0
            for player in expRaptors {
                expRaptorsTotalheight = expRaptorsTotalheight + Int(players[player]["Height"]!)!
            }
            return expRaptorsTotalheight/expRaptors.count
        }
        //Check if the average heights are not too different
        
        expSuccesDivided = true
    }
    
    
    x += 1
}





















