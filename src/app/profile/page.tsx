import Link from 'next/link'

export default function ProfilePage() {
  return (
    <main className="p-6">
      <h1 className = "text-4xl font-bold mb-4">Contact</h1>
      <Link href = "/workout-history" className="text-blue-600 hover:underline">
        View Workout History
      </Link>
    </main>
  );
}