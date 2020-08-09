//
//  DetailViewController.swift
//  JotItDown
//
//  Created by Kyle on 8/8/20.
//  Copyright © 2020 Kyle. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {
    
    var currentNote: Note?
    var noteIndex: Int!
    var delegate: ViewController!
    
    @IBOutlet weak var textArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissEditor))
              navigationController?.navigationItem.rightBarButtonItem = doneButton
        textArea.delegate = self
        
        if currentNote != nil {
            textArea.text = currentNote?.body
        }
        
        navigationController?.setToolbarHidden(false, animated: false)
        
        let trash = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbarItems = [trash, spacer]
        navigationController?.toolbar.barTintColor = UIColor.white
        navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        navigationController?.toolbar.tintColor = UIColor.systemYellow
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissEditor))
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        navigationItem.rightBarButtonItem = nil
    }
    
    @objc func dismissEditor() {
        saveNote()
        textArea.resignFirstResponder()
    }
    
    func saveNote() {
        
        if currentNote == nil {
            let textPreview = textArea.text.prefix(20)
            let newNote = Note(title: String(textPreview), body: textArea.text)
            
            self.delegate.saveToNotes(newNote)
            currentNote = newNote
        }
        else {
            let textPreview = textArea.text.prefix(20)
            currentNote?.body = textArea.text
            currentNote?.title = String(textPreview)
        }
        
        }
    
    @objc func deleteNote() {
        if currentNote != nil {
            delegate.notes.remove(at: noteIndex)
            delegate.save()
            delegate.tableView.reloadData()
            navigationController?.popViewController(animated: true)
        }
        else {
            textArea.text = ""
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
