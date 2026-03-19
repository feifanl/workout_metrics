import Link from 'next/link'

export default function Navbar() {
  return (
    <nav className="p-4 bg-[#001f3f] text-white relative z-50 w-full">
      <Link href="/" className="text-white mr-4">Home</Link>
      <Link href="/users" className="text-white mr-4">Users</Link>
      <Link href="/about" className="text-white mr-4">About</Link>
      <Link href="/contact" className="text-white mr-4">Contact</Link>
      <Link href="/metrics" className="text-white">View Metrics</Link>
      <Link href="/login" className="text-white">Login</Link>
    </nav>
  );
}