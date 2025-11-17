export default function Navbar() {
  return (
    <nav className="p-4 bg-[#001f3f] text-white relative z-50 w-full">
      <a href="/" className="text-white mr-4">Home</a>
      <a href="/users" className="text-white mr-4">Users</a>
      <a href="/about" className="text-white mr-4">About</a>
      <a href="/contact" className="text-white mr-4">Contact</a>
      <a href="/metrics" className="text-white">View Metrics</a>
    </nav>
  );
}