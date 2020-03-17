//
//  UrlPosterView.swift
//  MomentTechnicalTestMaximeGernath
//
//  Created by Maxime Gernath on 17/03/2020.
//  Copyright © 2020 MaximeCorp. All rights reserved.
//

import SwiftUI

struct UrlPosterView: View {
    @ObservedObject var urlImageModel: UrlImageModel

    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }

    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlPosterView.defaultImage!)
            .resizable()
            .scaledToFit()
    }

    static var defaultImage = UIImage(named: "NewsIcon")
}

struct UrlPosterView_Previews: PreviewProvider {
    static var previews: some View {
        UrlPosterView(urlString: "/5BwqwxMEjeFtdknRV792Svo0K1v.jpg")
    }
}
