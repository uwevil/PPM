//
//  MyTableView.swift
//  
//
//  Created by Cao Sang DOAN on 23/11/15.
//
//

import UIKit

class MyTableViewController: UITableViewController,
    UINavigationControllerDelegate,
    UITableViewDelegate,
    UITableViewDataSource,
    UISplitViewControllerDelegate
{
    
    var navigation: UINavigationController?
    var splitView: MySplitViewController?
    
    private var count = 0
    private var container = NSMutableArray()
    
    var currentPrio = 0
    var currentTitle = ""
    var currentImage: UIImage?
    var currentNSIndexPath: NSIndexPath?
    
    var detail: DetailViewController?
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(frame: CGRect, style: UITableViewStyle) {
        super.init(style: style)
        self.tableView.separatorColor = UIColor.whiteColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLineEtched
        self.tableView.sectionHeaderHeight = 10.0
        self.tableView.sectionFooterHeight = 10.0
        
        let headerView = UIView(frame: CGRectMake(0, 0, frame.size.width, 40))
        headerView.addSubview(UIImageView(image: UIImage(named: "bg-header")))
        
        self.tableView.tableHeaderView = headerView
        
        for s in 0...3{
            var inSection = NSMutableArray()
            inSection.addObject(ACell(l: "Tâche", p: 0))
            container.addObject(inSection)
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.title = "Liste de tâches"
        
        self.navigationItem.title = "Liste de tâches"
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addCell:")
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addCell(sender: UIBarButtonItem){
        container[0].insertObject(ACell(l: "Tâche",p: 0), atIndex: 0)
        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
       
        var tableViewCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        tableViewCell!.textLabel?.text = "Tâche"
        tableViewCell!.detailTextLabel?.text = "Priorité: 0"
        tableViewCell!.imageView!.image = UIImage(named: "prio-0")
        self.tableView.reloadData()

    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return container.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return container[section].count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
        case 0:
            return "Vacances"
        case 1:
            return "Personnel"
        case 2:
            return "Urgent"
        default:
            return "Aujourd'hui"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellId = "id"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? UITableViewCell
        
        if (cell === nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellId)
        }
        
        let cellTmp = container[indexPath.section][indexPath.row] as! ACell
        
        cell!.textLabel!.text = cellTmp.label
        cell!.detailTextLabel?.text = String(format: "Priorité: %d", cellTmp.priority)
        cell!.backgroundView = UIImageView(image: UIImage(named: "bg-tableview"))
        cell!.imageView?.image = UIImage(named: String(format: "prio-%d", cellTmp.priority))
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            container[indexPath.section].removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }else if (editingStyle == UITableViewCellEditingStyle.Insert){
            let cell = ACell(l: "Tâche",p: 0)
            container[indexPath.section].insertObject(cell, atIndex: indexPath.row)
            var tmp = tableView.dequeueReusableCellWithIdentifier("id") as? UITableViewCell
            if (tmp === nil){
                tmp = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "id")
            }
            
            tmp!.textLabel?.text = cell.label
            tmp!.detailTextLabel?.text = String(format: "Priorité: %d", cell.priority)
            tmp!.backgroundView = UIImageView(image: UIImage(named: "bg-tableview"))
            tmp!.imageView?.image = UIImage(named: String(format: "prio-%d", cell.priority))
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let tmp = container[sourceIndexPath.section][sourceIndexPath.row] as! ACell
        container[destinationIndexPath.section].insertObject(tmp, atIndex: destinationIndexPath.row)
        container[sourceIndexPath.section].removeObjectAtIndex(sourceIndexPath.row)
        
        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentNSIndexPath = indexPath
        var cell = container[indexPath.section].objectAtIndex(indexPath.row) as! ACell
        
        currentTitle = cell.label
        currentPrio = cell.priority
        currentImage = cell.image
        
        detail = DetailViewController()
        detail!.setViewController(self)
        detail!.setTitle1(cell.label)
        detail!.setPriority(cell.priority)
        if (cell.image !== nil){
            detail!.setImage(cell.image!)
        }
        
        
        navigation!.pushViewController(detail!, animated: true)
    }
    
    func refresh(){
        var cell = container[currentNSIndexPath!.section].objectAtIndex(currentNSIndexPath!.row) as! ACell
        cell.label = currentTitle
        cell.priority = currentPrio
        if (currentImage != nil){
            cell.image = currentImage
        }
        
        var tableViewCell = self.tableView.cellForRowAtIndexPath(currentNSIndexPath!)
        tableViewCell!.textLabel?.text = currentTitle
        tableViewCell!.detailTextLabel?.text = String(format: "Priorité: %d", currentPrio)
        tableViewCell!.imageView!.image = UIImage(named: String(format: "prio-%d", currentPrio))
        
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func splitViewController(svc: UISplitViewController, willChangeToDisplayMode displayMode: UISplitViewControllerDisplayMode) {
        if (displayMode == UISplitViewControllerDisplayMode.PrimaryHidden){
            splitView?.detailViewController?.navigationController?.topViewController.navigationItem.leftBarButtonItem = svc.displayModeButtonItem()
        }
        
        if (displayMode == UISplitViewControllerDisplayMode.AllVisible){
            splitView?.detailViewController?.navigationController?.topViewController.navigationItem.leftBarButtonItem = nil
        }
    }
    
    func targetDisplayModeForActionInSplitViewController(svc: UISplitViewController) -> UISplitViewControllerDisplayMode {
        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone){
            return UISplitViewControllerDisplayMode.AllVisible
        }else{
            return UISplitViewControllerDisplayMode.PrimaryOverlay
        }
    }
    
    
}
























