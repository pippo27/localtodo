//
//  CreateTodoTableViewController.swift
//  Todo
//
//  Created by Arthit Thongpan on 27/3/2564 BE.
//

import UIKit
import SDCAlertView

class CreateTodoTableViewController: UITableViewController {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    var todo: Todo?
    var timer = Timer()
    var counter = 0
    fileprivate var image: UIImage? {
        didSet {
            if let img = image {
                imageView.image = img
                imageView.isHidden = false
            } else {
                imageView.image = nil
                imageView.isHidden = false
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textView.resignFirstResponder()
        stopTimer()
    }
    
    // MARK: - Save
    
    func createTodo() {
        guard validate() else {
            return
        }
        
        TodoManager.shared.createTodo(textView.text, image: image) { [weak self] _ in
            performSegue(withIdentifier: "CreateTodo", sender: nil)
        }
    }
    
    // MARK: - Validation
    
    func validate() -> Bool {
        guard let text =  textView.text, !text.isEmpty else {
            AlertController.alert(message: "กรุณาใส่ข้อมูลก่อนนะจ๊ะ", actionTitle: "ตกลง")
            return false
        }
        
        return true
    }
    
    func showError(error: String) {
        AlertController.alert(message: error, actionTitle: "ตกลง")
    }
    
    // MARK: - Actions
    
    @IBAction func takePhotoButtonTapped(_ sender: Any) {
        #if targetEnvironment(simulator)
            AlertController.alert(message: "กล้องถ่ายรูปไม่รองรับใน simulator", actionTitle: "ตกลง")
            return
        #else
        #endif
        
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        createTodo()
    }
}

// MARK: - UIImagePickerControllerDelegate

extension CreateTodoTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        self.image = image
    }
}

// MARK: - Timer

extension CreateTodoTableViewController {
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        counter += 1
        print("counter: \(counter)")
    }
    
    func stopTimer() {
        timer.invalidate()
    }

}
