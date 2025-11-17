import { getConnection } from "@/lib/db";

export async function GET() {
  const db = await getConnection();
  const [rows] = await db.execute("SELECT * FROM users");
  return Response.json(rows);
}

export async function POST(request) {
  const data = await request.json();
  const db = await getConnection();
  const [result] = await db.execute(
    "INSERT INTO users (name, email) VALUES (?, ?)",
    [data.name, data.email]
  );
  return Response.json({ id: result.insertId, ...data });
}
