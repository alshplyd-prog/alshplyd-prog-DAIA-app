// Customer Statement PDF Export

export function openCustomerStatementPdfWindow(data: any): void {
  if (typeof window === 'undefined') return;
  const printWin = window.open('', '_blank', 'width=800,height=900');
  if (!printWin) return;

  printWin.document.write(`
    <!DOCTYPE html>
    <html dir="rtl" lang="ar">
    <head>
      <meta charset="utf-8">
      <title>كشف حساب زبون</title>
      <style>
        body { font-family: sans-serif; padding: 30px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: right; }
        th { background: #f5f5f5; }
      </style>
    </head>
    <body>
      <h2>كشف حساب زبون: ${data.customerName || '-'}</h2>
      <p>تاريخ الكشف: ${new Date().toLocaleDateString('ar-IQ')}</p>
      <table>
        <thead>
          <tr>
            <th>#</th>
            <th>المبلغ</th>
            <th>التاريخ</th>
            <th>المندوب</th>
            <th>ملاحظات</th>
          </tr>
        </thead>
        <tbody>
          ${(data.payments || []).map((p: any, index: number) => `
            <tr>
              <td>${index + 1}</td>
              <td>${(p.amountPaid || p.amount || 0).toLocaleString()} د.ع</td>
              <td>${p.paymentDate || p.date || '-'}</td>
              <td>${p.repName || '-'}</td>
              <td>${p.note || '-'}</td>
            </tr>
          `).join('')}
        </tbody>
      </table>
      <script>window.print();</script>
    </body>
    </html>
  `);
  printWin.document.close();
}
