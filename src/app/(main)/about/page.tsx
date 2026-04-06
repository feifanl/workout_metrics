export default function AboutPage() {
  return (
    <main className="p-6">
      <h1 className = "text-4xl font-bold mb-4">About This App</h1>
      <p>Built with Next.js and Supabase. Personal project of Feifan Liu started on 11/16/2025.</p>
      <p>Work in progress!</p>

      <h1 className = "text-4xl font-bold mb-4">Contact</h1>
      <a href = "mailto:feifan.liu@utexas.edu" className="text-blue-600 visited:text-purple-600 underline hover:text-blue-800">
        feifan.liu@utexas.edu
      </a>
    </main>
  );
}