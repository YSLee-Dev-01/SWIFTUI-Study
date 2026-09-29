//
//  ContentView.swift
//  2. ScrollPosition
//
//  Created by 이윤수 on 9/29/26.
//

import SwiftUI

/// 2. ScrollPosition
/// 스크롤 위치를 값 타입으로 사용하여 양방향 바인딩을 가능하게 함
/// - 스크롤 뷰를 더 쉽게 사용하기 위해 사용하는 타입
///
/// - iOS 18 +
///
/// iOS 17 이전에는 ScrollViewReader + scrollTo()를 사용했음
/// - 현재 스크롤 위치를 알 수 없고, 이동만 시킬 수 있었음
/// - 스크롤한 결과를 State로 반영할 수 없었음
/// -> ScrollPosition는 스크롤 위치를 저장하고 복원/이동 시킬 수 있음
///
///  .scrollPosition 모디파이어와 함께 사용
/// - ScrollPosition를 ScrollView와 연동시켜줌
///
/// ScrollPosition.scrollTo()를 통해 스크롤 할 수 있음
/// - ID, X/Y, edge 등 다양한 값으로 스크롤 위치를 변경할 수 있음
/// - anchor 값으로 포지션을 정할 수 있음
///
/// scrollTargetLayout
/// - 스크롤뷰 안에서 스크롤 대상의 레이아웃을 명확하게 하는 역할
/// -> 스크롤 단위로 정렬
/// -> SwiftUI가 scrollTo 동작을 더 잘할 수 있게 함

struct ContentView: View {
    
    @State private var scrollViewPosition = ScrollPosition(idType: Int.self)
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                self.scrollViewPosition.scrollTo(edge: .top)
            } label: {
                Text("가장 위로")
            }
            
            Button {
                self.scrollViewPosition.scrollTo(edge: .bottom)
            } label: {
                Text("가장 아래로")
            }
            
            Button {
                self.scrollViewPosition.scrollTo(y: 200)
            } label: {
                Text("Y 200으로")
            }
            
            Button {
                self.scrollViewPosition.scrollTo(id: 50)
            } label: {
                Text("ID 50으로")
            }

            ScrollView {
                LazyVStack {
                    ForEach((1 ..< 101)) { row in
                        HStack {
                            Text("\(row)")
                                .font(.title2)
                        }
                        .id(row)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition($scrollViewPosition)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
