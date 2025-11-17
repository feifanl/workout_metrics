type User = {
  id: number;
  name: string;
  email: string;
};

export default async function UsersPage() {
  const res = await fetch("http://localhost:3000/api/users", {
    cache: "no-store", // optional - disables caching
  });
  const users: User[] = await res.json();
  if (!Array.isArray(users)) {
    return <p>Invalid data received</p>;
}

  return (
    <main>
      <h1>All Users</h1>
      <ul>
        {users.map((u) => (
          <li key={u.id}>
            {u.name} – {u.email}
          </li>
        ))}
      </ul>
    </main>
  );
}
