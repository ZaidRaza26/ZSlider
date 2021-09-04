//
//  Zslider.swift
//  ZSlider
//
//  Created by Zaid Raza on 29/08/2021.
//

import SwiftUI

struct ZSlider: View {
    
    @State var sliderHeight: CGFloat
    
    @Binding var result: Double
    
    private var outerHeight: CGFloat
    private var outerWidth: CGFloat
    
    private var fillColor: [Color]
    private var unfillColor: [Color]

    /// This returns a Slider View and a value between 0.0 and 1.0 representing how much is filled. The value is returned in `onChange() modifier`.
  
    init(size: CGSize,
         fillPercentage: CGFloat,
         fillColor: [Color],
         unfillColor: [Color],
         result: Binding<Double>) {
        self.outerWidth = size.width
        self.outerHeight = size.height
        self.fillColor = fillColor
        self.unfillColor = unfillColor
        _sliderHeight = State(initialValue: outerHeight * (1 - fillPercentage))
        self._result = result
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                if value.location.y > outerHeight {
                    result = 0.0
                }
                else if value.location.y < 0 {
                    result = 1.0
                }
                else {
                    result = 1.0 - Double(value.location.y / outerHeight)
                }
                withAnimation{
                    self.sliderHeight = value.location.y
                }
            }
    }
    
    var body: some View {
            ZStack {
                    VStack(){
                        ZStack(alignment: .top){
                            LinearGradient(gradient: Gradient(colors: fillColor), startPoint: .bottom, endPoint: .top).frame(width: outerWidth, height: outerHeight)
                            LinearGradient(gradient: Gradient(colors: unfillColor), startPoint: .bottom, endPoint: .top).frame(maxWidth: outerWidth, maxHeight: sliderHeight)
                        }
                    }
                    .frame(width: outerWidth, height: outerHeight)
                    .cornerRadius(50)
                    .gesture(
                        simpleDrag
                    )
            }
        }
}
