import Image from "next/image";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-8">
      <h1 className="text-4xl font-bold mb-4">Workout Metrics</h1>
      <p className="text-lg text-gray-600 mb-8">
        Your one stop shop for everything workouts related
      </p>

      <nav className="flex gap-4">
        <a href="/about" className="text-blue-600 hover:underline">
          About
        </a>
        <a href="/contact" className="text-blue-600 hover:underline">
          Contact
        </a>
        <a href = "/profile" className="text-blue-600 hover:underline">
          View Profile
        </a>
        <a href = "/login" className="text-blue-600 hover:underline">
          Login
        </a>
      </nav>
    </main>
  );
}
