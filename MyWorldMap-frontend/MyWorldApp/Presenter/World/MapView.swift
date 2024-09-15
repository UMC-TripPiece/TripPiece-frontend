//
//  MapView.swift
//  MergeWithSwiftUI
//
//  Created by 김서현 on 8/12/24.
//

import SwiftUI
import InteractiveMap

struct MapView: View {
    
    
        
    @ObservedObject var mapViewModel = MapViewModel()
    @ObservedObject var countryColorViewModel = UserCountryColorsModel()
    
    var onLocationSelected: (() -> Void)?
    
    
    var body: some View {
        VStack {
            GeometryReader { geometry in

                ZoomableContainer(selectedCountry: $mapViewModel.selectedCountry) {
                    InteractiveMap(svgName: "world-low") { pathData in
                        
                        InteractiveShape(pathData)
                            .stroke(.white, lineWidth: 0.4)
                            //.background(InteractiveShape(pathData).fill(viewModel.selectedCountry == pathData ? .blue : Color(white: 0.75)))
                            .background(InteractiveShape(pathData).fill(getCountryColor(for: pathData.id)))
                            .zIndex(mapViewModel.selectedCountry == pathData ? 2 : 1)
                            .animation(.easeInOut(duration: 0.3), value: mapViewModel.selectedCountry)
                            .onChange(of: mapViewModel.selectedCountryName) {
                                processPathData(pathData)
                            }
                            .onTapGesture {
                                shouldTriggerNavigation(for: pathData.id) ? onLocationSelected?() : ()
                            }

    
                        
                           }
                       }
                   }
            
               }
           }

    
    // MapView 내부에 정의된 함수
    func getCountryColor(for id: String) -> Color {
        if let colorString = countryColorViewModel.userSavedCountryColors[id] {
            switch colorString {
            case "BLUE":
                return Color(red: 103/255, green: 68/255, blue: 255/255)
            case "YELLOW":
                return Color(red: 255/255, green: 180/255, blue: 15/255)
            case "CYAN":
                return Color(red: 37/255, green: 206/255, blue: 193/255)
            case "RED":
                return Color(red: 253/255, green: 45/255, blue: 105/255)
            default:
                return Color(white: 0.75)
            }
        } else {
            return Color(white: 0.75)
          }
    }
    
    func shouldTriggerNavigation(for id: String) -> Bool {
        return countryColorViewModel.userSavedCountryColors[id] != nil
    }

    
    
    func processPathData(_ pathData: PathData) {
        if mapViewModel.selectedCountryName == pathData.id {
            mapViewModel.selectedCountry = pathData
        }
    }
    
    

           
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MapView()
        }
    }
    
    
    
    
}
