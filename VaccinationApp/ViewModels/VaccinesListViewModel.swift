//
//  VaccinesListViewModel.swift
//  VaccinationApp
//
//  Created by Maryam on 7/3/25.
//

import Foundation

class VaccinesListViewModel {
    var vaccines: [Vaccine] = [
        Vaccine(
            id: UUID(),
            name: "Mässling",
            doses: [
                Dose(
                    title: "Dos 1",
                    addedBy: "Tillagd av dig",
                    date: .from(year: 2011, month: 9, day: 30),
                    clinic: "Doktor.se"
                ),
                Dose(
                    title: "Dos 2",
                    addedBy: "Tillagd av dig",
                    date: .from(year: 2012, month: 10, day: 15),
                    clinic: "Doktor.se"
                )
            ]
        ),
        Vaccine(
            id: UUID(),
            name: "Påssjuka",
            doses: [
                Dose(
                    title: "Dos 1",
                    addedBy: "Tillagd av dig",
                    date: .from(year: 2011, month: 9, day: 30),
                    clinic: "Doktor.se"
                )
            ]
        ),
        Vaccine(
            id: UUID(),
            name: "Röda hund",
            doses: [
                Dose(
                    title: "Dos 1",
                    addedBy: "Tillagd av dig",
                    date: .from(year: 2011, month: 9, day: 30),
                    clinic: "Doktor.se"
                )
            ]
        ),
        Vaccine(
            id: UUID(),
            name: "Difteri",
            doses: (1...6).map { idx in
                let taken = idx <= 3
                return Dose(
                    title: "Dos \(idx)",
                    addedBy: taken ? "Tillagd av dig" : "",
                    date: taken ? .from(year: 2025, month: idx, day: 1) : nil,
                    clinic: taken ? "Doktor.se" : nil
                )
            }
        ),
        Vaccine(
            id: UUID(),
            name: "Polio",
            doses: (1...5).map { idx in
                Dose(
                    title: "Dos \(idx)",
                    addedBy: "Tillagd av dig",
                    date: .from(year: 2024, month: idx, day: 15),
                    clinic: idx == 3 ? nil : "Doktor.se"
                )
            }
        ),
        Vaccine(
            id: UUID(),
            name: "Stelkramp",
            doses: (1...6).map { idx in
                let title = idx == 6 ? "Påfyllnadsdos" : "Dos \(idx)"
                let taken = idx <= 2
                return Dose(
                    title: title,
                    addedBy: taken ? "Tillagd av dig" : "",
                    date: taken ? .from(year: 2023, month: idx, day: 20) : nil,
                    clinic: taken ? "Doktor.se" : nil
                )
            }
        ),
        Vaccine(
            id: UUID(),
            name: "Kikhosta",
            doses: (1...6).map { idx in
                let title = idx == 6 ? "Påfyllnadsdos" : "Dos \(idx)"
                let taken = idx <= 1
                return Dose(
                    title: title,
                    addedBy: taken ? "Tillagd av dig" : "",
                    date: taken ? .from(year: 2023, month: idx, day: 20) : nil,
                    clinic: nil
                )
            }
        )
    ]
    
    var count: Int { vaccines.count }
    func vaccine(at index: Int) -> Vaccine { vaccines[index] }
}
