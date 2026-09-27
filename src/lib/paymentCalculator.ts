// Payment Receipt Balances Calculator

export interface ReceiptBalanceResult {
  totalPaid: number;
  remainingBalance: number;
  totalContractPrice: number;
}

export function getPaymentReceiptBalances(
  totalPaid: number,
  remainingBalance: number,
  amountPaidNow: number
): ReceiptBalanceResult {
  const newPaid = totalPaid;
  const newRemaining = Math.max(0, remainingBalance);
  return {
    totalPaid: newPaid,
    remainingBalance: newRemaining,
    totalContractPrice: newPaid + newRemaining,
  };
}
