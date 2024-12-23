//
//  NewMapView.swift
//  MyWorldApp
//
//  Created by 김호성 on 2024.11.12.
//

import UIKit
import Macaw

class MacawWorldView: MacawView {
    
    public var map: Group
    weak var delegate: MapDelegate?
    
    override init(frame: CGRect) {
        map = Group()
        
        guard let svg = try? SVGParser.parse(resource: "world") else {
            fatalError("Failed to parse SVG resource")
        }

//        let svg = try! SVGParser.parse(resource: "BlankMapWorld")
        super.init(frame: svg.bounds!.toCG())
//        let rate = min(bounds.width/svg.bounds!.w, bounds.height/svg.bounds!.h)
        map = Group(contents: [svg], place: .identity)
//        map.place = .identity.scale(rate, rate).move(bounds.width - (svg.bounds!.w * rate), bounds.height - (svg.bounds!.h * rate))
        
        self.node = map
        
        for countryEnum in CountryEnum.allCases {
            map.nodeBy(tag: countryEnum.rawValue)?.onTouchPressed({ [weak self] touch in
                self?.delegate?.onClick(country: countryEnum)
                self?.changeCountryColor(countryEnum: countryEnum, color: .blue)
                
                /*if let shape = touch.node as? Shape {
                    shape.fill = Color.blue
                    let select: Shape = Shape(
                        form: shape.form,
                        stroke: shape.stroke,
                        place: shape.place,
                        clip: shape.clip
                    )
                    self?.map.contents.append(select)
                }*/
            })
        }
        setBackGroundColor(countryEnum: .southKorea, color: UIColor.blue)
    }
    
    @MainActor required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setBackGroundColor(countryEnum: CountryEnum, color: UIColor) {
        guard let shape = map.nodeBy(tag: countryEnum.rawValue) as? Shape else {
            return
        }
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
           
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        shape.fill = Color.rgba(r: Int(red*255), g: Int(green*255), b: Int(blue*255), a: alpha)
    }
    
    override func touchesBegan(_ touches: Set<MTouch>, with event: MEvent?) {
        removeSelectShape()
        super.touchesBegan(touches, with: event)
        if map.contents.count == 1 {
            // 바다 클릭했을 때
            delegate?.onClick(country: nil)
        }
    }
    
    func changeCountryColor(countryEnum: CountryEnum, color: UIColor) {
        guard let shape = map.nodeBy(tag: countryEnum.rawValue) as? Shape else {
            print("Country not found or invalid shape.")
            return
        }
        
        // UIColor to Macaw Color 변환
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Fill 색상 업데이트
        shape.fill = Color.rgba(r: Int(red * 255), g: Int(green * 255), b: Int(blue * 255), a: alpha)
    }

    
    func removeSelectShape() {
        map.contents.removeSubrange(1..<map.contents.count)
    }
    
    func getCountryBounds(country: CountryEnum) -> CGRect? {
        return map.nodeBy(tag: country.rawValue)?.bounds?.toCG()
    }
}

protocol MapDelegate: AnyObject {
    func onClick(country: CountryEnum?)
}
