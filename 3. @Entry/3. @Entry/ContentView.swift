//
//  ContentView.swift
//  3. @Entry
//
//  Created by 이윤수 on 10/1/26.
//

import SwiftUI

/// 3. @Entry
/// 커스텀 값을 정의할 때 쓰던 보일러플레이트 코드를 없애기 위해 사용
/// iOS 18 +
///
/// iOS 17까지는 Environment를 만들 때 EnvironmentKey 프로토콜을 구현하고, EnvironmentValues에 extension 해서 값을 붙여야 했음
/// - 값을 하나 추가 하기 위해서 동일한 보일러플레이트 코드가 생성됨
///
/// @Entry를 사용하면 매크로가 내부적으로 EnvironmentKey 구조체를 생성하고 get/set 구현을 처리함
///
///  + Environment는 왜 사용할까?
///  - View 트리 상위에서 하위로 데이터를 쉽게 전달하기 위해 사용
///  - init을 통해 전달하지 않고, Environment로 주입해서 바로 사용
///  -> \.dismiss, \.font도 애플이 만든 Environment
///  -> 보통 모든 자식이 알아야 하는 설정 값 등을 정의함
///  -> 자식은 Environment를 통해 받는 값은 read Only
///

// 기존
struct MyData: EnvironmentKey {
    static var defaultValue: Bool = true
}

extension EnvironmentValues {
    var myFlag: Bool {
        get {
            self[MyData.self]
        }
        set {
            self[MyData.self] = newValue
        }
    }
    
    @Entry var myFlag2: Bool = MyData.defaultValue
}

struct ContentView: View {
    var body: some View {
        SubView()
            .environment(\.myFlag ,MyData.defaultValue)
            .environment(\.myFlag2, MyData.defaultValue)
    }
}

struct SubView: View {
    @Environment(\.myFlag) var myFlag
    @Environment(\.myFlag2) var myFlag2
    
    var body: some View {
        VStack {
            Text("flag 1: \(myFlag ? "O" : "X")")
            Text("flag 2: \(myFlag2 ? "O" : "X")")
        }
    }
}

#Preview {
    ContentView()
}
