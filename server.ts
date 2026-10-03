import express from 'express';
import cors from 'cors';
import { Pool } from 'pg';

const app = express();
app.use(cors());
app.use(express.json());

const pool = new Pool({
  connectionString: 'postgresql://app_user:YOUR_PASSWORD@72.62.158.128:5432/app_database'
});

app.get('/api/contracts', async (req, res) => {
  try {
    const r = await pool.query('SELECT * FROM sales ORDER BY created_at DESC');
    res.json(r.rows);
  } catch (e: any) { res.status(500).json({ error: e.message }); }
});

app.post('/api/contracts', async (req, res) => {
  try {
    const d = req.body;
    const q = `INSERT INTO sales (id, customer_name, customer_phone, item_name, total_price, advance_payment, remaining_balance, daily_installment, created_at) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, NOW()) RETURNING *;`;
    const v = [d.id || Date.now().toString(), d.customer_name, d.customer_phone, d.item_name, d.total_price, d.advance_payment || 0, d.remaining_balance, d.daily_installment];
    const r = await pool.query(q, v);
    res.json({ success: true, contract: r.rows[0] });
  } catch (e: any) { res.status(500).json({ error: e.message }); }
});
app.get('/api/reports/totals', async (req, res) => {
  try {
    const [salesRes, paymentsRes, fundsRes, employeesRes, repsRes, inventoryRes] = await Promise.all([
      pool.query(`SELECT 
        COUNT(*)::int AS total,
        COALESCE(SUM(total_price), 0)::float AS "totalSalesAmount",
        COALESCE(SUM(total_paid), 0)::float AS "totalPaidAmount",
        COALESCE(SUM(remaining_balance), 0)::float AS "totalRemainingBalance",
        COALESCE(SUM(advance_payment), 0)::float AS "totalAdvancePayment"
      FROM sales`).catch(e => { console.error("Sales Error:", e.message); return { rows: [{}] }; }),

      pool.query(`SELECT 
        COUNT(*)::int AS "totalCount",
        COALESCE(SUM(amount), 0)::float AS "totalAmount",
        COALESCE(SUM(CASE WHEN payment_date::text LIKE $1 || '%' THEN amount ELSE 0 END), 0)::float AS "todayAmount",
        COALESCE(SUM(CASE WHEN payment_date::text LIKE $2 THEN amount ELSE 0 END), 0)::float AS "monthAmount"
      FROM payments`, [new Date().toISOString().split('T')[0], new Date().toISOString().slice(0, 7) + '%']
      ).catch(e => { console.error("Payments Error:", e.message); return { rows: [{}] }; }),

      pool.query(`SELECT 
        COUNT(*)::int AS count,
        COALESCE(SUM(balance), 0)::float AS "totalBalance"
      FROM cash_funds`).catch(e => { console.error("Funds Error:", e.message); return { rows: [{}] }; }),

      pool.query(`SELECT 
        COUNT(*)::int AS total,
        COUNT(CASE WHEN salary >= 0 THEN 1 END)::int AS active
      FROM employees`).catch(e => { console.error("Employees Error:", e.message); return { rows: [{}] }; }),

      pool.query(`SELECT 
        COUNT(*)::int AS total,
        COUNT(CASE WHEN role IS NOT NULL THEN 1 END)::int AS active
      FROM reps`).catch(e => { console.error("Reps Error:", e.message); return { rows: [{}] }; }),

      pool.query(`SELECT 
        COUNT(*)::int AS "totalItems",
        COALESCE(SUM(quantity), 0)::int AS "totalQuantity",
        COALESCE(SUM(price * quantity), 0)::float AS "totalValue"
      FROM inventory_items`).catch(e => { console.error("Inventory Error:", e.message); return { rows: [{}] }; })
    ]);

    res.json({
      success: true,
      database: "postgresql",
      contracts: salesRes.rows[0] || {},
      payments: paymentsRes.rows[0] || {},
      funds: fundsRes.rows[0] || {},
      employees: employeesRes.rows[0] || {},
      reps: repsRes.rows[0] || {},
      inventory: inventoryRes.rows[0] || {}
    });
  } catch (err: any) {
    console.error("Reports API General Error:", err.message);
    res.status(500).json({ success: false, error: err.message });
  }
});
app.get("/api/reports/totals", async (req, res) => {
  try {
    const contractsList = (typeof fileDb !== "undefined" && fileDb.get) ? (fileDb.get("contracts") || fileDb.get("sales") || []) : [];
    let totalSalesAmount = 0, totalAdvancePayment = 0, totalPaidAmount = 0, totalRemainingBalance = 0, activeCount = 0, completedCount = 0;
    
    contractsList.forEach((c: any) => {
      totalSalesAmount += Number(c.total_price || c.price || 0);
      totalAdvancePayment += Number(c.advance_payment || 0);
      totalPaidAmount += Number(c.total_paid || 0);
      totalRemainingBalance += Number(c.remaining_balance || 0);
      if (c.status === "active") activeCount++;
      if (c.status === "completed") completedCount++;
    });

    const [fundsRes, inventoryRes, employeesRes, repsRes] = await Promise.all([
      pool.query("SELECT COUNT(*)::int AS count, COALESCE(SUM(balance), 0)::float AS totalBalance FROM cash_funds").catch(() => ({ rows: [{}] })),
      pool.query("SELECT COUNT(*)::int AS totalItems, COALESCE(SUM(quantity), 0)::int AS totalQuantity, COALESCE(SUM(price * quantity), 0)::float AS totalValue FROM inventory_items").catch(() => ({ rows: [{}] })),
      pool.query("SELECT COUNT(*)::int AS total FROM employees").catch(() => ({ rows: [{}] })),
      pool.query("SELECT COUNT(*)::int AS total FROM reps").catch(() => ({ rows: [{}] }))
    ]);

    res.json({
      success: true,
      contracts: {
        total: contractsList.length,
        active: activeCount,
        completed: completedCount,
        totalSalesAmount,
        totalAdvancePayment,
        totalPaidAmount,
        totalRemainingBalance
      },
      funds: fundsRes.rows[0] || {},
      inventory: inventoryRes.rows[0] || {},
      employees: employeesRes.rows[0] || {},
      reps: repsRes.rows[0] || {}
    });
  } catch (err: any) {
    res.status(500).json({ success: false, error: err.message });
  }
});
app.listen(3000, () => console.log('Server running on port 3000'));
