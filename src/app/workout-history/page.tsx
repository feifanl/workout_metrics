import { createClient } from "@/lib/supabase/server"

export default async function WorkoutHistoryPage() {
    const supabase = await createClient();

    const { data, error } = await supabase
            .from('workout_sessions')
            .select('*')
    
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