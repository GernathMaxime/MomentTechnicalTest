//
//  ModalView.swift
//  MomentTechnicalTestMaximeGernath
//
//  Created by Maxime Gernath on 17/03/2020.
//  Copyright © 2020 MaximeCorp. All rights reserved.
//

import SwiftUI

struct MovieDetail : View {
    var movie: NewsListItem
    
    var body: some View {
        VStack() {
            ZStack(alignment: .bottom) {
                UrlPosterView(urlString: movie.backdrop_path)
                Rectangle()
                    .frame(height: 80)
                    .opacity(0.25)
                    .blur(radius: 10)
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .bold()
                            .font(.largeTitle).foregroundColor(Color.white)
                    }
                    .padding(.leading)
                    .padding(.bottom)
                    Spacer()
                }
            }
            VStack(alignment: .center,spacing: 15) {
                Text(movie.overview!)
                    .font(.body).foregroundColor(Color.white)
            }.padding(.all)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,maxHeight: .infinity, alignment: .topLeading)
            ProgressBar(progress: movie.vote_average)
            .frame(width: 150.0, height: 150.0)
            .padding(40.0)
        }
        .background(Color(red: 20/255, green: 29/255, blue: 38/255))
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
    }
}



//struct MovieDetail_Preview: PreviewProvider {
//
//}

struct ProgressBar: View {
    var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(progress/10))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)

            Text(String(format: "%.0f /10%", progress))
                .font(.largeTitle)
                .bold()
        }
    }
}
