//
//  Model.swift
//  ChuckNorrisJokes
//
//  Created by Konstantin Bolgar-Danchenko on 14.10.2022.
//

import Foundation

//https://api.chucknorris.io/jokes/random

func getRandomJoke(completion: ( ( _ joke: String? ) -> Void )? ) {

    let session = URLSession(configuration: .default)

    let task = session.dataTask(with: URL(string: "https://api.chucknorris.io/jokes/random")!) {superData, myResponse, error in

        if let error {
            print(error.localizedDescription)
            completion?(nil)
            return
        }

        if (myResponse as! HTTPURLResponse).statusCode != 200 {
            print("Status code != 200, status code = \((myResponse as! HTTPURLResponse).statusCode)")
            completion?(nil)
            return
        }

        guard let superData else {
            print("data = nil")
            completion?(nil)
            return
        }

        do {
            let answer = try JSONSerialization.jsonObject(with: superData) as? [String: Any]
            if let joke = answer?["value"] as? String {
                completion?(joke)
                return
            } else {
                print("Error. Invalid json format")
            }
        } catch {
            print(error)
        }
        completion?(nil)
    }
    task.resume()
}

//https://api.chucknorris.io/jokes/search?query=girl

func getJokeList(
    searchString string: String,
    completion: ((_ jokeArray: [String]?
                 ) -> Void)? ) {

    let urlString = "https://api.chucknorris.io/jokes/search?query=\(string)"
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: URL(string: urlString)!) { data, responce, error in

        if let error {
            print(error.localizedDescription)
            completion?(nil)
            return
        }

        if (responce as? HTTPURLResponse)?.statusCode != 200 {
            print("Status code != 200")
            completion?(nil)
            return
        }

        guard let data else {
            print("data = nil")
            completion?(nil)
            return
        }

        do {
            let answer = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            let arrayDict = (answer?["result"] as? [[String: Any]]) ?? []

            var returnArray: [String] = []
            for dict in arrayDict {
                if let joke = dict["value"] as? String {
                    returnArray.append(joke)
                }
            }
            completion?(returnArray)
            return

        } catch {
            print(error)
        }

        completion?(nil)
    }
    task.resume()
}
