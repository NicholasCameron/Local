//
//  Register01.swift
//  Yard Sale 00
//
//  Created by Nicholas Cameron on 2016-10-25.
//  Copyright © 2016 Nick J Cameron. All rights reserved.
//

import UIKit

var mondayHours = String();
var tuesdayHours = String();
var wednesdayHours = String();
var thrusdayHours = String();
var fridayHours = String();
var satudayHours = String();
var sundayHours = String();

class Register01: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate  {

    
    var startOrEndDate = 1;
    
    @IBOutlet weak var btnMonday: UIButton!
    @IBOutlet weak var btnTu: UIButton!
    @IBOutlet weak var tDatePicked: UIButton!
    @IBOutlet weak var btnFriday: UIButton!
    @IBOutlet weak var btnSaturday: UIButton!
    @IBOutlet weak var btnSunday: UIButton!
    @IBOutlet weak var wDatePicked: UIButton!

    
    @IBOutlet weak var lblMonday: UILabel!
    @IBOutlet weak var lblTuesday: UILabel!
    @IBOutlet weak var lblWednesday: UILabel!
    @IBOutlet weak var lbThursday: UILabel!
    @IBOutlet weak var lblFriday: UILabel!
    @IBOutlet weak var lblSaturday: UILabel!
    @IBOutlet weak var lblSunday: UILabel!
    
    @IBOutlet weak var btnMondayReset: UIButton!
    @IBOutlet weak var btnTuesdayClose: UIButton!
    @IBOutlet weak var btnWednesdayClose: UIButton!
    @IBOutlet weak var btnThursdayClose: UIButton!
    @IBOutlet weak var btnFridayClose: UIButton!
    @IBOutlet weak var btnSaturdayClose: UIButton!
    @IBOutlet weak var btnSundayClose: UIButton!
    
    
    var openTime = String();
    var closeTime = String();

    
    @IBOutlet weak var Scroll0: UIPickerView!
    
    @IBOutlet weak var PickerView0: UIPickerView!
    

    
    @IBOutlet weak var PickerView: UIPickerView!
    
    
    
    var firstHour = ["1", "2","3","4","5","6","7","8","9","10","11","12"];
    var firstMinute = ["00", "15","30","45"];
    var timeOfDay = ["Am", "Pm"];

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PickerView.tag = 0;
        PickerView0.tag = 1;
openTime = "1:00AM";
closeTime = "1:00AM";

        
        self.view.ViewBackground(image: "halfWater0")
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, H:mm a"
        //dateFormatter.dateStyle = DateFormatter.Style.medium
        //        self.StartDate.text = dateFormatter.string(from: DatePicker.date)
        
    }
    
    
    //MAKING THE BUTTONS TURN FROM GREEN TO GREY ON SELECTED
    ////////////////////////////////////////////////////////////////////////////
    @IBAction func chooseDate(_ sender: Any) {
        if(btnMonday.backgroundColor != UIColor.green){
            btnMonday.backgroundColor = UIColor.green;
        }else{
            btnMonday.backgroundColor = UIColor.white;
            
        }
    }
    
       @IBAction func tuDatePicked(_ sender: Any) {
        if(btnTu.backgroundColor != UIColor.green){
            btnTu.backgroundColor = UIColor.green;
        }else{
            btnTu.backgroundColor = UIColor.white;
            
        }

    }
    
    @IBAction func wDatePicked(_ sender: Any) {
        if(wDatePicked.backgroundColor != UIColor.green){
            wDatePicked.backgroundColor = UIColor.green;
        }else{
            wDatePicked.backgroundColor = UIColor.white;
            
        }

    }

    
    @IBAction func tDatePicked(_ sender: Any) {
        if(tDatePicked.backgroundColor != UIColor.green){
            tDatePicked.backgroundColor = UIColor.green;
        }else{
            tDatePicked.backgroundColor = UIColor.white;
            
        }

    }
    @IBAction func fDatePicked(_ sender: Any) {
        if(btnFriday.backgroundColor != UIColor.green){
            btnFriday.backgroundColor = UIColor.green;
        }else{
            btnFriday.backgroundColor = UIColor.white;
            
        }

    }

    
    @IBAction func saDatePicked(_ sender: Any) {
        if(btnSaturday.backgroundColor != UIColor.green){
            btnSaturday.backgroundColor = UIColor.green;
        }else{
            btnSaturday.backgroundColor = UIColor.white;
            
        }

    }
    
    
    
    @IBAction func btnHoursContinue(_ sender: Any) {
        
        
        mondayHours = lblMonday.text!;
        tuesdayHours = lblTuesday.text!;
        wednesdayHours = lblWednesday.text!;
        thrusdayHours = lblTuesday.text!;
        fridayHours = lblFriday.text!;
        satudayHours = lblSaturday.text!;
        sundayHours = lblSunday.text!;
        
        BusinessProperties.properties.businessHours.append(mondayHours)
        BusinessProperties.properties.businessHours.append(tuesdayHours)
        BusinessProperties.properties.businessHours.append(wednesdayHours)
        BusinessProperties.properties.businessHours.append(thrusdayHours)
        BusinessProperties.properties.businessHours.append(fridayHours)
        BusinessProperties.properties.businessHours.append(satudayHours)
        BusinessProperties.properties.businessHours.append(sundayHours)

        
    }
    @IBAction func sDatePicked(_ sender: Any) {
        if(btnSunday.backgroundColor != UIColor.green){
            btnSunday.backgroundColor = UIColor.green;
        }else{
            btnSunday.backgroundColor = UIColor.gray;
            
        }

    }
    
        ////////////////BTN RESET TO MAKE LBLS CLOSED
    @IBAction func btnMondayClose(_ sender: Any) {
    
        lblClosedBtnHidden(label: lblMonday, btnTohide: btnMondayReset)

           }
    
    @IBAction func btnTuesdayClosed(_ sender: Any) {
     
        lblClosedBtnHidden(label: lblTuesday, btnTohide: btnTuesdayClose)
   

    }
    @IBAction func btnWednesdayClose(_ sender: Any) {
        lblClosedBtnHidden(label: lblWednesday, btnTohide: btnWednesdayClose)
    }
    @IBAction func btnThursdayClose(_ sender: Any) {
        lblClosedBtnHidden(label: lbThursday, btnTohide: btnThursdayClose)

    }
    
    @IBAction func btnFridayClose(_ sender: Any) {
        lblClosedBtnHidden(label: lblFriday, btnTohide: btnFridayClose)

    }
    @IBAction func btnSaturdayClose(_ sender: Any) {
        lblClosedBtnHidden(label: lblSaturday, btnTohide: btnSaturdayClose)

    }
    
    @IBAction func btnSundayClose(_ sender: Any) {
        lblClosedBtnHidden(label: lblSunday, btnTohide: btnSundayClose)

    }
    
    func lblClosedBtnHidden(label:UILabel,btnTohide:UIButton){
        
        label.text = "Closed"
        btnTohide.isHidden = true
        
    }
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////
    
    
    
    @IBAction func setHours(_ sender: Any) {
        
        
        let selectedDates =   lblsToUpdate(selectedBtns: checkDatesSelected());
        
        
        btnMonday.backgroundColor = UIColor.white
        btnTu.backgroundColor = UIColor.white
         tDatePicked.backgroundColor = UIColor.white
         btnFriday.backgroundColor = UIColor.white
         btnSaturday.backgroundColor = UIColor.white
         btnSunday.backgroundColor = UIColor.white
        wDatePicked.backgroundColor = UIColor.white
        

        
        
        
        for date in selectedDates{
            date.text = openTime + " To " + closeTime;
        }

        
        
    }
    
    
    
    
    func checkDatesSelected()-> [UIButton]{
        
        var datesSelected = [UIButton]();
        
        if(btnMonday.backgroundColor == UIColor.green){
            datesSelected.append(btnMonday)
        }
        if(btnTu.backgroundColor == UIColor.green){
            datesSelected.append(btnTu);
        }
        if(wDatePicked.backgroundColor == UIColor.green){
            datesSelected.append(wDatePicked);
        }
        if(tDatePicked.backgroundColor == UIColor.green){
            datesSelected.append(tDatePicked);
        }
        if(btnFriday.backgroundColor == UIColor.green){
            datesSelected.append(btnFriday);
        }
        if(btnSaturday.backgroundColor == UIColor.green){
            datesSelected.append(btnSaturday);
        }
        if(btnSunday.backgroundColor == UIColor.green){
            datesSelected.append(btnSunday);
        }else{
            
        }
        
        return datesSelected;
        
        
    }
    
    
    func lblsToUpdate(selectedBtns: [UIButton])->[UILabel]{
        
        
        var lblsToChange = [UILabel]();

        
        for date in selectedBtns{
            
            if(date == btnMonday){
                lblsToChange.append(lblMonday);
                btnMondayReset.isHidden = false;
            }
            if(date == btnTu){
                lblsToChange.append(lblTuesday);
                btnTuesdayClose.isHidden = false
            }
            if(date == wDatePicked){
                lblsToChange.append(lblWednesday);
                btnWednesdayClose.isHidden = false
            }
            if(date == tDatePicked){
                lblsToChange.append(lbThursday);
                btnThursdayClose.isHidden = false
            }
            if(date == btnFriday){
                lblsToChange.append(lblFriday);
                btnFridayClose.isHidden = false
            }
            if(date == btnSaturday){
                lblsToChange.append(lblSaturday);
                btnSaturdayClose.isHidden = false
            }
            if(date == btnSunday){
                lblsToChange.append(lblSunday);
                btnSundayClose.isHidden = false
            }else{
                
            }
        }
        return lblsToChange;
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // use the row to get the selected row from the picker view
        // using the row extract the value from your datasource (array[row])
        
        
       
        
      
       let selectedDates =   lblsToUpdate(selectedBtns: checkDatesSelected());
        
        
    
        if(pickerView.tag == 0){
            openTime = "";

            openTime += String(firstHour[pickerView.selectedRow(inComponent: 0)]);
            openTime += ":";
            openTime += String(firstMinute[pickerView.selectedRow(inComponent: 1)]);
            openTime += " ";
            openTime += String(timeOfDay[pickerView.selectedRow(inComponent: 2)]);
            
            
          

            
        }else{
            closeTime = "";

            closeTime += String(firstHour[pickerView.selectedRow(inComponent: 0)]);
            closeTime += ":";
            closeTime += String(firstMinute[pickerView.selectedRow(inComponent: 1)]);
            closeTime += " ";
            closeTime += String(timeOfDay[pickerView.selectedRow(inComponent: 2)]);

        }
        
        for date in selectedDates{
            date.text = openTime + " To " + closeTime;
        }
        
        
        
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0)
        {
            return firstHour[row]

        }else if(component == 1){
            
            return firstMinute[row]

        }else
        {
            return timeOfDay[row]

        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0)
        {
            return firstHour.count
            
        }else if(component == 1){
            
            return firstMinute.count
            
        }else
        {
            return timeOfDay.count
            
        }
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 3;
    }
}
