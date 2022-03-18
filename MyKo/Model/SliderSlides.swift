//
//  SliderSlides.swift
//  MyKo
//
//  Created by Илья Мунгалов on 18.03.2022.
//

import Foundation

class SliderSlides{
    
    func getSlides() -> [Slides] {
        var slides: [Slides] = []
        
        let slide1 = Slides(id: 1, text: "text1")
        let slide2 = Slides(id: 2, text: "text2")
        let slide3 = Slides(id: 3, text: "text3")
        
        slides.append(slide1)
        slides.append(slide2)
        slides.append(slide3)
        
        return slides
    }
}
