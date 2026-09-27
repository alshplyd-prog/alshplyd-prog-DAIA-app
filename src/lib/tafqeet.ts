// Arabic Number to Words Converter (Tafqeet)

export function numberToArabicWords(number: number): string {
  if (isNaN(number) || number === 0) return 'صفر دينار';

  const units = ['', 'واحد', 'إثنان', 'ثلاثة', 'أربعة', 'خمسة', 'ستة', 'سبعة', 'ثمانية', 'تسعة', 'عشرة'];
  const tens = ['', 'عشرة', 'عشرون', 'ثلاثون', 'أربعون', 'خمسون', 'ستون', 'سبعون', 'ثمانون', 'تسعون'];
  const hundreds = ['', 'مائة', 'مائتان', 'ثلاثمائة', 'أربعمائة', 'خمسمائة', 'ستمائة', 'سبعمائة', 'ثمانمائة', 'تسعمائة'];

  if (number < 0) return `سالب ${numberToArabicWords(Math.abs(number))}`;

  let num = Math.floor(number);
  let result = '';

  if (num >= 1000000) {
    const millions = Math.floor(num / 1000000);
    num %= 1000000;
    if (millions === 1) result += 'مليون ';
    else if (millions === 2) result += 'مليونان ';
    else result += `${numberToArabicWords(millions)} مليون `;
  }

  if (num >= 1000) {
    const thousands = Math.floor(num / 1000);
    num %= 1000;
    if (thousands === 1) result += 'ألف ';
    else if (thousands === 2) result += 'ألفان ';
    else if (thousands >= 3 && thousands <= 10) result += `${units[thousands]} آلاف `;
    else result += `${numberToArabicWords(thousands)} ألف `;
  }

  if (num >= 100) {
    const h = Math.floor(num / 100);
    num %= 100;
    result += `${hundreds[h]} `;
  }

  if (num > 0) {
    if (result.trim().length > 0) result += 'و';
    if (num <= 10) {
      result += `${units[num]} `;
    } else if (num < 20) {
      const u = num % 10;
      if (u === 1) result += 'أحد عشر ';
      else if (u === 2) result += 'إثنا عشر ';
      else result += `${units[u]} عشر `;
    } else {
      const u = num % 10;
      const t = Math.floor(num / 10);
      if (u > 0) result += `${units[u]} و${tens[t]} `;
      else result += `${tens[t]} `;
    }
  }

  return `${result.trim()} دينار عراقي لا غير`;
}
