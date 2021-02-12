//
//  ContentViewText.swift
//  HW.2.ErrorAssesement
//
//  Created by Anthony Lim on 2/5/21.
//

import SwiftUI
import CorePlot

typealias plotDataType = [CPTScatterPlotField : Double]
		
struct ContentView: View {
    @EnvironmentObject var plotDataModel :PlotDataClass
    @ObservedObject private var sinCalculator = Sin_X_Calculator()
    @State var xInput: String = "\(Double.pi/2.0)"
    @State var sinOutput: String = "0.0"
    @State var computerSin: String = "\(sin(Double.pi/2.0))"
    @State var error: String = "0.0"
    @State var isChecked:Bool = false
  
    

    var body: some View {
        
        VStack{
      
            CorePlot(dataForPlot: $plotDataModel.plotData, changingPlotParameters: $plotDataModel.changingPlotParameters)
                .setPlotPadding(left: 10)
                .setPlotPadding(right: 10)
                .setPlotPadding(top: 10)
                .setPlotPadding(bottom: 10)
                .padding()
            
            Divider()
            
            HStack{
                
                HStack(alignment: .center) {
                    Text("x:")
                        .font(.callout)
                        .bold()
                    TextField("xValue", text: $xInput)
                        .padding()
                }.padding()
                
                HStack(alignment: .center) {
                    Text("sin(x):")
                        .font(.callout)
                        .bold()
                    TextField("sin(x)", text: $sinOutput)
                        .padding()
                }.padding()
                
                Toggle(isOn: $isChecked) {
                            Text("Display Error")
                        }
                .padding()
                
                
            }
            
            HStack{
                
                HStack(alignment: .center) {
                    Text("Expected:")
                        .font(.callout)
                        .bold()
                    TextField("Expected:", text: $computerSin)
                        .padding()
                }.padding()
                
                HStack(alignment: .center) {
                    Text("Error:")
                        .font(.callout)
                        .bold()
                    TextField("Error", text: $error)
                        .padding()
                }.padding()
            
                
            }
            
            
            HStack{
                Button("Calculate sin(x)", action: {self.calculateSin_X()} )
                .padding()
                
            }
            
        }
        
    }
    
    
    
    
    /// calculateCos_X
    /// Function accepts the command to start the calculation from the GUI
    func calculateSin_X(){
        
        let x = Double(xInput)
        xInput = "\(x!)"
        
        var sin_x = 0.0
        let actualsin_x = sin(x!)
        var errorCalc = 0.0
        
        //pass the plotDataModel to the sinCalculator
        sinCalculator.plotDataModel = self.plotDataModel
        
        //tell the cosCalculator to plot Data or Error
        sinCalculator.plotError = self.isChecked
        
        
        //Calculate the new plotting data and place in the plotDataModel
        sin_x = sinCalculator.calculate_sin_x(x: x!)
        

        print("The sin(\(x!)) = \(sin_x)")
        print("computer calcuates \(actualsin_x)")
        
        sinOutput = "\(sin_x)"
        
        computerSin = "\(actualsin_x)"
        
        if(actualsin_x != 0.0){
            
            var numerator = sin_x - actualsin_x
            
            if(numerator == 0.0) {numerator = 1.0E-16}
            
            errorCalc = log10(abs((numerator)/actualsin_x))
            
        }
        else {
            errorCalc = 0.0
        }
        
        error = "\(errorCalc)"
        
    }
    

   
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
