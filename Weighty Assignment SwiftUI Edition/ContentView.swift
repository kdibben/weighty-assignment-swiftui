//
//  ContentView.swift
//  Weighty Assignment SwiftUI Edition
//
//  Created by Kelsie Dibben on 9/19/19.
//  Copyright © 2019 Kelsie Dibben. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var weight = ""
    @State private var reps = ""
    @State private var epley = 0.00
    @State private var brzycki = 0.00
    @State private var mcglothin = 0.00
    @State private var lombardi = 0.00
    @State private var mayhew = 0.00
    @State private var average = 0.00
    @State private var showingAlert = false
    var epley1 = 0.9
    static let taskNumberFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text("One-Rep Max")
                .fontWeight(.bold)
                .font(.system(size: 40))

            HStack {
                TextField("Weight", text: $weight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Reps", text: $reps)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
            
            VStack (alignment: .leading, spacing: 10){
                //Text(String(format: "%.2f", epley))
                Text("Brzycki \(brzycki)")
                Text("McGlothin \(mcglothin)")
                Text("Lombardi \(lombardi)")
                Text("Mayhew \(mayhew)")
                Text("Average \(average)")
                    .padding(.bottom)
            }
            
            HStack {
                Button(action: {
                    self.calculate()
                }){
                    Text("Calculate 1RM")
                        .padding(.trailing)
                        .padding(.trailing)
                        .padding(.trailing)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error!"), message: Text("You must enter a weight and number of reps"), dismissButton: .default(Text("OK")))
                }
                
                Button(action: {
                    self.clear()
                }){
                    Text("Clear All")
                        .padding(.leading)
                        .padding(.leading)
                        .padding(.leading)
                }
            }
            Spacer()
        }
    }
    
    func calculate() {
        if weight != "" && reps != "" {
            epley = Double(weight)! * (1 + (Double(reps)! / 30))
            brzycki = Double(weight)! * (36 / (37 - Double(reps)!))
            mcglothin = (100 * Double(weight)!) / (101.3 - 2.67123 * Double(reps)!)
            lombardi = Double(weight)! * pow(Double(reps)!, 0.10)
            mayhew = (100 * Double(weight)!) / (52.2 + (41.9 * pow(2.71828, (-0.055 * Double(reps)!))))
            let maxes = [epley, brzycki, mcglothin, lombardi, mayhew]
            var total = 0.0
            for max in maxes{
                total += max
            }
            average = total / Double(maxes.count)
        }
        else {
            showingAlert = true
        }
    }
    
    func clear() {
        epley = 0.00
        brzycki = 0.00
        mcglothin = 0.00
        lombardi = 0.00
        mayhew = 0.00
        average = 0.00
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
