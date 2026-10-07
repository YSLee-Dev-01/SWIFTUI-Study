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
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
