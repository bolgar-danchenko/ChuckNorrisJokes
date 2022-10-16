//
//  Model.swift
//  ChuckNorrisJokes
//
//  Created by Konstantin Bolgar-Danchenko on 14.10.2022.
//

import Foundation

//https://api.chucknorris.io/jokes/random

struct Joke: Decodable {

    var value: String
    var id: String
    var url: String
}

struct Answer: Decodable {

    var total: Int
    var result: [Joke]
}

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
            let joke = try JSONDecoder().decode(Joke.self, from: superData)
            completion?(joke.value)
            return
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
    completion: ((_ jokeArray: [Joke]?
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
            let answer = try JSONDecoder().decode(Answer.self, from: data)
            completion?(answer.result)
            return

        } catch {
            print(error)
        }

        completion?(nil)
    }
    task.resume()
}
