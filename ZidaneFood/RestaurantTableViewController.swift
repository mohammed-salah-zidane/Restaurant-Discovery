//
//  RestaurantTableViewController.swift
//  ZidaneFood
//
//  Created by Mohamed Salah Zidane on 8/28/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit
import CoreData
class RestaurantTableViewController: UITableViewController,NSFetchedResultsControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate {
    
    @IBOutlet var searchFooter: UILabel!
    
    var restaurants :[RestaurantMO] = []
    var fetchResultController :NSFetchedResultsController<RestaurantMO>!
    var searchController : UISearchController!
    var searchResults : [RestaurantMO] = []
    //   var isChecked = false
    
   // var checkAction = UIAlertAction()
   // var checkTitle = ""
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
        navigationController?.hidesBarsOnSwipe = true
        let fetchRequest :NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDiscriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDiscriptor]
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let contex = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: contex, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do
            {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    restaurants = fetchedObjects
                }
            }catch{
                print(error)
            }
        }
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        hideFooter()
        tableView.tableFooterView?.isHidden = true

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
    
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor(red: 250.0/255.0, green: 77.0/255.0, blue: 35.0/255.0,alpha: 1.0)
        
        searchController.searchBar.placeholder = "Search For Restaurants..."
        definesPresentationContext = true
       
        if #available(iOS 11.0, *) {
            //navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = true
        }
        searchController.searchBar.scopeButtonTitles = ["All", "Sea Food", "Candy", "Popular"]
        searchController.searchBar.delegate = self
    }
 
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContent(for: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
           let searchBar = searchController.searchBar
            let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
            filterContent(for: searchText,scope: scope)
            tableView.reloadData()
        }
    }
    func isFiltering()->Bool{
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    func filterContent(for searchText:String,scope:String = "All"){
        searchResults = restaurants.filter({ (restaurant) -> Bool in
            if let name = restaurant.name, let location = restaurant.location ,let type = restaurant.type{
                let isMatch = name.lowercased().contains(searchText.lowercased()) ||  location.lowercased().contains(searchText.lowercased()) ||  type.lowercased().contains(searchText.lowercased())
                
                let doesTypeMatch = (scope == "All" ) || (type.lowercased() == scope.lowercased())
                if searchBarIsEmpty(){
                    return doesTypeMatch
                }else{
                    return isMatch && doesTypeMatch
                
                }
                
            }
            return false
        })
    }
    func isFliteringToShow(filterItemCount:Int , of totalItemCount:Int){
        if filterItemCount == 0 {
            searchFooter.text = "No items match your query"
            showFooter()
        }else{
            searchFooter.text = "Filtering \(filterItemCount) of \(totalItemCount)"
            showFooter()
        }
    }
    func notFilteringToShow(){
        searchFooter.text = ""
        hideFooter()
    }
    func showFooter() {
        tableView.tableFooterView?.isHidden = false
        UIView.animate(withDuration: 0.7) {[unowned self] in
            self.searchFooter.alpha = 1.0
        }
    }
    func hideFooter() {
        UIView.animate(withDuration: 0.7) {[unowned self] in
            self.searchFooter.alpha = 0.0
        }
        tableView.tableFooterView?.isHidden = true
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        if let fetchedObjects = controller.fetchedObjects {
            restaurants = fetchedObjects as! [RestaurantMO]
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
   
    }
    override func viewDidAppear(_ animated: Bool) {
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        if isFiltering() {
            isFliteringToShow(filterItemCount: searchResults.count, of: restaurants.count)
          return  searchResults.count
        }else{
            notFilteringToShow()
            return restaurants.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantTableViewCell

        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        let restaurant = isFiltering() ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        cell.nameLabel?.text = restaurant.name
        cell.thumbnailImageView?.image = UIImage(data: restaurant.image!)
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        // Configure the cell...

        cell.accessoryType = restaurant.isVisited ? .checkmark : .none
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexpath = tableView.indexPathForSelectedRow {
                let destinationViewController = segue.destination as! RestaurantDetailViewController
                destinationViewController.restaurant = isFiltering() ? searchResults[indexpath.row]: restaurants[indexpath.row]
            }
        }
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let alert = UIAlertController(title: nil, message: "What do you want?", preferredStyle: .actionSheet)
//        let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        let callAction = UIAlertAction(title: "Call 010-12145-\(indexPath.row)", style: .default) { (action: UIAlertAction!) in
//            let unavailableAlert = UIAlertController(title: "Service unavailable  ", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
//            let unavailableAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            unavailableAlert.addAction(unavailableAlertAction)
//            self.present(unavailableAlert,animated: true ,completion: nil)
//            }
//        checkTitle = self.restaurantIsVisited[indexPath.row] ? "Undo check in" :  "Check in"
//        let checkIn = UIAlertAction(title:  checkTitle, style: .default) { (action: UIAlertAction!) in
//            let cell = tableView.cellForRow(at: indexPath)
//            self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ?  false : true
//            cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ?  .checkmark : .none
//
//            }
//            checkAction = checkIn
//
//        alert.addAction(alertAction)
//        alert.addAction(callAction)
//        alert.addAction(checkAction)
//        present(alert,animated: true,completion: nil)
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            restaurants.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//        }
//
//        //else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        //}
//          //tableView.reloadData()
//    }
//
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .default, title: "Share", handler: {
            (action,indexPath) -> Void in
            let defaultText = "just check in " + self.restaurants[indexPath.row].name!
            if let imageToShare = UIImage(data: self.restaurants[indexPath.row].image!){
            let activityController = UIActivityViewController(activityItems: [defaultText,imageToShare], applicationActivities: nil)
            self.present(activityController,animated: true,completion: nil)
          }
        })
        let deleteAction = UITableViewRowAction(style:  UITableViewRowActionStyle.default, title: "Delete",handler: { (action,
                indexPath) -> Void in
                // Delete the row from the data source
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let deletedRestaurant = self.fetchResultController.object(at: indexPath)
                context.delete(deletedRestaurant)
                appDelegate.saveContext()
            }
        })
        shareAction.backgroundColor = UIColor(red: 48.0/255.0, green: 173.0/255.0,
                                              blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0,
                                               blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive{
            return false
        }else{

            return true
        }
    }
   
        
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
