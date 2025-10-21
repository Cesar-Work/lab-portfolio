export default function Footer() {
  return (
    <footer className="mt-16 border-t border-white/10">
      <div className="mx-auto max-w-6xl px-4 py-6 text-xs text-gray-400 flex flex-wrap items-center justify-between gap-2">
        <p>Â© {new Date().getFullYear()} Cesar Francis. All experiments reversible.</p>
        <p className="opacity-70">Press <kbd className="px-1 rounded bg-white/10">/</kbd> for console Â· <kbd className="px-1 rounded bg-white/10">p</kbd> Projects Â· <kbd className="px-1 rounded bg-white/10">a</kbd> About</p>
      </div>
    </footer>
  )
}

