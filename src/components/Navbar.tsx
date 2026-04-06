import Link from 'next/link'

export default function Navbar() {
  return (
    <nav className="sticky top-0 z-50 w-full bg-[#001f3f] border-b border-white/10">
      <div className="flex items-center justify-between px-6 py-3">

        <Link href="/feed" className="text-white font-bold text-lg tracking-tight">
          WorkoutMetrics
        </Link>

        <div className="flex items-center gap-1">
          <Link
            href="/workout-history"
            className="text-white/80 hover:text-white hover:bg-white/10 transition-colors text-sm font-medium rounded-full px-4 py-1.5"
          >
            Workout History
          </Link>
          <Link
            href="/about"
            className="text-white/80 hover:text-white hover:bg-white/10 transition-colors text-sm font-medium rounded-full px-4 py-1.5"
          >
            About
          </Link>
          <Link
            href="/profile"
            className="text-white/80 hover:text-white hover:bg-white/10 transition-colors text-sm font-medium rounded-full px-4 py-1.5"
          >
            Profile
          </Link>
        </div>

      </div>
    </nav>
  );
}