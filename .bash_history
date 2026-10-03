sudo apt update && sudo apt install postgresql postgresql-contrib -y
sudo -u postgres psql
echo "listen_addresses = '*'" >> /etc/postgresql/14/main/postgresql.conf
echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/14/main/pg_hba.conf
sudo systemctl restart postgresql
sudo -u postgres psql
pg_dump "postgresql://postgres.leeivxwftmwlsojslxnh:DyaaPass2026@aws-0-ap-south-1.pooler.supabase.com:6543/postgres" | PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database
PGPASSWORD='DyaaPass2026' pg_dump --no-version-check "postgresql://postgres.leeivxwftmwlsojslxnh:DyaaPass2026@aws-0-ap-south-1.pooler.supabase.com:6543/postgres" | PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database
PGPASSWORD='DyaaPass2026' pg_dump "postgresql://postgres.leeivxwftmwlsojslxnh:DyaaPass2026@aws-0-ap-south-1.pooler.supabase.com:6543/postgres" -F c -b -v -f backup.sql
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-client-17 -y
PGPASSWORD='DyaaPass2026' pg_dump "postgresql://postgres.leeivxwftmwlsojslxnh:DyaaPass2026@aws-0-ap-south-1.pooler.supabase.com:6543/postgres" | PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database
PGPASSWORD='DyaaPass2026' /usr/lib/postgresql/17/bin/pg_dump "postgresql://postgres.leeivxwftmwlsojslxnh:DyaaPass2026@aws-0-ap-south-1.pooler.supabase.com:6543/postgres" | PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database -c "SELECT * FROM customers;"
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database -c "SELECT name FROM customers;"
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database -c "SELECT COUNT(*) FROM customers;"
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database -c "SELECT COUNT(*) FROM payments;"
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database -c "SELECT COUNT(*) FROM agents;"
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database -c "\dt"
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database -c "SELECT COUNT(*) FROM reps;"
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database -c "
SELECT table_name, 
       (xpath('/row/cnt/text()', xml_count))[1]::text::int as row_count
FROM (
    SELECT table_name, 
           exec_query('SELECT count(*) as cnt FROM ' || quote_ident(table_name)) as xml_count
    FROM information_schema.tables 
    WHERE table_schema='public' AND table_type='BASE TABLE'
) t;
"
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database -c "
SELECT 'customers' as table_name, COUNT(*) FROM customers UNION ALL
SELECT 'payments', COUNT(*) FROM payments UNION ALL
SELECT 'reps', COUNT(*) FROM reps UNION ALL
SELECT 'sales', COUNT(*) FROM sales UNION ALL
SELECT 'employees', COUNT(*) FROM employees UNION ALL
SELECT 'inventory_items', COUNT(*) FROM inventory_items;
"
211111111111111111
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database -c "
SELECT 'customers' as table_name, COUNT(*) FROM customers UNION ALL
SELECT 'payments', COUNT(*) FROM payments UNION ALL
SELECT 'reps', COUNT(*) FROM reps UNION ALL
SELECT 'sales', COUNT(*) FROM sales UNION ALL
SELECT 'employees', COUNT(*) FROM employees UNION ALL
SELECT 'inventory_items', COUNT(*) FROM inventory_items;
"
-- 1. cash_funds
CREATE TABLE IF NOT EXISTS public.cash_funds (
);
-- 2. customer_lists
CREATE TABLE IF NOT EXISTS public.customer_lists (
);
-- 3. customers
CREATE TABLE IF NOT EXISTS public.customers (
);
-- 4. deleted_records
CREATE TABLE IF NOT EXISTS public.deleted_records (
);
-- 5. employee_transactions
CREATE TABLE IF NOT EXISTS public.employee_transactions (
);
-- 6. employees
CREATE TABLE IF NOT EXISTS public.employees (
);
-- 7. fund_transactions
CREATE TABLE IF NOT EXISTS public.fund_transactions (
);
-- 8. inventory_items
CREATE TABLE IF NOT EXISTS public.inventory_items (
);
-- 9. payment_collections
CREATE TABLE IF NOT EXISTS public.payment_collections (
);
-- 10. payments
CREATE TABLE IF NOT EXISTS public.payments (
);
-- 11. reps
CREATE TABLE IF NOT EXISTS public.reps (
);
-- 12. sales
CREATE TABLE IF NOT EXISTS public.sales (
);
-- 13. system_settings
CREATE TABLE IF NOT EXISTS public.system_settings (
);
psql -U postgres -d app_database
sudo -u postgres psql -d app_database
SELECT 'customers' AS table_name, COUNT(*) AS total_count FROM customers UNION ALL
SELECT 'payments', COUNT(*) FROM payments UNION ALL
SELECT 'reps', COUNT(*) FROM reps UNION ALL
SELECT 'sales', COUNT(*) FROM sales UNION ALL
SELECT 'employees', COUNT(*) FROM employees UNION ALL
SELECT 'inventory_items', COUNT(*) FROM inventory_items;
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database
SELECT 
FROM (
) t;
PGPASSWORD='vOY9)hN0)5egF3cL' pg_dump -h 72.62.158.128 -U app_user -d app_database > my_app_backup_$(date +%F).sql
SELECT 
FROM (
) t;
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database
SELECT 
FROM (
) t;
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database
sudo -u postgres psql -d app_database
cd /var/www/alkarrar-app
git pull
npm install
npm run build
pm2 restart alkarrar-app
pm2 logs alkarrar-app --lines 50
apt update && apt install -y curl && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt install -y nodejs && npm install -g pm2 && cd /var/www/alkarrar-app && npm install && npm run build && pm2 start npm --name "alkarrar-app" -- start || pm2 restart alkarrar-app && pm2 save
cd /var/www/alkarrar-app && npm install && npm run build && pm2 start npm --name "alkarrar-app" -- run start || pm2 restart alkarrar-app && pm2 save
find / -name "alkarrar-app" 2>/dev/null
mkdir -p /var/www/alkarrar-app
cd /var/www/alkarrar-app
npm install && npm run build && pm2 start npm --name "alkarrar-app" -- run start || pm2 restart alkarrar-app && pm2 save
git clone <رابط_مستودع_الـ_Git> .
npm install && npm run build && pm2 start npm --name "alkarrar-app" -- run start && pm2 save
git clone YOUR_GIT_URL .
https://github.com/alshplyd-prog/alkarrar-app.git
git clone https://github.com/alshplyd-prog/alkarrar-app.git . && npm install && npm run build && pm2 start npm --name "alkarrar-app" -- run start && pm2 save
rm -rf .git && git clone https://github.com/alshplyd-prog/alkarrar-app.git .
cd /root
rm -rf /var/www/alkarrar-app && mkdir -p /var/www/alkarrar-app && cd /var/www/alkarrar-app
git clone https://github.com/alshplyd-prog/alkarrar-app.git .
cd /var/www/alkarrar-app && rm -rf .git && git clone https://YOUR_TOKEN@github.com/alshplyd-prog/alkarrar-app.git .
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
cd /var/www/alkarrar-app && rm -rf .git && git clone https://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@github.com/alshplyd-prog/alkarrar-app.git .
npm install && npm run build && pm2 start npm --name "alkarrar-app" -- run start && pm2 save
pm2 startup
pm2 status
pm2 logs alkarrar-app
pm2 logs alkarrar-app --lines 30
cd /var/www/alkarrar-app && nano .env
DATABASE_URL=postgresql://alkarrar_user:srv1965343.hstgr.cloud@127.0.0.1:5432/alkarrar_db
cd /var/www/alkarrar-app && nano .env
pm2 restart alkarrar-app
pm2 logs alkarrar-app --lines 20
sudo -u postgres psql
cd /var/www/alkarrar-app && nano .env
rm /var/www/alkarrar-app/.env
021
echo "DATABASE_URL=postgresql://alkarrar_user:123456@127.0.0.1:5432/alkarrar_db" > /var/www/alkarrar-app/.env
pm2 restart alkarrar-app
sudo -u postgres psql
echo "DATABASE_URL=postgresql://alkarrar_user:123456@127.0.0.1:5432/alkarrar_db" > /var/www/alkarrar-app/.env
pm2 restart alkarrar-app
pm2 logs alkarrar-app --lines 20
pm2 status
pm2 logs alkarrar-app
sudo -u postgres psql -d alkarrar_db
pm2 stop alkarrar-app
pm2 flush
pm2 start alkarrar-app
pm2 logs alkarrar-app --lines 30
sudo -u postgres psql -d alkarrar_db
SELECT 'إجمالي المبيعات' AS البيان, COALESCE(SUM(total_amount), 0) AS المجموع FROM sales
UNION ALL
SELECT 'إجمالي المدفوعات', COALESCE(SUM(amount), 0) FROM payments
UNION ALL
SELECT 'أرصدة الصناديق النقدية', COALESCE(SUM(balance), 0) FROM cash_funds;
sudo -u postgres psql -d alkarrar_db
\d sales
\d payments
\d cash_funds
sudo -u postgres psql -d alkarrar_db
nano server.ts
cat << 'EOF' > server.ts
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

app.listen(3000, () => console.log('Server running on port 3000'));
EOF

/sudo -u postgres psql
ALTER USER postgres WITH PASSWORD '123456';
sudo -u postgres psql -d alkarrar_db
nano server.js
pm2 logs
sudo -u postgres psql -d alkarrar_db
sudo ufw disable
sudo -u postgres psql -d alkarrar_db
pm2 status
pm2 logs --lines 50
sudo -u postgres psql -d alkarrar_db
nano dist/server.cjs
ls -la
nano server.js
sed -i "s/app.listen(3000)/app.listen(3000, '0.0.0.0')/g" server.js && pm2 restart alkarrar-app
curl http://localhost:3000
sudo -u postgres psql -d alkarrar_db
pm2 logs alkarrar-app
pm2 delete alkarrar-app
pm2 start server.js --name "alkarrar-app"
sudo -u postgres psql -d alkarrar_db
pm2 logs alkarrar-app
nano server.js
sed -i '1i const { Pool } = require(\'pg\');' server.js && pm2 restart alkarrar-app
sed -i '1i const { Pool } = require("pg");' server.js && pm2 restart alkarrar-app
sudo -u postgres psql -d alkarrar_db
pm2 logs alkarrar-app
sudo ufw allow 3000/tcp
node server.js
# أو بواسطة PM2 ليبقى يعمل في الخلفية:
pm2 start server.js --name "api-server"
npm install pg express cors dotenv
pm2 delete all
pm2 start server.js --name "api-server"
pm2 status
ufw allow 3000/tcp
ufw reload
curl http://127.0.0.1:3000/
pm2 logs api-server --lines 20
npm install pg
pm2 restart alkarrar-app
pm2 start server.js --name "alkarrar-app"
sudo -u postgres psql -d alkarrar_db
pm2 logs alkarrar-app
pm2 delete alkarrar-app
pm2 start server.js --name "alkarrar-app"
pm2 save
sudo -u postgres psql -d alkarrar_db
pm2 logs alkarrar-app
pm2 delete all
pm2 start server.js --name "alkarrar-app"
pm2 save
pm2 logs alkarrar-app
nano server.js
npm install express cors pg && pm2 delete all && pm2 start server.js --name "alkarrar-app" && pm2 save
sudo -u postgres psql -d alkarrar_db
nano server.js
rm server.js
nano server.js
pm2 restart alkarrar-app
sudo -u postgres psql -d alkarrar_db
pm2 restart all
git pull
pm2 restart all
sudo -u postgres psql -d alkarrar_db
cd /path/to/your/project
git pull
npm install
pm2 restart alkarrar-app
cd ~ && find . -name "server.js"
find / -name ".git" -type d 2>/dev/null
cd ~ && find . -name "server.js"
find / -name ".git" -type d 2>/dev/null
cd /var/www/alkarrar-app
git pull
npm install
pm2 restart alkarrar-app
sudo -u postgres psql -d alkarrar_db
pm2 logs alkarrar-app
pm2 delete alkarrar-app
cd /var/www/alkarrar-app
pm2 start server.js --name alkarrar-app
ls -la
pm2 start server.ts --interpreter ts-node --name alkarrar-app
npm install -g tsx
pm2 start server.ts --interpreter tsx --name alkarrar-app
pm2 save
sudo -u postgres psql -d alkarrar_db
pm2 logs alkarrar-app
curl ifconfig.me
hostname -I
curl -X POST http://localhost:3000/api/sync   -H "Content-Type: application/json"   -d '{"test": true, "message": "Hello from terminal"}'
curl -X POST http://localhost:3000/api/sync   -H "Content-Type: application/json"   -d '{"test": true, "message": "Hello from terminal"}'
pm2 logs alkarrar-app --lines 20
curl -X POST http://72.62.158.128:3000/api/sync   -H "Content-Type: application/json"   -d '{
    "customers": [
      {"name": "تجربة عميل", "phone": "07800000000"}
    ]
  }'
sudo -u postgres psql -d alkarrar_db
curl -i -X POST http://72.62.158.128:3000/api/sync   -H "Content-Type: application/json"   -d '{"customers": [{"name": "تجربة عميل", "phone": "07800000000"}]}'
grep -rn "app.post" /var/www/alkarrar-app/
curl -i -X POST http://72.62.158.128:3000/api/sync/batch   -H "Content-Type: application/json"   -d '{"customers": [{"name": "تجربة عميل", "phone": "07800000000"}]}'
git pull origin main
npm install
pm2 restart all
cd /path/to/your/project
git pull origin main
pm2 restart all
find / -name "server.js" -o -name "server.ts" 2>/dev/null
cd /var/www/alkarrar-app
git pull origin main
npm install
pm2 restart all
async function syncDataWithServer(actionsQueue) {
}
curl -i -X POST http://72.62.158.128:3000/api/sync/batch   -H "Content-Type: application/json"   -d '{"actions": [{"id": "test-1", "type": "CREATE_CUSTOMER", "payload": {"name": "تجربة حقيقية", "phone": "07800000000"}}]}'
// مسار لجلب المجاميع والإحصائيات من السيرفر
app.get('/api/reports/totals', async (req, res) => {
});
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
curl -s http://72.62.158.128:3000/api/reports/totals
curl -i http://72.62.158.128:3000/api/reports/totals
// 1. ضع مسارات الـ API أولاً
app.post('/api/sync/batch', handleSyncBatch);
app.get('/api/reports/totals', handleGetTotals);
// 2. ضع ملفات الـ Static والتوجيه العام (React) في النهاية
app.use(express.static(path.join(__dirname, 'dist')));
app.get('*', (req, res) => {
});
git pull
npm install
pm2 restart all
cd /path/to/your/project
git pull
npm install
pm2 restart all
pwd
cd اسم_مجلد_المشروع
git pull
npm install
pm2 restart all
pm2 info alkarrar-app | grep "script path"
cd /مسار_المجلد_الذي_ظهر_لك
git pull
npm install
pm2 restart alkarrar-app
cd /var/www/alkarrar-app
git pull
npm install
pm2 restart alkarrar-app
curl -s http://72.62.158.128:3000/api/reports/totals
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
pm2 logs alkarrar-app --lines 50
psql -U postgres -d alkarrar_db -c "\d cash_funds"
sudo -u postgres psql -d alkarrar_db -c "\d cash_funds"
sudo -u postgres psql -d alkarrar_db -c "\d employees"
pm2 restart alkarrar-app
sudo -u postgres psql -d alkarrar_db -c "SELECT id, name, balance FROM cash_funds;"
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
git pull
npm install
pm2 restart alkarrar-app
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
sudo -u postgres psql -d alkarrar_db -c "\dt"
nano server.ts
find . -name "server.ts" -o -name "index.ts"
cd alkarrar-app
find . -name "server.ts"
ls -la
nano server.ts
pm2 restart alkarrar-app
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
pm2 info alkarrar-app
cd /var/www/alkarrar-app
nano server.ts
cd /var/www/alkarrar-app
pm2 status
cat << 'EOF' >> server.ts

app.get('/api/reports/totals', async (req, res) => {
  try {
    const [salesRes, paymentsRes, fundsRes, employeesRes, repsRes, inventoryRes] = await Promise.all([
      pool.query(`SELECT COUNT(*)::int AS total, COALESCE(SUM(total_price), 0)::float AS "totalSalesAmount" FROM sales`).catch(() => ({ rows: [{}] })),
      pool.query(`SELECT COUNT(*)::int AS "totalCount", COALESCE(SUM(amount), 0)::float AS "totalAmount" FROM payments`).catch(() => ({ rows: [{}] })),
      pool.query(`SELECT COUNT(*)::int AS count, COALESCE(SUM(balance), 0)::float AS "totalBalance" FROM cash_funds`).catch(() => ({ rows: [{}] })),
      pool.query(`SELECT COUNT(*)::int AS total FROM employees`).catch(() => ({ rows: [{}] })),
      pool.query(`SELECT COUNT(*)::int AS total FROM reps`).catch(() => ({ rows: [{}] })),
      pool.query(`SELECT COUNT(*)::int AS "totalItems", COALESCE(SUM(quantity), 0)::int AS "totalQuantity", COALESCE(SUM(price * quantity), 0)::float AS "totalValue" FROM inventory_items`).catch(() => ({ rows: [{}] }))
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
    res.status(500).json({ success: false, error: err.message });
  }
});
EOF

pm2 restart alkarrar-app
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
curl -i http://72.62.158.128:3000/api/reports/totals
pm2 logs alkarrar-app --lines 20 --nostream
git checkout server.ts
nano server.ts
git checkout server.ts
sed -i '/app\.listen/i \
app.get(\x27/api/reports/totals\x27, async (req, res) => {\
  try {\
    const [salesRes, paymentsRes, fundsRes, employeesRes, repsRes, inventoryRes] = await Promise.all([\
      pool.query(`SELECT COUNT(*)::int AS total, COALESCE(SUM(total_price), 0)::float AS "totalSalesAmount" FROM sales`).catch(() => ({ rows: [{}] })),\
      pool.query(`SELECT COUNT(*)::int AS "totalCount", COALESCE(SUM(amount), 0)::float AS "totalAmount" FROM payments`).catch(() => ({ rows: [{}] })),\
      pool.query(`SELECT COUNT(*)::int AS count, COALESCE(SUM(balance), 0)::float AS "totalBalance" FROM cash_funds`).catch(() => ({ rows: [{}] })),\
      pool.query(`SELECT COUNT(*)::int AS total FROM employees`).catch(() => ({ rows: [{}] })),\
      pool.query(`SELECT COUNT(*)::int AS total FROM reps`).catch(() => ({ rows: [{}] })),\
      pool.query(`SELECT COUNT(*)::int AS "totalItems", COALESCE(SUM(quantity), 0)::int AS "totalQuantity", COALESCE(SUM(price * quantity), 0)::float AS "totalValue" FROM inventory_items`).catch(() => ({ rows: [{}] }))\
    ]);\
    res.json({\
      success: true,\
      database: "postgresql",\
      contracts: salesRes.rows[0] || {},\
      payments: paymentsRes.rows[0] || {},\
      funds: fundsRes.rows[0] || {},\
      employees: employeesRes.rows[0] || {},\
      reps: repsRes.rows[0] || {},\
      inventory: inventoryRes.rows[0] || {}\
    });\
  } catch (err: any) {\
    res.status(500).json({ success: false, error: err.message });\
  }\
});\
' server.ts
pm2 restart alkarrar-app
git checkout server.ts
node -e '
const fs = require("fs");
let code = fs.readFileSync("server.ts", "utf8");
const snippet = `
app.get("/api/reports/totals", async (req, res) => {
  try {
    const [salesRes, paymentsRes, fundsRes, employeesRes, repsRes, inventoryRes] = await Promise.all([
      pool.query(\`SELECT COUNT(*)::int AS total, COALESCE(SUM(total_price), 0)::float AS "totalSalesAmount" FROM sales\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS "totalCount", COALESCE(SUM(amount), 0)::float AS "totalAmount" FROM payments\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS count, COALESCE(SUM(balance), 0)::float AS "totalBalance" FROM cash_funds\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS total FROM employees\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS total FROM reps\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS "totalItems", COALESCE(SUM(quantity), 0)::int AS "totalQuantity", COALESCE(SUM(price * quantity), 0)::float AS "totalValue" FROM inventory_items\`).catch(() => ({ rows: [{}] }))
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
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
});
`;
code = code.replace(/app\.listen/, snippet + "\napp.listen");
fs.writeFileSync("server.ts", code);
'
pm2 restart alkarrar-app
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
node -e '
const { Pool } = require("pg");
const pool = new Pool({ connectionString: process.env.DATABASE_URL || "postgres://postgres:postgres@localhost:5432/alkarrar" });
async function check() {
  const res = await pool.query("SELECT table_name FROM information_schema.tables WHERE table_schema=\x27public\x27");
  console.log("Tables:", res.rows.map(r => r.table_name));
}
check();
'
node -e '
require("dotenv").config();
const { Pool } = require("pg");
const pool = new Pool({ connectionString: process.env.DATABASE_URL });
async function check() {
  try {
    const res = await pool.query("SELECT table_name FROM information_schema.tables WHERE table_schema=\x27public\x27");
    console.log("Tables:", res.rows.map(r => r.table_name));
  } catch (err) {
    console.error("Error:", err.message);
  } finally {
    pool.end();
  }
}
check();
'
node -e '
require("dotenv").config();
const { Pool } = require("pg");
const pool = new Pool({ connectionString: process.env.DATABASE_URL });
async function check() {
  const res = await pool.query("SELECT column_name FROM information_schema.columns WHERE table_name=\x27contracts\x27");
  console.log("Contracts columns:", res.rows.map(r => r.column_name));
  const res2 = await pool.query("SELECT column_name FROM information_schema.columns WHERE table_name=\x27sales\x27");
  console.log("Sales columns:", res2.rows.map(r => r.column_name));
  pool.end();
}
check();
'
node -e '
const fs = require("fs");
let code = fs.readFileSync("server.ts", "utf8");
// Remove old endpoint if exists
code = code.replace(/app\.get\("\/api\/reports\/totals"[\s\S]*?\}\);\s*\}\);\s*/g, "");

const snippet = `
app.get("/api/reports/totals", async (req, res) => {
  try {
    const [contractsRes, paymentsRes, fundsRes, employeesRes, repsRes, inventoryRes] = await Promise.all([
      pool.query(\`SELECT 
        COUNT(*)::int AS total,
        COUNT(*) FILTER (WHERE status = \x27active\x27)::int AS active,
        COUNT(*) FILTER (WHERE status = \x27completed\x27)::int AS completed,
        COALESCE(SUM(total_price), 0)::float AS "totalSalesAmount",
        COALESCE(SUM(advance_payment), 0)::float AS "totalAdvancePayment",
        COALESCE(SUM(total_paid), 0)::float AS "totalPaidAmount",
        COALESCE(SUM(remaining_balance), 0)::float AS "totalRemainingBalance"
        FROM contracts\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS "totalCount", COALESCE(SUM(amount), 0)::float AS "totalAmount" FROM payments\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS count, COALESCE(SUM(balance), 0)::float AS "totalBalance" FROM cash_funds\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS total FROM employees\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS total FROM reps\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS "totalItems", COALESCE(SUM(quantity), 0)::int AS "totalQuantity", COALESCE(SUM(price * quantity), 0)::float AS "totalValue" FROM inventory_items\`).catch(() => ({ rows: [{}] }))
    ]);

    res.json({
      success: true,
      database: "postgresql",
      contracts: contractsRes.rows[0] || {},
      payments: paymentsRes.rows[0] || {},
      funds: fundsRes.rows[0] || {},
      employees: employeesRes.rows[0] || {},
      reps: repsRes.rows[0] || {},
      inventory: inventoryRes.rows[0] || {}
    });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
});
`;
code = code.replace(/app\.listen/, snippet + "\napp.listen");
fs.writeFileSync("server.ts", code);
'
pm2 restart alkarrar-app
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
git checkout server.ts
node -e '
const fs = require("fs");
let code = fs.readFileSync("server.ts", "utf8");
const snippet = `
app.get("/api/reports/totals", async (req, res) => {
  try {
    const [contractsRes, paymentsRes, fundsRes, employeesRes, repsRes, inventoryRes] = await Promise.all([
      pool.query(\`SELECT COUNT(*)::int AS total, COUNT(*) FILTER (WHERE status = '\''active\'')::int AS active, COUNT(*) FILTER (WHERE status = '\''completed\'')::int AS completed, COALESCE(SUM(total_price), 0)::float AS "totalSalesAmount", COALESCE(SUM(advance_payment), 0)::float AS "totalAdvancePayment", COALESCE(SUM(total_paid), 0)::float AS "totalPaidAmount", COALESCE(SUM(remaining_balance), 0)::float AS "totalRemainingBalance" FROM contracts\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS "totalCount", COALESCE(SUM(amount), 0)::float AS "totalAmount" FROM payments\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS count, COALESCE(SUM(balance), 0)::float AS "totalBalance" FROM cash_funds\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS total FROM employees\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS total FROM reps\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS "totalItems", COALESCE(SUM(quantity), 0)::int AS "totalQuantity", COALESCE(SUM(price * quantity), 0)::float AS "totalValue" FROM inventory_items\`).catch(() => ({ rows: [{}] }))
    ]);
    res.json({
      success: true,
      database: "postgresql",
      contracts: contractsRes.rows[0] || {},
      payments: paymentsRes.rows[0] || {},
      funds: fundsRes.rows[0] || {},
      employees: employeesRes.rows[0] || {},
      reps: repsRes.rows[0] || {},
      inventory: inventoryRes.rows[0] || {}
    });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
});
`;
code = code.replace(/app\.listen/, snippet + "\napp.listen");
fs.writeFileSync("server.ts", code);
'
pm2 restart alkarrar-app
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
node -e '
require("dotenv").config();
const { Pool } = require("pg");
const pool = new Pool({ connectionString: process.env.DATABASE_URL });
async function check() {
  const res = await pool.query("SELECT column_name, data_type FROM information_schema.columns WHERE table_name=\x27contracts\x27");
  console.log(res.rows.map(r => r.column_name + " (" + r.data_type + ")"));
  pool.end();
}
check();
'
node -e '
require("dotenv").config();
const { Pool } = require("pg");
const pool = new Pool({ connectionString: process.env.DATABASE_URL });
async function check() {
  const c = await pool.query("SELECT COUNT(*) FROM contracts");
  console.log("Contracts count:", c.rows[0].count);
  const s = await pool.query("SELECT COUNT(*) FROM sales");
  console.log("Sales count:", s.rows[0].count);
  pool.end();
}
check();
'
node -e '
require("dotenv").config();
const { Pool } = require("pg");
const pool = new Pool({ connectionString: process.env.DATABASE_URL });
async function check() {
  const tables = ["contracts", "customers", "inventory_items", "reps", "cash_funds", "sales", "payments", "employees"];
  for (let t of tables) {
    try {
      const res = await pool.query(`SELECT COUNT(*) FROM ${t}`);
      console.log(`${t}: ${res.rows[0].count}`);
    } catch (e) {
      console.log(`${t}: error`);
    }
  }
  pool.end();
}
check();
'
cd /var/www/alkarrar-app
node -e '
require("dotenv").config();
const { Pool } = require("pg");
const pool = new Pool({ connectionString: process.env.DATABASE_URL });
async function check() {
  const tables = ["contracts", "customers", "inventory_items", "reps", "cash_funds", "sales", "payments", "employees"];
  for (let t of tables) {
    try {
      const res = await pool.query(`SELECT COUNT(*) FROM ${t}`);
      console.log(`${t}: ${res.rows[0].count}`);
    } catch (e) {
      console.log(`${t}: error`);
    }
  }
  pool.end();
}
check();
'
node -e '
const fs = require("fs");
let code = fs.readFileSync("server.ts", "utf8");
code = code.replace(/app\.get\("\/api\/reports\/totals"[\s\S]*?\}\);\s*\}\);\s*/g, "");

const snippet = `
app.get("/api/reports/totals", async (req, res) => {
  try {
    const [contractsRes, paymentsRes, fundsRes, employeesRes, repsRes, inventoryRes] = await Promise.all([
      pool.query(\`SELECT COUNT(*)::int AS total, COALESCE(SUM(total_price), 0)::float AS "totalSalesAmount" FROM contracts\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS "totalCount", COALESCE(SUM(amount), 0)::float AS "totalAmount" FROM payments\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS count, COALESCE(SUM(balance), 0)::float AS "totalBalance" FROM cash_funds\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS total FROM employees\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS total FROM reps\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS "totalItems", COALESCE(SUM(quantity), 0)::int AS "totalQuantity", COALESCE(SUM(price * quantity), 0)::float AS "totalValue" FROM inventory_items\`).catch(() => ({ rows: [{}] }))
    ]);

    res.json({
      success: true,
      database: "postgresql",
      contracts: contractsRes.rows[0] || {},
      payments: paymentsRes.rows[0] || {},
      funds: fundsRes.rows[0] || {},
      employees: employeesRes.rows[0] || {},
      reps: repsRes.rows[0] || {},
      inventory: inventoryRes.rows[0] || {}
    });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
});
`;
code = code.replace(/app\.listen/, snippet + "\napp.listen");
fs.writeFileSync("server.ts", code);
'
pm2 restart alkarrar-app
cd /var/www/alkarrar-app
node -e '
require("dotenv").config();
const { Pool } = require("pg");
const pool = new Pool({ connectionString: process.env.DATABASE_URL });
async function fullReport() {
  const [c, p, f, e, r, i] = await Promise.all([
    pool.query("SELECT COUNT(*)::int AS count, COALESCE(SUM(total_price), 0)::float AS total_price, COALESCE(SUM(total_paid), 0)::float AS total_paid FROM contracts").catch(() => ({ rows: [{}] })),
    pool.query("SELECT COUNT(*)::int AS count, COALESCE(SUM(amount), 0)::float AS total_amount FROM payments").catch(() => ({ rows: [{}] })),
    pool.query("SELECT COUNT(*)::int AS count, COALESCE(SUM(balance), 0)::float AS total_balance FROM cash_funds").catch(() => ({ rows: [{}] })),
    pool.query("SELECT COUNT(*)::int AS count FROM employees").catch(() => ({ rows: [{}] })),
    pool.query("SELECT COUNT(*)::int AS count FROM reps").catch(() => ({ rows: [{}] })),
    pool.query("SELECT COUNT(*)::int AS count, COALESCE(SUM(quantity), 0)::int AS total_qty, COALESCE(SUM(price * quantity), 0)::float AS total_val FROM inventory_items").catch(() => ({ rows: [{}] }))
  ]);
  console.log("=== FULL DATABASE TOTALS REPORT ===");
  console.log("Contracts:", c.rows[0]);
  console.log("Payments:", p.rows[0]);
  console.log("Cash Funds:", f.rows[0]);
  console.log("Employees:", e.rows[0]);
  console.log("Reps:", r.rows[0]);
  console.log("Inventory Items:", i.rows[0]);
  pool.end();
}
fullReport();
'
cd /var/www/alkarrar-app
node -e '
require("dotenv").config();
const { Pool } = require("pg");
const pool = new Pool({ connectionString: process.env.DATABASE_URL });
async function checkAll() {
  const res = await pool.query("SELECT table_name FROM information_schema.tables WHERE table_schema=\x27public\x27");
  for (let row of res.rows) {
    try {
      const countRes = await pool.query(`SELECT COUNT(*) FROM "${row.table_name}"`);
      console.log(`${row.table_name}: ${countRes.rows[0].count}`);
    } catch (e) {
      console.log(`${row.table_name}: error`);
    }
  }
  pool.end();
}
checkAll();
'
node -e '
require("dotenv").config();
const { Pool } = require("pg");
const pool = new Pool({ connectionString: process.env.DATABASE_URL });
async function sample() {
  const res = await pool.query("SELECT * FROM customer_lists LIMIT 3");
  console.log("Customer Lists Sample:", res.rows);
  pool.end();
}
sample();
'
node -e '
require("dotenv").config();
const { Pool } = require("pg");
const pool = new Pool({ connectionString: process.env.DATABASE_URL });
async function inspectTables() {
  const res = await pool.query("SELECT table_name FROM information_schema.tables WHERE table_schema=\x27public\x27");
  for (let r of res.rows) {
    const count = await pool.query(`SELECT COUNT(*) FROM "${r.table_name}"`);
    console.log(`Table: ${r.table_name} -> Rows: ${count.rows[0].count}`);
  }
  pool.end();
}
inspectTables();
'
grep -n "contracts" server.ts
grep -n "sales" server.ts
cd /var/www/alkarrar-app
node -e '
const fs = require("fs");
let code = fs.readFileSync("server.ts", "utf8");

// Remove old totals endpoint
code = code.replace(/app\.get\("\/api\/reports\/totals"[\s\S]*?\}\);\s*\}\);\s*/g, "");

const snippet = `
app.get("/api/reports/totals", async (req, res) => {
  try {
    // Fetch from fileDb (the app active storage) and Postgres for funds/inventory
    const contractsList = fileDb.get("contracts") || fileDb.get("sales") || [];
    
    let totalSalesAmount = 0;
    let totalAdvancePayment = 0;
    let totalPaidAmount = 0;
    let totalRemainingBalance = 0;
    let activeCount = 0;
    let completedCount = 0;

    contractsList.forEach((c: any) => {
      totalSalesAmount += Number(c.total_price || c.price || 0);
      totalAdvancePayment += Number(c.advance_payment || 0);
      totalPaidAmount += Number(c.total_paid || 0);
      totalRemainingBalance += Number(c.remaining_balance || 0);
      if (c.status === "active") activeCount++;
      if (c.status === "completed") completedCount++;
    });

    const [fundsRes, inventoryRes, employeesRes, repsRes] = await Promise.all([
      pool.query(\`SELECT COUNT(*)::int AS count, COALESCE(SUM(balance), 0)::float AS "totalBalance" FROM cash_funds\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS "totalItems", COALESCE(SUM(quantity), 0)::int AS "totalQuantity", COALESCE(SUM(price * quantity), 0)::float AS "totalValue" FROM inventory_items\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS total FROM employees\`).catch(() => ({ rows: [{}] })),
      pool.query(\`SELECT COUNT(*)::int AS total FROM reps\`).catch(() => ({ rows: [{}] }))
    ]);

    res.json({
      success: true,
      source: "fileDb + postgresql",
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
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
});
`;

code = code.replace(/app\.listen/, snippet + "\napp.listen");
fs.writeFileSync("server.ts", code);
'
pm2 restart alkarrar-app
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
git checkout server.ts
node -e '
const fs = require("fs");
let code = fs.readFileSync("server.ts", "utf8");

const snippet = `
app.get("/api/reports/totals", async (req, res) => {
  try {
    const contractsList = fileDb.get("contracts") || fileDb.get("sales") || [];
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
      source: "fileDb + postgresql",
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
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
});
`;

code = code.replace(/app\.listen/, snippet + "\napp.listen");
fs.writeFileSync("server.ts", code);
'
pm2 restart alkarrar-app
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
git checkout server.ts
node -e '
const fs = require("fs");
let code = fs.readFileSync("server.ts", "utf8");
if (!code.includes("/api/reports/totals")) {
  const routeCode = `
app.get("/api/reports/totals", async (req, res) => {
  try {
    const contractsList = (typeof fileDb !== "undefined" && fileDb.get) ? (fileDb.get("contracts") || fileDb.get("sales") || []) : [];
    let totalSalesAmount = 0, totalAdvancePayment = 0, totalPaidAmount = 0, totalRemainingBalance = 0, activeCount = 0, completedCount = 0;
    
    contractsList.forEach((c) => {
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
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
});
`;
  code = code.replace(/app\.listen/, routeCode + "\napp.listen");
  fs.writeFileSync("server.ts", code);
}
'
pm2 restart alkarrar-app
curl -s http://72.62.158.128:3000/api/reports/totals
git checkout server.ts
nano server.ts
git checkout server.ts
nano server.ts
pm2 restart alkarrar-app
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
cd /var/www/alkarrar-app
nano server.ts
cd /var/www/alkarrar-app
npm run build
pm2 restart alkarrar-app
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
cd /var/www/alkarrar-app
cat .env
nano .env
cd /var/www/alkarrar-app
nano server.ts
npm run build
pm2 restart alkarrar-app
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
curl http://72.62.158.128:3000/api/reports/totals
pm2 logs alkarrar-app --lines 15
cd /var/www/alkarrar-app
git checkout server.ts
app.get("/api/reports/totals", async (req, res) => {
});
cd /var/www/alkarrar-app
nano server.ts
cd /var/www/alkarrar-app
nano server.ts
npm run build
pm2 restart alkarrar-app
curl -s http://72.62.158.128:3000/api/reports/totals | json_pp
curl http://72.62.158.128:3000/api/reports/totals
pm2 status
pm2 logs alkarrar-app --lines 20
cd /var/www/alkarrar-app
echo 'DATABASE_URL="postgresql://app_user:vOY9)hN0)5egF3cL@72.62.158.128:5432/app_database"' > .env
pm2 restart alkarrar-app
curl -s http://127.0.0.1:3000/api/reports/totals | json_pp
curl http://127.0.0.1:3000/api/reports/totals
pm2 logs alkarrar-app --lines 10
cat .env
pwdx $(pgrep -f "node" | head -n 1)
cd /var/www/alkarrar-app
cat .env
sudo -u postgres psql -c "\l"
sudo -u postgres psql -d alkarrar_db -c "SELECT 'alkarrar_db' AS db, count(*) FROM inventory_items;" ; sudo -u postgres psql -d app_database -c "SELECT 'app_database' AS db, count(*) FROM inventory_items;"
cat .env
sudo -u postgres psql -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'alkarrar_db';"
sudo -u postgres psql -c "DROP DATABASE alkarrar_db;"
sudo -u postgres psql -c "\l"
git pull
npm run build
pm2 restart all
curl -s http://localhost:3000/api/reports/totals
pm2 restart alkarrar-app --update-env
pm2 logs alkarrar-app --lines 20
git reset --hard HEAD
git pull origin main
npm run build
cd /var/www/alkarrar-app
sed -i '/app\.get("\/api\/reports\/totals"/,$d' server.ts
npm run build
pm2 delete all
pm2 start dist/server.cjs --name alkarrar-app --update-env
pm2 save
git stash
git pull
npm run build
pm2 start dist/server.cjs --name alkarrar-app --update-env
pm2 save
pm2 status
curl -s http://localhost:3000/api/reports/totals
sudo -u postgres psql -d app_database -c "
SELECT 'الزبائن (Customers)' AS الحقل, count(*) AS العدد FROM customers
UNION ALL
SELECT 'العقود (Contracts)', count(*) FROM contracts
UNION ALL
SELECT 'الدفعات والتسديدات (Payments)', count(*) FROM payments
UNION ALL
SELECT 'المواد في المخزن (Items)', count(*) FROM items
UNION ALL
SELECT 'حركات المخزن (Transactions)', count(*) FROM inventory_transactions
UNION ALL
SELECT 'الصناديق (Funds)', count(*) FROM funds
UNION ALL
SELECT 'حركات الصناديق (Fund Transfers)', count(*) FROM fund_transactions
UNION ALL
SELECT 'الموظفين (Employees)', count(*) FROM employees
UNION ALL
SELECT 'المستخدمين (Users)', count(*) FROM users;
"
curl -s http://localhost:3000/api/customers | jq 'length'
curl -s http://localhost:3000/api/customers
psql "postgresql://app_user:vOY9)hN0)5egF3cL@72.62.158.128:5432/app_database"
SELECT 
FROM 
ORDER BY 
SELECT 
FROM (
) t;
SELECT 'الزبائن (Customers)' AS section_name, COUNT(*) AS total_count, NULL AS total_amount FROM الزبائن
UNION ALL
SELECT 'التسديدات (Payments)', COUNT(*), COALESCE(SUM(amount), 0) FROM التسديدات
UNION ALL
SELECT 'الموظفين (Employees)', COUNT(*), NULL FROM الموظفين
UNION ALL
SELECT 'المندوبين (Reps)', COUNT(*), NULL FROM المندوبين
UNION ALL
SELECT 'الصناديق (Cash Registers)', COUNT(*), COALESCE(SUM(balance), 0) FROM الصناديق
UNION ALL
SELECT 'القوائم / الفواتير (Invoices/Bills)', COUNT(*), COALESCE(SUM(total_amount), 0) FROM القوائم
UNION ALL
SELECT 'عمليات الصناديق (Cash Operations)', COUNT(*), COALESCE(SUM(amount), 0) FROM عمليات_الصناديق
UNION ALL
SELECT 'المبيعات (Sales)', COUNT(*), COALESCE(SUM(total_price), 0) FROM المبيعات;
cd /path/to/your/project
git pull origin main
npm install
pm2 restart all
cd /path/to/your/project
git fetch origin
cd /path/to/your/project
git fetch origin
git status
git log -n 5 --oneline
git pull origin main
pm2 restart all
pm2 describe alkarrar-app
cd /var/www/alkarrar-app
git pull origin main
npm install
pm2 restart all
sudo -u postgres psql
cd /var/www/alkarrar-app
git pull origin main
npm install
pm2 restart all
pm2 logs alkarrar-app --lines 50
sudo -u postgres psql
SELECT 
FROM sales c
WHERE NOT EXISTS (
);
SELECT 
FROM 
ORDER BY 
cd /var/www/alkarrar-app
nano server.ts
sudo -u postgres psql
psql "postgresql://app_user:vOY9)hN0)5egF3cL@72.62.158.128:5432/app_database"
\x
sudo -u postgres psql
psql "postgresql://app_user:vOY9)hN0)5egF3cL@72.62.158.128:5432/app_database"
PGPASSWORD='vOY9)hN0)5egF3cL' psql -h 72.62.158.128 -U app_user -d app_database
sudo -u postgres psql
sudo -u postgres psql -c "SELECT (SELECT COUNT(*) FROM contracts) AS عدد_الزبائن, (SELECT COALESCE(SUM(total_price), 0) FROM contracts) AS اجمالي_المبيعات, (SELECT COALESCE(SUM(advance_payment), 0) FROM contracts) AS اجمالي_المقدمات, (SELECT COALESCE(SUM(amount_paid), 0) FROM payments) AS اجمالي_الواصل, ((SELECT COALESCE(SUM(total_price), 0) FROM contracts) - (SELECT COALESCE(SUM(advance_payment), 0) FROM contracts) - (SELECT COALESCE(SUM(amount_paid), 0) FROM payments)) AS المتبقي_الكلي;"
sudo -u postgres psql -d app_database -c "SELECT (SELECT COUNT(*) FROM contracts) AS عدد_الزبائن, (SELECT COALESCE(SUM(total_price), 0) FROM contracts) AS اجمالي_المبيعات, (SELECT COALESCE(SUM(advance_payment), 0) FROM contracts) AS اجمالي_المقدمات, (SELECT COALESCE(SUM(amount_paid), 0) FROM payments) AS اجمالي_الواصل, ((SELECT COALESCE(SUM(total_price), 0) FROM contracts) - (SELECT COALESCE(SUM(advance_payment), 0) FROM contracts) - (SELECT COALESCE(SUM(amount_paid), 0) FROM payments)) AS المتبقي_الكلي, (SELECT COUNT(*) FROM reps) AS عدد_المندوبين, (SELECT COUNT(*) FROM employees) AS عدد_الموظفين, (SELECT COALESCE(SUM(balance), 0) FROM cash_funds) AS رصيد_الصناديق;"
sudo -u postgres psql -d app_database -x -c "
SELECT 
  (SELECT COUNT(*) FROM contracts) AS \"عدد الزبائن (العقود)\",
  (SELECT TO_CHAR(COALESCE(SUM(total_price), 0), 'FM999,999,999,999') FROM contracts) AS \"إجمالي المبيعات\",
  (SELECT TO_CHAR(COALESCE(SUM(advance_payment), 0), 'FM999,999,999,999') FROM contracts) AS \"إجمالي المقدمات المستلمة\",
  (SELECT COUNT(*) FROM payments) AS \"عدد وصولات التسديد\",
  (SELECT TO_CHAR(COALESCE(SUM(amount_paid), 0), 'FM999,999,999,999') FROM payments) AS \"إجمالي مبالغ التسديدات (الواصل)\",
  (SELECT TO_CHAR(((SELECT COALESCE(SUM(total_price), 0) FROM contracts) - (SELECT COALESCE(SUM(advance_payment), 0) FROM contracts) - (SELECT COALESCE(SUM(amount_paid), 0) FROM payments)), 'FM999,999,999,999')) AS \"المتبقي الكلي بذمة الزبائن\",
  (SELECT COUNT(*) FROM customer_lists) AS \"عدد القوائم\",
  (SELECT COUNT(*) FROM cash_funds) AS \"عدد الصناديق النقدية\",
  (SELECT TO_CHAR(COALESCE(SUM(balance), 0), 'FM999,999,999,999') FROM cash_funds) AS \"إجمالي أرصدة الصناديق\",
  (SELECT COUNT(*) FROM reps) AS \"عدد المندوبين\",
  (SELECT COUNT(*) FROM employees) AS \"عدد الموظفين\",
  (SELECT COUNT(*) FROM inventory_items) AS \"عدد مواد المخزن\";
"
# الدخول إلى قاعدة البيانات عبر مستخدم postgres
psql -U postgres -d postgres
SELECT 
sudo -u postgres psql -d app_database -x -c "
SELECT 
  (SELECT COUNT() FROM contracts) AS "عدد الزبائن (العقود)",
"
sudo -u postgres psql -d app_database -x -c "
SELECT 
"
sudo -u postgres psql -d app_database -x -c "
SELECT 
  (SELECT COUNT() FROM contracts) AS "عدد الزبائن (العقود)",
"
sudo -u postgres psql -d app_database -x << 'EOF'
SELECT 
  (SELECT COUNT(*) FROM contracts) AS "عدد الزبائن والعقود",
  (SELECT TO_CHAR(COALESCE(SUM(total_price), 0), 'FM999,999,999,999') FROM contracts) AS "إجمالي المبيعات الكلي",
  (SELECT TO_CHAR(COALESCE(SUM(advance_payment), 0), 'FM999,999,999,999') FROM contracts) AS "إجمالي المقدمات المستلمة",
  (SELECT COUNT(*) FROM payments) AS "عدد وصولات التسديد",
  (SELECT TO_CHAR(COALESCE(SUM(COALESCE(amount_paid, amount, 0)), 0), 'FM999,999,999,999') FROM payments) AS "إجمالي الواصل والمسدد",
  (SELECT TO_CHAR(COALESCE(SUM(remaining_balance), 0), 'FM999,999,999,999') FROM contracts) AS "المتبقي الفعلي بذمة الزبائن",
  (SELECT COUNT(*) FROM customer_lists) AS "عدد القوائم",
  (SELECT COUNT(*) FROM cash_funds) AS "عدد الخزائن والصناديق",
  (SELECT TO_CHAR(COALESCE(SUM(balance), 0), 'FM999,999,999,999') FROM cash_funds) AS "إجمالي أرصدة الخزائن",
  (SELECT COUNT(*) FROM reps) AS "عدد المندوبين",
  (SELECT COUNT(*) FROM employees) AS "عدد الموظفين",
  (SELECT COUNT(*) FROM inventory_items) AS "عدد مواد المخزن";
EOF
sudo -u postgres psql -d app_database -x << 'EOF'
SELECT 
  (SELECT COUNT(*) FROM sales) AS "عدد_العقود_في_التطبيق",
  (SELECT COUNT(*) FROM customers) AS "إجمالي_الزبائن_المسجلين",
  (SELECT TO_CHAR(COALESCE(SUM(total_price), 0), 'FM999,999,999,999') FROM sales) AS "إجمالي_المبيعات_الكلي",
  (SELECT TO_CHAR(COALESCE(SUM(advance_payment), 0), 'FM999,999,999,999') FROM sales) AS "إجمالي_المقدمات_المستلمة",
  (SELECT COUNT(*) FROM payments) AS "عدد_وصولات_التسديد",
  (SELECT TO_CHAR(COALESCE(SUM(COALESCE(amount_paid, amount, 0)), 0), 'FM999,999,999,999') FROM payments) AS "إجمالي_التسديدات_المستلمة",
  (SELECT TO_CHAR(COALESCE(SUM(remaining_balance), 0), 'FM999,999,999,999') FROM sales) AS "المتبقي_الفعلي_بذمة_الزبائن",
  (SELECT COUNT(*) FROM customer_lists) AS "عدد_القوائم",
  (SELECT COUNT(*) FROM cash_funds) AS "عدد_الخزائن",
  (SELECT TO_CHAR(COALESCE(SUM(balance), 0), 'FM999,999,999,999') FROM cash_funds) AS "إجمالي_أرصدة_الخزائن",
  (SELECT COUNT(*) FROM reps) AS "عدد_المندوبين",
  (SELECT COUNT(*) FROM inventory_items) AS "عدد_مواد_المخزن";
EOF

sudo -u postgres psql -d app_database -x << 'EOF'
SELECT 
  (SELECT COUNT(*) FROM sales) AS "عدد_العقود_في_التطبيق",
  (SELECT COUNT(*) FROM customers) AS "إجمالي_الزبائن_المسجلين",
  (SELECT TO_CHAR(COALESCE(SUM(total_price), 0), 'FM999,999,999,999') FROM sales) AS "إجمالي_المبيعات_الكلي",
  (SELECT TO_CHAR(COALESCE(SUM(advance_payment), 0), 'FM999,999,999,999') FROM sales) AS "إجمالي_المقدمات_المستلمة",
  (SELECT COUNT(*) FROM payments) AS "عدد_وصولات_التسديد",
  (SELECT TO_CHAR(COALESCE(SUM(COALESCE(amount_paid, amount, 0)), 0), 'FM999,999,999,999') FROM payments) AS "إجمالي_التسديدات_المستلمة",
  (SELECT TO_CHAR(COALESCE(SUM(remaining_balance), 0), 'FM999,999,999,999') FROM sales) AS "المتبقي_الفعلي_بذمة_الزبائن",
  (SELECT COUNT(*) FROM customer_lists) AS "عدد_القوائم",
  (SELECT COUNT(*) FROM cash_funds) AS "عدد_الخزائن",
  (SELECT TO_CHAR(COALESCE(SUM(balance), 0), 'FM999,999,999,999') FROM cash_funds) AS "إجمالي_أرصدة_الخزائن",
  (SELECT COUNT(*) FROM reps) AS "عدد_المندوبين",
  (SELECT COUNT(*) FROM inventory_items) AS "عدد_مواد_المخزن";
EOF

sudo -u postgres psql -d app_database -x << 'EOF'
SELECT 
  (SELECT COUNT(*) FROM sales) AS "عدد_العقود_في_التطبيق",
  (SELECT COUNT(*) FROM customers) AS "إجمالي_الزبائن_المسجلين",
  (SELECT TO_CHAR(COALESCE(SUM(total_price), 0), 'FM999,999,999,999') FROM sales) AS "إجمالي_المبيعات_الكلي",
  (SELECT TO_CHAR(COALESCE(SUM(advance_payment), 0), 'FM999,999,999,999') FROM sales) AS "إجمالي_المقدمات_المستلمة",
  (SELECT COUNT(*) FROM payments) AS "عدد_وصولات_التسديد",
  (SELECT TO_CHAR(COALESCE(SUM(COALESCE(amount_paid, amount, 0)), 0), 'FM999,999,999,999') FROM payments) AS "إجمالي_التسديدات_المستلمة",
  (SELECT TO_CHAR(COALESCE(SUM(remaining_balance), 0), 'FM999,999,999,999') FROM sales) AS "المتبقي_الفعلي_بذمة_الزبائن",
  (SELECT COUNT(*) FROM customer_lists) AS "عدد_القوائم",
  (SELECT COUNT(*) FROM cash_funds) AS "عدد_الخزائن",
  (SELECT TO_CHAR(COALESCE(SUM(balance), 0), 'FM999,999,999,999') FROM cash_funds) AS "إجمالي_أرصدة_الخزائن",
  (SELECT COUNT(*) FROM reps) AS "عدد_المندوبين",
  (SELECT COUNT(*) FROM inventory_items) AS "عدد_مواد_المخزن";
EOF

git init
git branch -M main
