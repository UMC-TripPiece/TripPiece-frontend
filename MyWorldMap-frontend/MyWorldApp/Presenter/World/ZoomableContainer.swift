//
//  ZoomableContainer.swift
//  MergeWithSwiftUI
//
//  Created by 김서현 on 8/12/24.
//

import SwiftUI
import InteractiveMap


fileprivate let maxAllowedScale = 5.0

struct ZoomableContainer<Content: View>: View {
    
    //어떤 나라를 줌인 할 것인지 가져오기
    @Binding var selectedCountry: PathData
    
    let content: Content

    @State private var currentScale: CGFloat = 1.0
    @State private var tapLocation: CGPoint = .zero
    @State private var scrollView: UIScrollView?
    
    
    
    init(selectedCountry: Binding<PathData>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._selectedCountry = selectedCountry
    }



    
    var body: some View {
        ZoomableScrollView(scale: $currentScale, tapLocation: $tapLocation, selectedCountry: $selectedCountry) {
            content
        }
     }
    

    /*func zoomToCountry(_ newPathData: PathData) {
            if let scrollView = scrollView {
                let zoomableScrollViewInstance = ZoomableScrollView(scale: $currentScale, tapLocation: $tapLocation, pathData: $pathData, scrollView: $scrollView) {
                        content
                    }
                zoomableScrollViewInstance.zoomToCountry(newPathData, in: scrollView, context: context)
            }
        } */
        
    }


    fileprivate struct ZoomableScrollView<Content: View>: UIViewRepresentable {
        var content: Content
        @Binding private var currentScale: CGFloat
        @Binding var tapLocation: CGPoint
        @Binding var selectedCountry: PathData
        
        let imageSize = CGSize(width: 1008.27001953125, height: 650.9400024414062)

        init(scale: Binding<CGFloat>, tapLocation: Binding<CGPoint>, selectedCountry: Binding<PathData>, @ViewBuilder content: () -> Content) {
            _currentScale = scale
            _tapLocation = tapLocation
            _selectedCountry = selectedCountry
            self.content = content()
        }
        
        
        
        func makeUIView(context: Context) -> UIScrollView {
            // Setup the UIScrollView
            let scrollView = UIScrollView()
            
            
            scrollView.delegate = context.coordinator // for viewForZooming(in:)
            scrollView.maximumZoomScale = maxAllowedScale
            scrollView.minimumZoomScale = 0.05
            scrollView.bouncesZoom = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.clipsToBounds = false

            // Create a UIHostingController to hold our SwiftUI content
            // hostedView는 SwiftUI 뷰가 변환된, UIView 객체
            let hostedView = context.coordinator.hostingController.view!
            hostedView.translatesAutoresizingMaskIntoConstraints = true
            hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // 정확한 프레임 설정
            hostedView.frame = CGRect(x: 0, y: 0, width: 1008.27001953125, height: 650.9400024414062)
            scrollView.addSubview(hostedView)


            // 레이아웃 업데이트 후 contentSize 재설정
            DispatchQueue.main.async {
                scrollView.contentSize = hostedView.frame.size
                let zoomPoint = self.initialZoomPoint(for: scrollView)
                scrollView.zoom(to: zoomRect(for: scrollView, scale: 1.0, center: zoomPoint), animated: true)
            }
            
            return scrollView
        }
        
        
        // 주어진 pathData의 좌표(svgImage상의 좌표)를 iPhone 화면상의 좌표로 변환하는 함수
        func convertImageCoordinates(toViewSize viewSize: CGSize, fromImageSize imageSize: CGSize, imagePoint: CGPoint) -> CGPoint {
            // 이미지와 화면 사이의 비율 계산
            let calibrationHeight = viewSize.width / 1.54894461 // 바뀌는 규격에 맞춰 비율 보정
            let scaleX = viewSize.width / imageSize.width
            let scaleY = calibrationHeight / imageSize.height
            
            // 이미지 좌표를 화면 좌표로 변환
            let viewPoint = CGPoint(
                x: imagePoint.x * scaleX,
                y: imagePoint.y * scaleY
            )
            return viewPoint
        }
        
        
        // 적절한 스케일 계산 -> 너무 복잡함.. 일단 보류
       /* func calculateScaleToFit(boundingBox: CGRect) -> CGFloat {
            // boundingBox가 너무 작지 않게 하여 줌 레벨이 너무 크지 않도록 제한
            let widthScale = 393 / boundingBox.width
            let heightScale = 730 / boundingBox.height
            
            // widthScale과 heightScale 중 더 작은 값을 선택하여 줌 스케일을 설정
            let scale = min(widthScale, heightScale)
            
            // 줌 인 정도를 줄이기 위해 스케일에 여유를 둠 (예: 60% 줌인)
            let adjustedScale = scale * 0.9
                
            return scale
        } */
        
        
        

        // 처음 정해진 위치로 보내주는 함수..인데 재활용?
        func initialZoomPoint(for scrollView: UIScrollView) -> CGPoint {
            
            // 초기 줌 영역 계산
            /*if let currentCountry = selectedCountry.boundingBox {
                let centerPoint = CGPoint(x: currentCountry.midX, y: currentCountry.midY)
                return centerPoint
            } else{
                //한국의 CGRect
                let koreanRect = CGRect(x: 828.8699951171875, y: 346.5299987792969, width: 9.3900146484375, height: 14.670013427734375)
                let koreanPoint = CGPoint(x: koreanRect.midX, y: koreanRect.midY)
                let convertedKR = convertImageCoordinates(toViewSize: scrollView.contentSize, fromImageSize: imageSize, imagePoint: koreanPoint)
                
                return convertedKR
                
            }*/
            //한국의 CGRect
            let koreanRect = CGRect(x: 828.8699951171875, y: 346.5299987792969, width: 9.3900146484375, height: 14.670013427734375)
            let koreanPoint = CGPoint(x: koreanRect.midX, y: koreanRect.midY)
            let convertedKR = convertImageCoordinates(toViewSize: scrollView.contentSize, fromImageSize: imageSize, imagePoint: koreanPoint)
            
            return convertedKR
            
        
        }
        
        
        
        

        func makeCoordinator() -> Coordinator {
            return Coordinator(hostingController: UIHostingController(rootView: content), scale: $currentScale)
        }

        
        
        func updateUIView(_ uiView: UIScrollView, context: Context) {
            // Update the hosting controller's SwiftUI content
            context.coordinator.hostingController.rootView = content

            if uiView.zoomScale > uiView.minimumZoomScale { // Scale out
                uiView.setZoomScale(currentScale, animated: true)
            } else if tapLocation != .zero { // Scale in to a specific point
                // Reset the location to prevent scaling to it in case of a negative scale (manual pinch)
                // Use the main thread to prevent unexpected behavior
                DispatchQueue.main.async { tapLocation = .zero }
            }
            
            
            zoomToCountry(selectedCountry, in: uiView, context: context)
            
            

            assert(context.coordinator.hostingController.view.superview == uiView)
        }
        
        
        // 새로운 나라에 줌인 할 수 있게!
        func zoomToCountry(_ newPathData: PathData, in scrollView: UIScrollView, context: Context) {
            
            
            guard let boundingBox = newPathData.boundingBox else { return }

            let centerPoint = CGPoint(x: boundingBox.midX, y: boundingBox.midY)
            let convertedPoint = convertImageCoordinates(toViewSize: scrollView.contentSize, fromImageSize: imageSize, imagePoint: centerPoint)
            
            var appropriateScale = 1.0

            /*if boundingBox.width*boundingBox.height > 5000 { // 중국이나 미국 넣어보면서 확인해볼 것
                appropriateScale = 1.0
            }*/
            let zoomRect = self.zoomRect(for: scrollView, scale: appropriateScale, center: convertedPoint)
            
            // Coordinator를 사용하여 추가적인 작업 수행 가능
            // 예를 들어, 줌 인 후 특정 작업을 수행하거나 상태를 업데이트할 수 있음
            //context.coordinator.hostingController.rootView = content // 이거 왜하는건지 모르겠음...

            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.8, // 애니메이션 지속 시간 (초)
                                       delay: 0.0,         // 지연 시간
                                       options: [.curveEaseInOut], // 애니메이션 옵션
                                       animations: {
                                           scrollView.zoom(to: zoomRect, animated: false)
                                       }, completion: nil)
            }
        }
        
        
        
        
        
        

        // MARK: - Utils

        func zoomRect(for scrollView: UIScrollView, scale: CGFloat, center: CGPoint) -> CGRect {
            let scrollViewSize = scrollView.bounds.size

            let width = scrollViewSize.width / scale
            let height = scrollViewSize.height / scale
            let x = center.x - (width / 2.0)
            let y = center.y - (height / 2.0)

            return CGRect(x: x, y: y, width: width, height: height)
        }
        
        

        // MARK: - Coordinator

        class Coordinator: NSObject, UIScrollViewDelegate {
            var hostingController: UIHostingController<Content>
            @Binding var currentScale: CGFloat
            init(hostingController: UIHostingController<Content>, scale: Binding<CGFloat>) {
                self.hostingController = hostingController
                _currentScale = scale
            }

            func viewForZooming(in scrollView: UIScrollView) -> UIView? {
                return hostingController.view
            }

            func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
                currentScale = scale
            }
        }
}

