// PDF Receipt Window Generator

export function openReceiptPdfWindow(data: any): void {
  if (typeof window === 'undefined') return;
  const printWin = window.open('', '_blank', 'width=800,height=900');
  if (!printWin) return;

  printWin.document.write(`
    <!DOCTYPE html>
    <html dir="rtl" lang="ar">
    <head>
      <meta charset="utf-8">
      <title>وصل تسديد رسمي</title>
      <style>
        body { font-family: sans-serif; padding: 40px; }
        .header { text-align: center; border-bottom: 2px solid #333; padding-bottom: 15px; margin-bottom: 20px; }
        .details { margin: 20px 0; font-size: 16px; line-height: 2; }
        .footer { text-align: center; margin-top: 40px; font-size: 12px; color: #666; }
      </style>
    </head>
    <body>
      <div class="header">
        <h1>وصل قبض رسمي</h1>
      </div>
      <div class="details">
        <p><strong>اسم الزبون:</strong> ${data.customerName || '-'}</p>
        <p><strong>المبلغ الواصل:</strong> ${data.amountPaid ? Number(data.amountPaid).toLocaleString() : 0} دينار</p>
        <p><strong>المبلغ المتبقي:</strong> ${data.remainingBalance ? Number(data.remainingBalance).toLocaleString() : 0} دينار</p>
        <p><strong>تاريخ التسديد:</strong> ${data.date || new Date().toLocaleDateString('ar-IQ')}</p>
        <p><strong>اسم المندوب:</strong> ${data.repName || '-'}</p>
      </div>
      <div class="footer">
        <p>تم استخراج الوصل إلكترونياً - نظام إدارة الأقساط والمبيعات</p>
      </div>
      <script>window.print();</script>
    </body>
    </html>
  `);
  printWin.document.close();
}
