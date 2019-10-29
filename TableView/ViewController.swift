//
//  ViewController.swift
//  TableView
//
//  Created by brq on 26/10/2018.
//  Copyright © 2018 brq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tableView =  UITableView()
    
    let contacts = ["teste","Ateste","Ateeste","Asteric", "BTeste","CTeste","Carlos","Paulo","Telefone","MacBook","Livro","Basquete"]
    var dict = [String:[String]]()
    var titles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setupUI()
        constrains()
        configureDict()
    }

    func addSubView(){
        view.addSubview(tableView)
    }

    func configureDict(){
        for contact in contacts {
            let key = String(contact.prefix(1).uppercased())
            if var contactValue = dict[key]{
                contactValue.append(contact)
                dict[key] = contactValue
            }else{
                dict[key] = [contact]
                titles.append(key)
            }
        }
        
        titles.sort()
    }
    
    func setupUI(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func constrains(){
        tableView.anchor(top: (view.topAnchor, 0),
                         left: (view.leftAnchor ,0),
                         right: (view.rightAnchor, 0),
            bottom: (view.bottomAnchor , 0)
        )}

}


extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = titles[section]
        if let dict = dict[key]{
            return dict.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        print(indexPath.section)
        let key = titles[indexPath.section]
        if let contacts = dict[key]{
            cell.textLabel?.text = contacts[indexPath.row]
        }
        return cell
    }
}

