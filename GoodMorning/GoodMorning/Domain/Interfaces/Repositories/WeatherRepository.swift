//
//  WeatherRepository.swift
//  GoodMorning
//
//  Created by Miro on 10/3/23.
//
protocol WeatherRepository {

    func fetchCurrentWeather(
        in coordinate: Coordinate
    ) async throws -> Result<CurrentWeather, NetworkError>

}
