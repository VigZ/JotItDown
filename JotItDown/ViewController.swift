//
//  ViewController.swift
//  JotItDown
//
//  Created by Kyle on 8/8/20.
//  Copyright © 2020 Kyle. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, DetailViewDelegate {
    
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
            
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(createNote))
        
        let defaults = UserDefaults.standard
        
        if let savedNotes = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                notes = try jsonDecoder.decode([Note].self, from: savedNotes)
            } catch {
                print("Failed to load notes")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.items?[0].title = "\(notes.count) Notes"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)

        let note = notes[indexPath.row]
        cell.textLabel?.text = note.body
        cell.detailTextLabel?.text = note.formatDate()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        vc.delegate = self
        vc.currentNote = notes[indexPath.row]
        vc.noteIndex = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            print("Failed to save notes.")
        }
    }
    
    @objc func createNote() {
         let vc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func saveToNotes(_ note: Note) {
        notes.insert(note, at: 0)
        
        save()
        self.tableView.reloadData()
    }


}

