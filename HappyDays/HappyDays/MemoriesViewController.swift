//
//  MemoriesViewController.swift
//  HappyDays
//
//  Created by Maksim Nosov on 30/05/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Speech

class MemoriesViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var memories = [URL]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadMemories()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkPermissions()
    }
    
    @objc func addTapped() {
        let vc = UIImagePickerController()
        vc.modalPresentationStyle = .formSheet
        vc.delegate = self
        navigationController?.present(vc, animated: true)
    }
    
    func checkPermissions() {
        // check status for all three permissions
        let photosAuthorized = PHPhotoLibrary.authorizationStatus() == .authorized
        let recordingAuthorized = AVAudioSession.sharedInstance().recordPermission == .granted
        let transcribeAuthorized = SFSpeechRecognizer.authorizationStatus() == .authorized
        
        // make a single boolean out of all three
        let authorized = photosAuthorized && recordingAuthorized && transcribeAuthorized
        
        // if we're missing one, show the first run screen
        if authorized == false {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "FirstRun") {
                navigationController?.present(vc, animated: true)
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func loadMemories() {
        memories.removeAll()
        
        // attempt to load all the memories in our documents directory
        guard let files = try? FileManager.default.contentsOfDirectory(at: getDocumentsDirectory(), includingPropertiesForKeys: nil, options: []) else { return }
        
        // loop over every file found
        for file in files {
            let filename = file.lastPathComponent
            
            // check it ends with ".thumb" so we don't count each memory more than once
            if filename.hasSuffix(".thumb") {
                // get the root name of the memory (i.e., without its path extension)
                let noExtension = filename.replacingOccurrences(of: ".thumb", with: "")
                
                // create a full path from the memory
                let memoryPath = getDocumentsDirectory().appendingPathComponent(noExtension)
                
                // add it to our array
                memories.append(memoryPath)
            }
        }
        
        // reload our list of memories
        collectionView.reloadSections(IndexSet(integer: 1))
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        
        if let possibleImage = info[.originalImage] as? UIImage {
            saveNewMemory(image: possibleImage)
            loadMemories()
        }
    }
    
    func saveNewMemory(image: UIImage) {
        // create a unique name for this memory
        let memoryName = "memory-\(Date().timeIntervalSince1970)"
        
        // use the unique name to create filenames for the full-size image and the thumbnail
        let imageName = memoryName + ".jpg"
        let thumbnailName = memoryName + ".thumb"
        
        do {
            // create a URL where we can write the JPEG to
            let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
            
            // convert the UIImage into a JPEG data object
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                // write that data to the URL we created
                try jpegData.write(to: imagePath, options: [.atomicWrite])
            }
            
            // create thumbnail here
        } catch {
            print("Failed to save to disk.")
        }
    }
    
}
