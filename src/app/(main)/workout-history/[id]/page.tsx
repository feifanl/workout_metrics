import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";
import Link from "next/link";

interface SessionDetailPageProps {
    params: Promise<{ id: string }>;
}

export default async function SessionDetailPage({ params }: SessionDetailPageProps) {
    const { id } = await params;
    const supabase = await createClient();

    // Protect page if not logged in, redirect to login screen
    const { data: authData, error: authError } = await supabase.auth.getClaims();
    if (authError || !authData?.claims) redirect('/auth/login');

    // Fetch the session
    const { data: session } = await supabase
        .from('workout_sessions')
        .select('*')
        .eq('id', id)
        .single();

    if (!session) redirect('/workout-history');

    // Fetch sets for this session, joined with exercise names
    const { data: sets } = await supabase
        .from('workout_sets')
        .select('*, exercises(exercise_name)')
        .eq('workout_id', id)
        .order('set_number');

    const formattedDate = new Date(session.session_date).toLocaleDateString('en-US', {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric',
    });

    return (
        <main className="p-6 max-w-2xl mx-auto">
            <Link
                href="/workout-history"
                className="text-sm text-muted-foreground hover:text-foreground transition-colors mb-4 inline-block"
            >
                ← Back to workout history
            </Link>

            <h1 className="text-2xl font-semibold mb-2">{formattedDate}</h1>

            {session.notes && (
                <p className="text-sm text-muted-foreground mb-6">{session.notes}</p>
            )}

            {sets && sets.length > 0 ? (
                <table className="w-full text-sm mt-6">
                    <thead>
                        <tr className="text-left text-muted-foreground border-b border-white/10">
                            <th className="pb-2 font-medium">Exercise</th>
                            <th className="pb-2 font-medium">Set</th>
                            <th className="pb-2 font-medium">Reps</th>
                            <th className="pb-2 font-medium">Weight</th>
                        </tr>
                    </thead>
                    <tbody>
                        {sets.map((set) => (
                            <tr key={set.id} className="border-b border-white/5">
                                <td className="py-2">{set.exercises?.exercise_name ?? '—'}</td>
                                <td className="py-2">{set.set_number}</td>
                                <td className="py-2">{set.reps}</td>
                                <td className="py-2">{set.set_weight} lbs</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            ) : (
                <p className="text-muted-foreground text-sm mt-6">No sets recorded for this session.</p>
            )}
        </main>
    );
}
