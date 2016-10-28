//: Playground - noun: a place where people can play

import UIKit

//MARK: Variables and constants

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
var experiencedPlayers: [Int] = []
var notExperiencedPlayers: [Int] = []
var dragons: [Int] = []
var sharks: [Int] = []
var raptors: [Int] = []

//MARK: Start of logic code

// Use a while loop to check if a player is or is not experienced
var x = 0
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

//Divide the players over the teams, check the heights to be not too different

x = 0
var expHeights: [String: String] = ["":""]
expHeights.removeAll()
while x < experiencedPlayers.count {
    // First take the heights
    
    expHeights.updateValue(players[x]["Height"]!, forKey: players[x]["Name"]!)
    
    x += 1
}




















