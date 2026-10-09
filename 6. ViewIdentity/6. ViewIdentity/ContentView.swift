//
//  ContentView.swift
//  6. ViewIdentity
//
//  Created by 이윤수 on 10/9/26.
//

import SwiftUI

/// 6. View Identity
/// - SwiftUI는 Value 타입이고, 상태가 변경될 때마다 body가 재호출되어 새로운 struct이 만들어짐
/// - View Struct 자체는 계속해서 변경됨
/// - 새로 만들어진 struct이 기존 struct와 같은가, 다른가를 판별할 수 있어야 함
/// -> 판단 기준이 View Identity
///
/// UIKit은 Class이기 때문에 포인터를 할당받아 저장함
/// -> 포인터를 ID로 사용할 수 있음
///
/// SwiftUI는 Value 타입이기 때문에 포인터(메모리 주소)를 사용할 수 없음
/// -> Value 타입은 복사시마다 새로운 메모리를 할당하기 때문
///
/// Identity에 따라 아래가 결정됨
/// - @State, @StateObject의 유지 여부
/// - View의 애니메이션 여부
/// - 생명주기 (onApper, onDisapper, task)
///
/// Identity는 2가지 종류로 구분
/// 1. 명시적 Identity
/// - 개발자가 ID를 직접 정의하는 방식
/// -> ForEach의 id, .id() 등
///
/// 2. 구조적 Identity
/// - 뷰 계층 구조를 사용해 암시적 Identity를 생성하는 방식
/// - View 내부에서 if 문을 사용할 경우 상황에 따라 다른 View를 보여주는데, true 분기와 false 분기는 각각 서로 고유한 ID를 가지게 됨
/// -> 둘은 다른 ID로 인식하게 됨
/// -> 분기가 변경되면 기존 View는 제거되고, 새로운 View가 생성됨 (State 초기화, transition 발생)
///
/// ViewBuilder가 if 문을 처리 시
///
///  if true {
///             AView()
///   } else {
///             BView()
///   }
///  _ConditionalContent<AView, BView>과 같은 형태로 변경함
///
/// + 두 개의 View가 다른 뷰로 처리되서는 안될 때 (.opacity 변경 시와 같이)는
/// if문을 사용하지 않고, inert modifier를 사용하는 것을 권장
/// -> State 초기화가 일어나지 않고, 자연스러운 애니메이션 효과 가능
///
/// + ID()를 통해 Identity를 의도적으로 변경하여, View를 새롭게 만들 수 있음
/// -> 단, 매번 값이 변경될 경우 body 호출 시마다 View를 재생성하여 성능이 나빠지고, State가 날라감
///

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
