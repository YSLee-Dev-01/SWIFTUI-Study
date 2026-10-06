//
//  ContentView.swift
//  4. @Observable
//
//  Created by 이윤수 on 10/5/26.
//

import SwiftUI
import Combine

/// 4. @Observable
///
/// 기존 ObservableObject는 아래와 같은 문제가 있었음
/// - 추적을 원하는 프로퍼티 마다 @Published 키워드를 붙여야 함
/// - 옵셔널, 컬렉션 안의 객체가 추적되지 않음
/// - View에서 직접 사용하고 있지 않은 값이 업데이트 되도 View가 다시 랜더링 됨
///
/// ObservableObject의 문제점을 개선한 매크로가 @Observable
/// - iOS 17 +
/// - class에서만 사용할 수 있고, 속성이 변경되면 View를 다시 랜더링 함
///
/// @Observable는
/// - 실제로 사용 중인 값만 부분적으로 재랜더링
/// - 옵셔널, 컬렉션 안의 객체도 추적 가능
/// - @Published 키워드를 붙이지 않아도 모든 객체를 추적
/// -> 추적을 원치 않는 경우 @ObservationIgnored를 붙임
///
/// 기존 ObservableObject은 내부에서 생성 시 @StateObject,
/// 외부에서 주입 시 @ObservedObject로 받아서 사용함
///
/// @Observable은 내부에서 생성 시 @State로 생성하고,
/// 외부에서 주입 시 Binding이 필요 없을 경우 객체만 주입 받음
/// - @Observable 처리 된 객체는 알아서 값을 트래킹하고 뷰를 업데이트 함
///
/// @State, @StateObject
/// - iOS 17 이전에는 @State는 값 타입만 사용이 가능 (@StateObject를 통해 참조 타입 사용)
/// - iOS 17 이후로는 @Observable이 붙은 참조 타입도 사용이 가능해짐
/// -> @Observable가 붙은 참조 타입은 Observable 프레임워크가 변경 감지를 지원함
/// -> @State 래퍼가 매커니즘을 인식해서 참조타입이여도 사용이 가능해진 것
///
/// @Observable를 하위 뷰에 전달할 때 Binding이 필요한 경우
/// - @Observable 객체만 주입 받은 경우 Binding을 사용할 수 없음
/// - @Observable 인스턴스를 넘기는 게 아닌 속성을 넘겨야 하기 때문
/// -> @Observable에서는 @Bindable을 사용함
///
/// @Bindable
/// -  @Observable, Environment의 객체의 각 속성에 Binding 처리를 해주는 프로퍼티 래퍼
/// -> 외부에서 @Observable 값을 받아 사용할 때 Binding이 필요할 때 사용함
/// + 참조타입으로 만들어진 객체가 Binding으로 변화한 것을 View에 알릴 때도 사용
/// -> View에 그려진 타입이 컬렉션 타입 + 참조 타입일 때
///
/// + UIKit
///  - UIKit에서도 @Observable를 사용할 경우 반응형 프로그래밍으로 개발할 수 있음
///  - @Observable를 ViewModel에 선언하면 UIKit 내부에서 프로퍼티 값이 변경될 때마다 View를 무효화 하고 다시 그림
///  -> setNeedLayout()을 수동으로 호출하지 않아도 됨
///
///  기존 layoutSubViews()는 데이터 업데이트와 레이아웃 처리를 동시에 진행
/// - layoutSubViews()는 뷰의 위치, 크기를 계산하고 배치할 때 호출됨
///  -> 속성 하나가 변경되도 레이아웃 자체를 다시 그림
///  -> layoutSubViews() 자체는 직접 호출이 아닌 setNeedsLayout(), layoutIfNeeded()로 트리거
///
///  updateProperties()
///  - 데이터(속성) 업데이트만 처리하는 메서드
///  -> 레이아웃을 처리하지 않기 때문에 레이아웃을 재계산하는 불필요한 과정이 제거됨
///  -> layoutSubviews() 직전에 호출
///  - setNeedsUpdateProperties()를 호출하여 직접 호출 가능
///  - iOS 26 +
///
///  viewWillLayoutSubviews()
///  - layoutSubviews() 직전에 호출되는 메서드
///  -> 레이아웃 준비 전에 호출됨
///
///  @Observable 사용 시
///  - updateProperties, viewWillLayoutSubviews에 업데이트 되는 값을 지정함

// 기존
class ClassicViewModel: ObservableObject {
    @Published var title: String = "Classic"
}

@Observable
class NewViewModel {
    var title: String = "New"
}

struct ContentView: View {
    @State var newViewModel = NewViewModel()
    @StateObject var classicViewModel = ClassicViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(self.newViewModel.title)")
            Text("\(self.classicViewModel.title)")
            
            HStack {
                Button {
                    self.newViewModel.title = "New 타이틀 변경됨!"
                } label: {
                    Text("New 타이틀 변경하기")
                }
                
                Button {
                    self.classicViewModel.title = "Classic 타이틀 변경됨!"
                } label: {
                    Text("Classic 타이틀 변경하기")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
