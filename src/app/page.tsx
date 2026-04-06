import { createClient } from "@/lib/supabase/server"
import Link from "next/link";
import Navbar from "@/components/Navbar";

export default async function Home() {
  const supabase = await createClient();
  const { data } = await supabase.auth.getClaims();
  const isLoggedIn = !!data?.claims;

  if (isLoggedIn) {
    return (
      <main>
        <Navbar />
        <div className="flex min-h-screen flex-col items-center justify-center p-8">
          <h1 className="text-4xl font-bold mb-4">Feed</h1>
          <p className="text-gray-600">To be done later</p>
        </div>
      </main>
    );
  }

  // Landing page for visitors who aren't logged in
  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-8 bg-[#001f3f] text-white">
      <h1 className="text-5xl font-bold mb-4 tracking-tight">WorkoutMetrics</h1>
      <p className="text-lg text-white/70 mb-10 max-w-md text-center">
        A one-stop shop for everything you would ever want in a workout app.<br></br>
        Workout logging, progress visualization, and more!
      </p>
      <div className="flex gap-4">
        <Link
          href="/auth/login"
          className="px-6 py-2 rounded-full border border-white/30 text-white hover:bg-white/10 transition-colors font-medium"
        >
          Log in
        </Link>
        <Link
          href="/auth/sign-up"
          className="px-6 py-2 rounded-full bg-white text-[#001f3f] hover:bg-white/90 transition-colors font-medium"
        >
          Sign up
        </Link>
      </div>
    </main>
  );
}