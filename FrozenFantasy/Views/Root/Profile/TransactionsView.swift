//
//  TransactionsView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 27.04.2024.
//

import SwiftUI

struct TransactionsView: View {
    var transactions: Transactions
    
    private var groupedTransactions: [(Date, Transactions)] {
        transactions.groupedByDate.sorted { $0.key > $1.key }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("История операций")
                .font(.customTitle1)
                .foregroundStyle(.customBlack)
            
            ForEach(groupedTransactions, id: \.0) { date, sameDayTransactions in
                VStack(alignment: .leading, spacing: 8) {
                    Text(date.simpleDateString)
                        .font(.customTitle3)
                        .foregroundStyle(.customBlack)
                    
                    VStack(spacing: 12) {
                        ForEach(sameDayTransactions) { transaction in
                            HStack(spacing: 8) {
                                Text(transaction.details)
                                    .font(.customBody1)
                                    .lineLimit(2)
                                
                                Spacer()
                                HStack(spacing: 4) {
                                    Text("\(transaction.amount)")
                                        .font(.customBody1)
                                        .bold()
                                        .foregroundStyle(transaction.amount > 0 ? .customGreen : .customRed)
                                    Image("icon:coins")
                                        .renderingMode(.template)
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.customYellow)
                                }
                                .fixedSize()
                            }
                            .padding(12)
                            .background(.white)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 12)
                            )
                            .shadow(color: .black.opacity(0.1), radius: 8, x: 2, y: 2)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TransactionsView(transactions: Transactions.dummy)
        .padding()
}
