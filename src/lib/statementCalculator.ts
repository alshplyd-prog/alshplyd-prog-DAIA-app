// Customer Statement Calculator

export function calculateCustomerStatement(contract: any, payments: any[] = []) {
  const totalPaid = payments.reduce((sum, p) => sum + (Number(p.amountPaid || p.amount) || 0), 0);
  const totalPrice = Number(contract.totalPrice || contract.total_price) || 0;
  const remaining = Math.max(0, totalPrice - totalPaid);

  return {
    totalPrice,
    totalPaid,
    remaining,
    paymentsCount: payments.length,
  };
}
