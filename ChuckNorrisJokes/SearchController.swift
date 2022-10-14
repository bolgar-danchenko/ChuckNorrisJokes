//
//  SearchController.swift
//  ChuckNorrisJokes
//
//  Created by Konstantin Bolgar-Danchenko on 14.10.2022.
//

import UIKit

class SearchController: UITableViewController, UISearchBarDelegate {

    var jokes: [String] = ["Start searching to get jokes"]

    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self

    }

    // MARK: - Search

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getJokeList(searchString: searchController.searchBar.text!) { jokeArray in
            DispatchQueue.main.async {
                self.jokes = jokeArray ?? []
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return jokes.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        )

        cell.textLabel?.text = jokes[indexPath.row]

        return cell
    }
}
