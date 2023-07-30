////
////  IntroView.swift
////  Artify
////
////  Created by Marieke Schmitz on 19.06.23.
////
//
//import SwiftUI
//
//struct IntroView: View {
//
//    @State var introTimePassed = false
//
//    var body: some View {
//        ZStack{
//            Color.darkGrayBG.ignoresSafeArea()
//            VStack {
//                HStack (spacing:0) {
//                    VStack(spacing:0) {
//                        Text("let").frame(maxWidth: .infinity, alignment: .trailing).frame(height:50)
//                        Text("music").frame(maxWidth: .infinity, alignment: .trailing).frame(height:50)
//                        Text("create").frame(maxWidth: .infinity, alignment: .trailing).frame(height:50)
//                        Text("art").frame(maxWidth: .infinity, alignment: .trailing).frame(height:50)
//                    }
//                    .foregroundColor(Color.white)
//                    .font(Font.custom("DMSerifDisplay-Regular", size: 45)).foregroundColor(.white)
//
//                    Image("artify")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding()
//                        .scaledToFit()
//                        .frame(width: 100, height: 170)
//
//                }
//                .padding(.bottom, introTimePassed ? 300 : 0).task(delayIntro)
//
//                if (introTimePassed) {
//                    Button("Login to Spotify") {
//                        print("hi")
//                    }
//                    .buttonStyle(RoundedButton())
//                }
//
//            }
//
//        }
//    }
//
//    private func delayIntro() async {
//        try? await Task.sleep(nanoseconds: 2_000_000_000)
//        withAnimation {
//            introTimePassed = true
//        }
//    }
//}
//
//
//struct RoundedButton: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding()
//            .foregroundStyle(.white)
//            .overlay(
//                RoundedRectangle(cornerRadius: 100)
//                            .stroke(Color.white, lineWidth: 1)
//                            .frame(width: 180, height: 45)
//                    )
//            .font(Font.custom("Poppins-Regular", size: 15))
//
//    }
//}
//
//struct IntroView_Previews: PreviewProvider {
//    static var previews: some View {
//        IntroView()
//    }
//}
