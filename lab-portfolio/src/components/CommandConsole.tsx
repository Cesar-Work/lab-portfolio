import { useEffect, useRef, useState } from 'react'
import { useNavigate } from 'react-router-dom'

const HELP = `Available commands:\n  help        Show this message\n  about       Go to About\n  projects    Go to Projects\n  contact     Show contact info\n  clear       Clear console`

export default function CommandConsole({ open, onClose }: { open: boolean; onClose: () => void }) {
  const [lines, setLines] = useState<string[]>(["> Interactive console ready. Type 'help'."])
  const [input, setInput] = useState('')
  const endRef = useRef<HTMLDivElement>(null)
  const nav = useNavigate()

  useEffect(() => {
    endRef.current?.scrollIntoView({ behavior: 'smooth' })
  }, [lines, open])

  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      if (e.key === 'Escape') onClose()
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [onClose])

  function run(cmd: string) {
    const c = cmd.trim().toLowerCase()
    if (!c) return
    setLines(prev => [...prev, `> ${c}`])
    if (c === 'help') setLines(prev => [...prev, HELP])
    else if (c === 'about') nav('/about')
    else if (c === 'projects') nav('/projects')
    else if (c === 'contact') setLines(prev => [...prev, 'Email: cesar@example.com'])
    else if (c === 'clear') setLines(["> Interactive console ready. Type 'help'."])  // ASCII-only
    else setLines(prev => [...prev, `Command not found: ${c}`])
  }

  if (!open) return null

  return (
    <div className="fixed inset-0 bg-black/70 backdrop-blur-sm flex items-end sm:items-center justify-center p-4 z-50">
      <div className="w-full max-w-3xl panel rounded-2xl p-4 shadow-glow border border-lab-accent/30">
        <div className="flex justify-between items-center mb-2 text-xs text-gray-400">
          <span>console://lab</span>
          <button onClick={onClose} className="a11y-focus px-2 py-0.5 rounded bg-white/10 hover:bg-white/20">ESC</button>
        </div>
        <div className="h-64 overflow-y-auto text-sm space-y-1">
          {lines.map((l, i) => (
            <div key={i} className="whitespace-pre-wrap">{l}</div>
          ))}
          <div ref={endRef} />
        </div>
        <form
          className="mt-3 flex gap-2"
          onSubmit={(e) => {
            e.preventDefault()
            run(input)
            setInput('')
          }}
        >
          <span className="text-lab-amber">$</span>
          <input
            autoFocus
            value={input}
            onChange={(e) => setInput(e.target.value)}
            placeholder="Type a command... try 'help'"
            className="flex-1 bg-transparent border-b border-white/20 focus:border-lab-accent/60 outline-none px-2 py-1"
          />
          <button className="a11y-focus rounded px-3 py-1 bg-white/10 hover:bg-white/20" type="submit">Run</button>
        </form>
      </div>
    </div>
  )
}
