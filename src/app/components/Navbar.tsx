import Link from 'next/link'

export default function Navbar() {
  return (
    <nav className="p-4 bg-[#001f3f] text-white relative z-50 w-full">
      <Link href="/" className="text-white mr-4">Home</Link>
      <Link href="/about" className="text-white mr-4">About</Link>
      <Link href="/profile" className="text-white mr-4">Profile</Link>
      <Link href="/login" className="text-white">Login</Link>
    </nav>
  );
}