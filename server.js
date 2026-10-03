const { Pool } = require('pg');
const express = require('express');
const cors = require('cors');

const app = express();
app.use(express.json({ limit: '50mb' }));
app.use(cors());

const pool = new Pool({
    connectionString: 'postgresql://postgres:123456@localhost:5432/alkarrar_db'
});

// مسار اختبار الاتصال
app.get('/', (req, res) => {
    res.send('Al-Karrar Server is running successfully!');
});

// مسار استقبال ومزامنة البيانات من تطبيق React
app.post('/api/sync', async (req, res) => {
    const client = await pool.connect();
    try {
        await client.query('BEGIN');
        const { customers, sales, reps, inventory_items, cash_funds, payments } = req.body;

        // 1. مزامنة الزبائن
        if (customers && Array.isArray(customers)) {
            for (let c of customers) {
                await client.query(
                    `INSERT INTO customers (name, phone, address) VALUES ($1, $2, $3) 
                     ON CONFLICT DO NOTHING`,
                    [c.name, c.phone || '', c.address || '']
                );
            }
        }

        // 2. مزامنة المبيعات
        if (sales && Array.isArray(sales)) {
            for (let s of sales) {
                await client.query(
                    `INSERT INTO sales (customer_id, total_amount, sale_date) VALUES ($1, $2, $3) 
                     ON CONFLICT DO NOTHING`,
                    [s.customer_id, s.total_amount || 0, s.sale_date || new Date()]
                );
            }
        }

        // 3. مزامنة المندوبين
        if (reps && Array.isArray(reps)) {
            for (let r of reps) {
                await client.query(
                    `INSERT INTO reps (name, phone) VALUES ($1, $2) ON CONFLICT DO NOTHING`,
                    [r.name, r.phone || '']
                );
            }
        }

        // 4. مزامنة المواد والأصناف
        if (inventory_items && Array.isArray(inventory_items)) {
            for (let item of inventory_items) {
                await client.query(
                    `INSERT INTO inventory_items (item_name, price, quantity) VALUES ($1, $2, $3) 
                     ON CONFLICT DO NOTHING`,
                    [item.item_name || item.name, item.price || 0, item.quantity || 0]
                );
            }
        }

        // 5. مزامنة الصناديق النقدية
        if (cash_funds && Array.isArray(cash_funds)) {
            for (let f of cash_funds) {
                await client.query(
                    `INSERT INTO cash_funds (fund_name, balance) VALUES ($1, $2) ON CONFLICT DO NOTHING`,
                    [f.fund_name, f.balance || 0]
                );
            }
        }

        // 6. مزامنة المدفوعات
        if (payments && Array.isArray(payments)) {
            for (let p of payments) {
                await client.query(
                    `INSERT INTO payments (amount, payment_date) VALUES ($1, $2) ON CONFLICT DO NOTHING`,
                    [p.amount || 0, p.payment_date || new Date()]
                );
            }
        }

        await client.query('COMMIT');
        res.status(200).json({ success: true, message: 'Sync completed successfully for all tables' });
    } catch (err) {
        await client.query('ROLLBACK');
        console.error('Sync error:', err);
        res.status(500).json({ success: false, error: err.message });
    } finally {
        client.release();
    }
});

const PORT = 3000;
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on http://0.0.0.0:${PORT}`);
});
