//
//  ContentView.swift
//  HW3
//
//  Created by Winnie on 2020/4/29.
//  Copyright © 2020 Winnie. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var brightnessAmount: Double = 0
    @State private var name = ""
    @State private var selectedDeparture = "Taoyuan"
    @State private var selectedCountry = "England"
    @State private var tourAlone = false
    @State private var selectedtTicket = ""
    @State private var dayTravel: Int = 1
    @State private var selectedAirplane = ""
    @State private var selectedClass = ""
    @State private var showAlert = false
    @State private var showSecondPage = false
    @State private var TravelTime = Date()
       let dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
       dateFormatter.dateStyle = .short
       return dateFormatter
    }()
    
    var Taiwan = ["Taoyuan", "Taipei", "Kaohsiung"]
    var countries = ["England", "France", "Japan", "UAE", "Hong Kong", "Singapore"]
    var airplanes = ["Air New Zealand (紐西蘭航空)", "Singapore Airlines (新加坡航空)", "ANA All Nippon Airways (全日空航空)", "Qantas (澳洲航空)", "Cathay Pacific (國泰航空)", "Emirates (阿聯酋航空)", "Virgin Atlantic (維珍航空)", "EVA Air (長榮航空)", "Qatar Airways (卡達航空)", "Virgin Australia (維珍澳洲航空)"]
    var Class = ["First Class", "Bussiness Class", "Economy Class"]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Image("\(self.selectedCountry)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.width / 4 * 3)
                        .clipped()
                        .brightness(self.brightnessAmount)
                    
                    Form {
                        BrightnessSlider(brightnessAmount: self.$brightnessAmount)
                        NameTextField(name: self.$name)
                        DatePicker("Time", selection: self.$TravelTime, in: Date()..., displayedComponents: .date)
                        DeparturePicker(selectedDeparture: self.$selectedDeparture)
                        CountryPicker(selectedCountry: self.$selectedCountry)
                        ClassPicker(selectedClass: self.$selectedClass)
                        Toggle("Travel alone?", isOn: self.$tourAlone)
                        if self.tourAlone{
                            Stepper(value: self.$dayTravel, in: 2...50, step:1){
                                Text("Travel \(self.dayTravel) days")
                            }
                            AirplanePicker(selectedAirplane: self.$selectedAirplane)
                        }
                    }
                    HStack {
                        Button(action: {
                            self.showSecondPage = true
                        }){
                            Image(systemName: "airplane")
                        }
                        .sheet(isPresented: self.$showSecondPage){
                            DetailView()
                        }
                        Button(action: {
                           self.showAlert = true
                        }){
                            Text("送出")
                        }.alert(isPresented: self.$showAlert) { () -> Alert in
                           return Alert(title: Text("成功"), dismissButton: .cancel())
                        }
                    }
                }.navigationBarTitle("走，一起旅行吧～")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BrightnessSlider: View {
    @Binding var brightnessAmount: Double   // Binding 參考@state,資料存取相同(同步)
    
    var body: some View {
        HStack {
            Text("亮度")
            Slider(value: self.$brightnessAmount, in: 0...1, minimumValueLabel: Image(systemName: "sun.max.fill").imageScale(.small), maximumValueLabel: Image(systemName: "sun.max.fill").imageScale(.large)) {
                Text("")
            }
            .accentColor(Color.purple)
        }
    }
}

struct NameTextField: View {
    @Binding var name: String
    
    var body: some View {
        TextField("你的名字", text: self.$name)
            //.padding()
            //.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct DeparturePicker: View {
    @Binding var selectedDeparture: String
    var Taiwan = ["Taoyuan", "Taipei", "Kaohsiung"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Departure")
            Picker(selection: self.$selectedDeparture, label: Text("Departure")) {
                ForEach(self.Taiwan, id:\.self) { (city) in
                    Text(city)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct CountryPicker: View {
    @Binding var selectedCountry: String
    var countries = ["England", "France", "Japan", "UAE", "Hong Kong", "Singapore"]
    
    var body: some View {
        VStack {
            Picker(selection: self.$selectedCountry, label: Text("country")) {
                ForEach(self.countries, id:\.self) { (country) in
                    Text(country)
                }
            }
            //.pickerStyle(WheelPickerStyle())
            //.pickerStyle(SegmentedPickerStyle())
        }
    }
}

//struct TravelDaySlider: View {
//    @Binding var dayTravel: CGFloat
//
//    var body: some View {
//        Stepper(value: self.$dayTravel, in: 2...50){
//            Text("Travel \(dayTravel) days")
//        }
//    }
//}

struct AirplanePicker: View {
    @Binding var selectedAirplane: String
    var airplanes = ["Air New Zealand (紐西蘭航空)", "Singapore Airlines (新加坡航空)", "ANA All Nippon Airways (全日空航空)", "Qantas (澳洲航空)", "Cathay Pacific (國泰航空)", "Emirates (阿聯酋航空)", "Virgin Atlantic (維珍航空)", "EVA Air (長榮航空)", "Qatar Airways (卡達航空)", "Virgin Australia (維珍澳洲航空)"]
    
    var body: some View {
        VStack {
            Picker(selection: self.$selectedAirplane, label: Text("airplane")) {
                ForEach(self.airplanes, id:\.self) { (airplane) in
                    Text(airplane)
                }
            }
        }
    }
}

struct ClassPicker: View {
    @Binding var selectedClass: String
    var Class = ["First Class", "Bussiness Class", "Economy Class"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Class")
            Picker(selection: self.$selectedClass, label: Text("Class")) {
                ForEach(self.Class, id:\.self) { (city) in
                    Text(city)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}
