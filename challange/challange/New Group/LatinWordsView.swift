//
//  ContentView.swift
//  challange
//
//  Created by Inti Albuquerque on 20/06/22.
//

import SwiftUI
import Lottie

struct LatinWordsView: View {
    @StateObject var viewModel = LatinWordsViewModel()
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance

        appearance.backgroundColor = ColorNames.listBackground.uiColor()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            loadingView
                .frame(maxWidth: .infinity, maxHeight: max(viewModel.offset, 0))
            
            if viewModel.listOfWords.isEmpty {
                Spacer()
                ImageNames.logo.image()
                Spacer()
            } else {
                NavigationView {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.listOfWords) { element in
                                NavigationLink(destination: { LatinWordsDetailView(title: element.title, content: element.content) }) {
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Text(element.title)
                                                .foregroundColor(ColorNames.loadingBackground.color())
                                            Spacer()
                                            Text(element.subtitle)
                                                .foregroundColor(ColorNames.subtitle.color())
                                                .padding(.trailing, 15)
                                            
                                            Image(systemName: "chevron.right")
                                                .renderingMode(.template)
                                                .foregroundColor(ColorNames.loadingBackground.color())
                                        }
                                        .padding(.horizontal, 15)
                                        Spacer()
                                        Rectangle()
                                            .fill(ColorNames.line.color())
                                            .frame(height: 0.5)
                                    }
                                    .frame(height: 75)
                                }
                            }
                        }
                    }
                    .background(ColorNames.listBackground.color())
                }
                .accentColor(ColorNames.back.color())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorNames.background.color())
        .highPriorityGesture(
            DragGesture(minimumDistance: 50, coordinateSpace: .global).onChanged({ value in
                if value.translation.height < 120 {
                    self.viewModel.setOffset(value.translation.height)
                }
            })
            .onEnded({ _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    Task {
                        await viewModel.fetchData()
                    }
                }
            })
        )
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.error?.title ?? "").bold(), message: Text(viewModel.error?.message ?? ""))
        }
    }
    
    @ViewBuilder
    var loadingView: some View {
        LottieView(name: "loading", loopMode: .loop)
            .background(viewModel.offset.isZero ? (viewModel.listOfWords.isEmpty ? ColorNames.background.color() : ColorNames.listBackground.color()) : ColorNames.loadingBackground.color())
    }
    
    //I did this before I realised I could take the logo from figma
    //left here so you can see my thinking
    @ViewBuilder
    var logo: some View {
        HStack(alignment: .top, spacing: 4.8) {
            VStack(alignment: .leading, spacing: 0) {
                Circle()
                    .fill(.white)
                    .frame(width: 19.2, height: 19.2)
                    .padding(.leading, 5)
                
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(.white, style: StrokeStyle(lineWidth: 12, lineCap: .square))
                    .frame(width: 62.4, height: 33.6)
                
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Circle()
                    .trim(from: 0.5, to: 1)
                    .stroke(.white, style: StrokeStyle(lineWidth: 12, lineCap: .square))
                    .frame(width: 62.4, height: 33.6)
                
                Rectangle()
                    .fill(.white)
                    .frame(width: 28.8, height: 12)
                    .padding(.leading, 8)
            }
        }
        
    }
}

struct LatinWordsView_Previews: PreviewProvider {
    static var previews: some View {
        LatinWordsView()
    }
}
