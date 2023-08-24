//
//  SearchResult.swift
//  AppStoreSearch
//
//  Created by Mason Kim on 2023/08/24.
//

import Foundation

struct SearchResult: Decodable {
  /// 앱 이름
  let trackName: String
  /// 앱 상세 설명
  let description: String
  /// 앱 스크린샷 URL들
  let screenshotUrls: [URL]
  /// 주의사항
  let advisories: [String]
  /// 지원되는 기기들
  let supportedDevices: [String]

  /// 릴리즈 노트
  let releaseNotes: String
  /// 개발자 이름
  let artistName: String
  /// 앱 장르들
  let genres: [String]
  /// 가격
  let price: Double

  /// 사용 연령
  let contentAdvisoryRating: String
  /// 평가 평균 별점
  let averageUserRating: Double
  /// 평가 갯수
  let userRatingCount: Int

  /// 60x60 로고 URL
  let artworkUrl60: URL
  /// 100x100 로고 URL
  let artworkUrl100: URL
  /// 512x512 로고 URL
  let artworkUrl512: URL
}