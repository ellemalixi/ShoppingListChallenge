//
//  ViewController.swift
//  ChallengeShoppingList
//
//  Created by Michelle Malixi on 3/13/23.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()
    var duplicate = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareShoppingList))
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshShoppingList))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
        
        tableView.reloadData()
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Enter item to Shopping list:", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submmitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submmitAction)
        present(ac, animated: true)
    }
    
    func submit(_ ans: String) {
        duplicate.removeAll(keepingCapacity: true)
        
        shoppingList.insert(ans, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func shareShoppingList() {
        let list = shoppingList.joined(separator: "\n")
        
        let avc = UIActivityViewController(activityItems: [list] as! [Any], applicationActivities: [])
        avc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(avc, animated: true)
    }
    
    @objc func refreshShoppingList() {
        shoppingList.removeAll(keepingCapacity:false)
        tableView.reloadData()
    }
}

