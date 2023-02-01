//
//  CalculatorView.swift
//  Calculator
//
//  Created by Иван Степанов on 31.01.2023.
//

import SwiftUI
import internetConnectionCheckFramework

struct CalculatorView: View {
    
    @StateObject private var viewModel: CalculatorViewModel = CalculatorViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                Text(viewModel.calculationText)
                    .font(.system(size: geometry.size.width / 10))
                
                Spacer()
                
                LazyVGrid(columns: viewModel.columns){
                    ForEach(0..<20){ i in
                        ZStack{
                            if i == 17{
                                if internetConnectionFrameworkClass.isConnectedToNetwork(){
                                    circlesCreation(color: .gray)
                                        .opacity(0.5)
                                        .frame(width: viewModel.buttonSize(geometry), height: viewModel.buttonSize(geometry))
                                    
                                    Text(viewModel.calculatorButtonsTitles[i])
                                        .font(.system(size: geometry.size.width / 20))
                                }else{
                                    
                                }
                            }else{
                                if i < 3{
                                    circlesCreation(color: .gray)
                                        .frame(width: viewModel.buttonSize(geometry), height: viewModel.buttonSize(geometry))
                                }else if i == 3 || i == 7 || i == 11 || i == 15 || i == 19{
                                    circlesCreation(color: .orange)
                                        .frame(width: viewModel.buttonSize(geometry), height: viewModel.buttonSize(geometry))
                                }else{
                                    circlesCreation(color: .gray)
                                        .opacity(0.5)
                                        .frame(width: viewModel.buttonSize(geometry), height: viewModel.buttonSize(geometry))
                                }
                                
                                Text(viewModel.calculatorButtonsTitles[i])
                                    .font(.system(size: geometry.size.width / 20))
                                
                            }
                            
                            
                        }
                        .onTapGesture {
                            viewModel.calculationFunction(in: i)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}











struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}

struct circlesCreation: View {
    var color = Color.gray
    
    var body: some View {
        Circle()
            .foregroundColor(color)
    }
}
