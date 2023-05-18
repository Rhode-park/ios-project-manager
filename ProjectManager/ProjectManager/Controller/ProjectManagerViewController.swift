//
//  ProjectManager - ProjectManagerViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ProjectManagerViewController: UIViewController {
    var projects = Projects.shared.projects
    
    let projectManagerCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(ProjectCell.self, forCellWithReuseIdentifier: "ProjectCell")
        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: "HeaderCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureProjectManagerCollectionView()
        configureConstraint()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        title = "Project Manager"
        
        let addProjectButton = UIBarButtonItem(barButtonSystemItem: .add,
                                               target: self,
                                               action: #selector(addProject))
        navigationItem.rightBarButtonItem = addProjectButton
        
        projectManagerCollectionView.dataSource = self
        projectManagerCollectionView.delegate = self
    }
    
    @objc
    private func addProject() {
        let rootViewController = AddProjectViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    private func configureProjectManagerCollectionView() {
        view.addSubview(projectManagerCollectionView)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            projectManagerCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectManagerCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            projectManagerCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            projectManagerCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ProjectManagerViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let status = Status(rawValue: section)
        
        return projects.filter { $0.status == status }.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let status = Status(rawValue: indexPath.section) else { return ProjectCell() }
        let assignedProjects = projects.filter { $0.status == status }
        
        if indexPath.item == 0 {
            guard let cell = projectManagerCollectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else { return HeaderCell() }
            
            cell.configureContent(status: status, number: assignedProjects.count)
            
            return cell
        } else {
            guard let cell = projectManagerCollectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as? ProjectCell else { return ProjectCell() }
            
            let project = assignedProjects[indexPath.item - 1]
            cell.configureContent(title: project.title, body: project.body, date: "\(project.date)")
            cell.deleteRow = {
                guard let removeIndex = self.projects.firstIndex(where: { $0.id == project.id }) else { return }
                self.projects.remove(at: removeIndex)
                self.projectManagerCollectionView.reloadData()
            }
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
            
            return cell
        }
    }
}

extension ProjectManagerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            let width = collectionView.frame.width
            let height = collectionView.frame.height
            
            let itemsPerRow: CGFloat = 12
            let itemsPerColumn: CGFloat = 3
            
            let cellWidth = width / itemsPerColumn - 40
            let cellHeight = height / itemsPerRow
            
            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            let width = collectionView.frame.width
            let height = collectionView.frame.height
            
            let itemsPerRow: CGFloat = 8
            let itemsPerColumn: CGFloat = 3
            
            let cellWidth = width / itemsPerColumn - 40
            let cellHeight = height / itemsPerRow
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
}
