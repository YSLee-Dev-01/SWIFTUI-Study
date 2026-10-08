//
//  ContentView.swift
//  5. ResultBuilder
//
//  Created by 이윤수 on 10/7/26.
//

import SwiftUI

/// 5. ResultBuilder
/// - 여러개의 표현식을 나열하면 컴파일러가 하나의 값으로 조합해주는 매크로와 같은 문법
/// - 함수/클로저/연산프로퍼티에서 사용 가능하며, if, for과 같은 swift 문법도 사용 가능
/// -> 자료 구조를 자연스럽고 선언적으로 생성할 수 있게 하는 DSL를 정의하는 타입
/// - Swift 5.4 +
///
/// DSL?
/// - 분야 특화 언어, 특정 분야에서 가독성 및 사용성을 향상시킨 언어
/// - HTML, SQL 등이 있으며 DSL의 반대로는 범용언어(GPL)가 있으며 Swift, C 등이 이에 해당
///
/// - 일종의 매크로와 같은 성격을 지니기 때문에 컴파일 시 코드가 자동으로 수정됨
/// - ResultBuilder를 사용하면  append()와 같은 메서드는 사용 불가
/// -> 빌더 블록의 내부는 실행문이 아닌 '컴포넌트'로 취급되기 때문에 append()는 Void를 반환하여 컴파일 에러가 발생
/// -> 새로운 배열을 생성해야 함
/// - return 키워드는 생략
///
/// - Swift의 ViewBuilder도 ResultBuilder 중 하나
///
/// ViewBuilder
/// - 여러가지 뷰를 결합하여 사용할 때 사용
/// - struct 타입이며, 클로저를 통해 여러 뷰를 전달받고 하나의 뷰로 만듦
/// -> 클로저에서 childView를 구상하거나, View를 나열할 때 사용
/// - VStack, List와 같은 컨테이너 뷰 내부 init에서 ViewBuilder를 사용 중
///
///  + some View는 하나의 타입의 뷰만 반환할 수 있음
///  - AnyView를 사용할 경우 여러 타입의 뷰를 반환할 수 있지만, 타입을 소거하기 때문에 권하지 않음
/// -> ViewBuilder를 사용하면 여러개의 뷰를 나열할 수 있음
///
/// + 기존 ViewBuilder는 child 매개변수가 10개까지만 구현되어 있었기 때문에, 10개의 자식만 가질 수 있었지만,
/// parameter pack(가변 제네릭) 업데이트로 제한 없이 사용이 가능함

// 사용하고 싶은 타입에 @resultBuilder로 선언
@resultBuilder
struct ListBuilder {
    // 하나의 블록에 여러 줄의 코드를 작성할 수 있게 함
    static func buildBlock(_ components: String...) -> String {
        return components.joined()
    }
    
    // if/else 구문을 쓰기 위해 필요함
    static func buildEither(first component: String) -> String {
        return component
    }
    
    static func buildEither(second component: String) -> String {
        return component
    }
}

struct ContentView: View {
    
    func textCreate(@ListBuilder textList: () -> String) -> String {
        textList()
    }
    
    func childView(@ViewBuilder _ childView: () -> some View) -> some View {
        childView()
    }
    
    @State var title: String = ""
    
    var body: some View {
        VStack {
            Text(self.title)
            
            Button {
                self.title = self.textCreate {
                    "안녕"
                    "하세요"
                    "!"
                    "\n"
                    "wow"
                    "\n"
                    
                    if true {
                        "이게 나와"
                    } else {
                        "아냐 이게 나와"
                    }
                }
            } label: {
                Text("타이틀 만들기")
            }
            
            self.childView {
                Text("이건 자식뷰를 viewBuilder로 만들었어")
                Stepper(value: .constant(1)) {
                    Text("Stepper")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
