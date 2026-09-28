//
//  ContentView.swift
//  1. ViewThatFits
//
//  Created by 이윤수 on 9/28/26.
//

import SwiftUI

/// 1. ViewThatFits
/// - 여러개의 뷰 중에서 사용 가능한 공간에 맞는 뷰를 보여주는 컨테이너 View
/// - 화면 사이즈에 맞게 뷰를 유연하게 그릴 때 사용
/// - iOS 16 +
///
/// 동작 방식
/// - 나열된 자식 뷰들을 순서대로 평가하면서 부모가 제공하는 공간에 넘치지 않고 들어가는 첫번째 뷰를 선택
/// - 모두 안맞으면 가장 마지막 뷰를 사용
/// -> 순서대로 평가하기 때문에 우선순위 🈶
///
/// - axis 파라미터로 정렬 축을 정할 수 있음
/// -> 기본 값은 둘 다
/// -> 가로, 세로모드에 따라 평가 기준이 달라질 수 있음
///

struct ContentView: View {
    
    @State private var bgColor: Color = .clear
    @State private var zoom: Double = 1.0
    
    var body: some View {
        VStack {
            ViewThatFits {
                Text("하하 나는 아주 큰 텍스트")
                    .font(.system(size: 50 * self.zoom))
                    .onAppear {
                        print("큰 텍스트 표출")
                        self.bgColor = .brown
                    }
                
                Text("하하 나는 중간 텍스트")
                    .font(.system(size: 35 * self.zoom))
                    .onAppear {
                        print("중간 텍스트 표출")
                        self.bgColor = .yellow
                    }
                
                Text("하하 나는 작은 텍스트")
                    .font(.system(size: 20 * self.zoom))
                    .onAppear {
                        print("작은 텍스트 표출")
                        self.bgColor = .green
                    }
            }
            .background(self.bgColor)
            
            Stepper(value: self.$zoom, step: 0.1) {
                Text("현재 \(self.zoom)%")
            }
        }
    }
}

#Preview {
    ContentView()
}
