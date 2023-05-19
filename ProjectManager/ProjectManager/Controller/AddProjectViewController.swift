//
//  ProjectManager - AddProjectViewController.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class AddProjectViewController: UIViewController {
    var projectManagerViewController: ProjectManagerViewController?
    var projects = Projects.shared
    var project: Project?
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureContentStackView()
        configureConstraint()
    }
    
    func configureEditingStatus(isEditible: Bool) {
        if !isEditible {
            titleTextField.isEnabled = false
            datePicker.isEnabled = false
            bodyTextView.isEditable = false
            
            let editButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                             target: self,
                                             action: #selector(editProject))
            navigationItem.leftBarButtonItem = editButton
        } else {
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                               target: self,
                                               action: #selector(cancelEditingProject))
            navigationItem.leftBarButtonItem = cancelButton
        }
    }
    
    func configureProject(assignedProject: Project) {
        project = assignedProject
        
        guard let date = project?.date else { return }
        
        titleTextField.text = project?.title
        bodyTextView.text = project?.body
        datePicker.date = date
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = UIColor(displayP3Red: 200/255,
                                                                      green: 200/255,
                                                                      blue: 200/255, alpha: 0.5)
        
        title = "TODO"
        

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneEditingProject))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc
    private func editProject() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector(cancelEditingProject))
        navigationItem.leftBarButtonItem = cancelButton
        
        enableView()
    }
    
    @objc
    private func doneEditingProject() {
        guard let title = titleTextField.text else { return }
        guard let body = bodyTextView.text else { return }
        let date = datePicker.date
        
        if project == nil {
            let project = Project(title: title, body: body, date: date, status: .todo)
            projects.list.append(project)
            projectManagerViewController?.projectManagerCollectionView.reloadData()
        } else {
            
        }
        self.dismiss(animated: true)
    }
    
    @objc
    private func cancelEditingProject() {
        self.dismiss(animated: true)
        enableView()
    }
    
    private func enableView() {
        titleTextField.isEnabled.toggle()
        datePicker.isEnabled.toggle()
        bodyTextView.isEditable.toggle()
    }
    
    private func configureContentStackView() {
        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleTextField)
        contentStackView.addArrangedSubview(datePicker)
        contentStackView.addArrangedSubview(bodyTextView)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bodyTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            bodyTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bodyTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
