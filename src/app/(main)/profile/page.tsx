import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'

export default async function ProfilePage() {
  const supabase = await createClient();

  // Protect page if not logged in, redirect to login screen
  const { data, error } = await supabase.auth.getClaims();
  if (error || !data?.claims) redirect('/auth/login');
  
  return (
    <main className="p-6">
      <h1 className = "text-4xl font-bold mb-4">Contact</h1>
      <Link href = "/workout-history" className="text-blue-600 hover:underline">
        View Workout History
      </Link>
    </main>
  );
}