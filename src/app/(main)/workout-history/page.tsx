import { createClient } from "@/lib/supabase/server"
import { redirect } from "next/navigation";
import Link from "next/link";

export default async function WorkoutHistoryPage() {
    const supabase = await createClient();

    // Protect page if not logged in, redirect to login screen
    const { data: authData, error: authError } = await supabase.auth.getClaims();
    if (authError || !authData?.claims) redirect('/auth/login');

    const { data: sessions } = await supabase
        .from('workout_sessions')
        .select('*') // selecting all is fine because of RLS
        .order('session_date', { ascending: false });

    return (
        <main className="p-6 max-w-2xl mx-auto">
            <h1 className="text-2xl font-semibold mb-6">Workout History</h1>

            {sessions && sessions.length > 0 ? (
                <div className="flex flex-col gap-3">
                    {sessions.map((session) => (
                        <Link
                            key={session.id}
                            href={`/workout-history/${session.id}`}
                            className="flex items-center px-5 py-3 rounded-full bg-white/5 hover:bg-white/10 transition-colors text-sm font-medium"
                        >
                            {new Date(session.session_date).toLocaleDateString('en-US', {
                                weekday: 'long',
                                year: 'numeric',
                                month: 'long',
                                day: 'numeric',
                            })}
                        </Link>
                    ))}
                </div>
            ) : (
                <p className="text-muted-foreground text-sm">You have not logged any workouts yet.</p>
            )}
        </main>
    );
}