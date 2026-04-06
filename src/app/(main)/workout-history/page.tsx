import { createClient } from "@/lib/supabase/server"
import { redirect } from "next/navigation";

export default async function WorkoutHistoryPage() {
    const supabase = await createClient();

    // Protect page if not logged in, redirect to login screen
    const { data: authData, error: authError } = await supabase.auth.getClaims();
    if (authError || !authData?.claims) redirect('/auth/login');

    const { data } = await supabase
            .from('workout_sessions')
            .select('*') // selecting all is fine because of RLS
    
    return (
        <main className="p-6">
        {data?.map((session) => (
            <div key = {session.id} className="text-red-200 align-middle">
                {session.session_date}
            </div>
        ))}
        </main>
    );
}