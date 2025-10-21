param(
    [switch]$Git,
    [string]$Remote = ""
)

function Write-File($Path, $Content) {
    $dir = Split-Path -Parent $Path
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    Set-Content -Path $Path -Value $Content -Encoding UTF8
}

Write-Host "Bootstrapping Digital Laboratory project files..."

# 1) Write core config files
Write-File -Path ".\package.json" -Content @'
{
  "name": "lab-portfolio",
  "private": true,
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc -b && vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "framer-motion": "^11.0.0",
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "react-router-dom": "^6.26.2"
  },
  "devDependencies": {
    "@types/react": "^18.3.3",
    "@types/react-dom": "^18.3.0",
    "@vitejs/plugin-react": "^4.3.1",
    "autoprefixer": "^10.4.20",
    "postcss": "^8.4.47",
    "tailwindcss": "^3.4.13",
    "typescript": "^5.6.2",
    "vite": "^5.4.8"
  }
}
'@

Write-File -Path ".\vite.config.ts" -Content @'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
})

'@

Write-File -Path ".\tsconfig.json" -Content @'
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": [
      "ES2020",
      "DOM",
      "DOM.Iterable"
    ],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "baseUrl": "."
  },
  "include": [
    "src"
  ]
}
'@

Write-File -Path ".\tailwind.config.cjs" -Content @'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './index.html',
    './src/**/*.{ts,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        lab: {
          bg: '#0a0a0f',
          panel: '#101018',
          accent: '#00fff0',
          amber: '#ffb300'
        }
      },
      fontFamily: {
        mono: ['JetBrains Mono', 'ui-monospace', 'SFMono-Regular', 'Menlo', 'monospace']
      },
      boxShadow: {
        glow: '0 0 30px rgba(0,255,240,0.15)'
      }
    }
  },
  plugins: []
}

'@

Write-File -Path ".\postcss.config.cjs" -Content @'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}

'@

# 2) Public & index
Write-File -Path ".\index.html" -Content @'
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Digital Laboratory — Cesar Francis</title>
    <link rel="icon" href="/favicon.svg" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@300;400;600;700&display=swap" rel="stylesheet">
  </head>
  <body class="bg-lab-bg text-gray-200 font-mono">
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>

'@

Write-File -Path ".\public\favicon.svg" -Content @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">
  <rect width="64" height="64" rx="12" fill="#0a0a0f"/>
  <path d="M12 48L32 8l20 40H12z" fill="#00fff0"/>
</svg>

'@

# 3) Source files
Write-File -Path ".\src\index.css" -Content @'
@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  --accent: #00fff0;
}

* { outline-color: var(--accent); }

.a11y-focus:focus {
  box-shadow: 0 0 0 3px rgba(0,255,240,0.5);
}

.panel {
  background: linear-gradient(180deg, rgba(255,255,255,0.03), rgba(255,255,255,0.01));
  border: 1px solid rgba(255,255,255,0.06);
}

'@

Write-File -Path ".\src\main.tsx" -Content @'
import React from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import App from './App'
import './index.css'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </React.StrictMode>
)

'@

Write-File -Path ".\src\App.tsx" -Content @'
import { Routes, Route, useNavigate } from 'react-router-dom'
import Navbar from './components/Navbar'
import Footer from './components/Footer'
import Home from './pages/Home'
import About from './pages/About'
import Projects from './pages/Projects'
import { useEffect, useState } from 'react'
import CommandConsole from './components/CommandConsole'

export default function App() {
  const nav = useNavigate()
  const [consoleOpen, setConsoleOpen] = useState(false)

  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      if (e.key === '/') setConsoleOpen(true)
      if (e.key.toLowerCase() === 'p') nav('/projects')
      if (e.key.toLowerCase() === 'a') nav('/about')
      if (e.key.toLowerCase() === 'h') nav('/')
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [nav])

  return (
    <div className="min-h-screen flex flex-col">
      <Navbar />
      <main className="flex-1">
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/about" element={<About />} />
          <Route path="/projects" element={<Projects />} />
        </Routes>
      </main>
      <Footer />
      <CommandConsole open={consoleOpen} onClose={() => setConsoleOpen(false)} />
    </div>
  )
}

'@

Write-File -Path ".\src\data\projects.ts" -Content @'
export type Project = {
  id: string
  title: string
  year: string
  tags: string[]
  description: string
  repo?: string
  demo?: string
}

export const projects: Project[] = [
  {
    id: 'specimen-01',
    title: 'ElectroSim',
    year: '2025',
    tags: ['React', 'Three.js', 'Physics'],
    description: 'Interactive field-line visualizer for E&M (P1101). Drag charges, see field vectors and equipotential surfaces in real-time.',
    repo: 'https://github.com/yourusername/electrosim',
    demo: 'https://yourdemo.com/electrosim'
  },
  {
    id: 'specimen-02',
    title: 'Real Analysis Toolkit',
    year: '2025',
    tags: ['TypeScript', 'Algorithms'],
    description: 'Interactive proofs and examples for bounds, sup/inf, and floor function properties with step-by-step hints.',
    repo: 'https://github.com/yourusername/real-analysis-toolkit'
  },
  {
    id: 'specimen-03',
    title: 'Lebanon Bus Tracker',
    year: '2024',
    tags: ['React', 'Maps', 'APIs'],
    description: 'Minimal transit dashboard with keyboard nav and offline mode.'
  }
]

'@

Write-File -Path ".\src\components\Navbar.tsx" -Content @'
import { Link, NavLink } from 'react-router-dom'
import { motion } from 'framer-motion'

const NavItem = ({ to, label }: { to: string; label: string }) => (
  <NavLink
    to={to}
    className={({ isActive }) =>
      `px-3 py-1 rounded-xl transition a11y-focus ${
        isActive ? 'bg-lab.panel text-white' : 'hover:bg-lab.panel/60'
      }`
    }
  >
    {label}
  </NavLink>
)

export default function Navbar() {
  return (
    <motion.nav
      initial={{ y: -20, opacity: 0 }}
      animate={{ y: 0, opacity: 1 }}
      className="sticky top-0 z-40 backdrop-blur supports-[backdrop-filter]:bg-black/30 border-b border-white/10"
    >
      <div className="mx-auto max-w-6xl px-4 py-3 flex items-center justify-between">
        <Link to="/" className="text-lab-accent font-bold tracking-wide">
          {'>'} Cesar::Lab
        </Link>
        <div className="flex items-center gap-2 text-sm">
          <NavItem to="/" label="Home" />
          <NavItem to="/projects" label="Projects" />
          <NavItem to="/about" label="About" />
        </div>
      </div>
    </motion.nav>
  )
}

'@

Write-File -Path ".\src\components\Footer.tsx" -Content @'
export default function Footer() {
  return (
    <footer className="mt-16 border-t border-white/10">
      <div className="mx-auto max-w-6xl px-4 py-6 text-xs text-gray-400 flex flex-wrap items-center justify-between gap-2">
        <p>© {new Date().getFullYear()} Cesar Francis. All experiments reversible.</p>
        <p className="opacity-70">Press <kbd className="px-1 rounded bg-white/10">/</kbd> for console · <kbd className="px-1 rounded bg-white/10">p</kbd> Projects · <kbd className="px-1 rounded bg-white/10">a</kbd> About</p>
      </div>
    </footer>
  )
}

'@

Write-File -Path ".\src\components\TerminalIntro.tsx" -Content @'
import { motion } from 'framer-motion'

export default function TerminalIntro() {
  const lines = [
    'Initializing system...',
    'User detected: Cesar Francis',
    'Occupation: CS Student, Lebanese University',
    'Access granted. Welcome to the Lab.'
  ]

  return (
    <div className="panel rounded-2xl p-6 shadow-glow">
      <div className="text-lab-amber text-xs mb-2">/boot/sequence</div>
      <div className="font-mono space-y-1">
        {lines.map((t, i) => (
          <motion.div
            key={t}
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: i * 0.4 }}
          >
            {'>'} {t}
          </motion.div>
        ))}
      </div>
    </div>
  )
}

'@

Write-File -Path ".\src\components\ProjectCard.tsx" -Content @'
import { motion } from 'framer-motion'
import type { Project } from '../data/projects'

export default function ProjectCard({ project }: { project: Project }) {
  return (
    <motion.article
      initial={{ y: 12, opacity: 0 }}
      whileInView={{ y: 0, opacity: 1 }}
      viewport={{ once: true }}
      transition={{ duration: 0.4 }}
      className="panel rounded-2xl p-5 hover:shadow-glow transition"
    >
      <header className="flex items-center justify-between mb-2">
        <h3 className="text-lg font-semibold text-white">{project.title}</h3>
        <span className="text-xs text-gray-400">{project.year}</span>
      </header>
      <p className="text-sm text-gray-300 mb-3">{project.description}</p>
      <div className="flex flex-wrap gap-2">
        {project.tags.map(tag => (
          <span key={tag} className="text-[10px] uppercase tracking-wider px-2 py-1 rounded bg-white/5 border border-white/10">
            {tag}
          </span>
        ))}
      </div>
      <div className="mt-4 flex gap-3 text-sm">
        {project.demo && (
          <a className="a11y-focus underline hover:text-lab-accent" href={project.demo} target="_blank" rel="noreferrer">Demo</a>
        )}
        {project.repo && (
          <a className="a11y-focus underline hover:text-lab-accent" href={project.repo} target="_blank" rel="noreferrer">Code</a>
        )}
      </div>
    </motion.article>
  )
}

'@

Write-File -Path ".\src\components\ProjectsGrid.tsx" -Content @'
import ProjectCard from './ProjectCard'
import { projects } from '../data/projects'

export default function ProjectsGrid() {
  return (
    <section className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
      {projects.map(p => (
        <ProjectCard key={p.id} project={p} />
      ))}
    </section>
  )
}

'@

Write-File -Path ".\src\components\SkillsPanel.tsx" -Content @'
const skills = [
  { name: 'React', level: 80 },
  { name: 'TypeScript', level: 75 },
  { name: 'Tailwind', level: 85 },
  { name: 'Framer Motion', level: 70 },
  { name: 'Algorithms', level: 65 },
]

export default function SkillsPanel() {
  return (
    <div className="panel rounded-2xl p-6">
      <h3 className="text-white font-semibold mb-4">System Modules</h3>
      <div className="space-y-3">
        {skills.map(s => (
          <div key={s.name}>
            <div className="flex justify-between text-xs text-gray-400">
              <span>{s.name}</span>
              <span>{s.level}%</span>
            </div>
            <div className="h-2 bg-white/5 rounded">
              <div className="h-full rounded bg-lab-accent/80" style={{ width: `${s.level}%` }} />
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}

'@

Write-File -Path ".\src\components\ContactPanel.tsx" -Content @'
export default function ContactPanel() {
  return (
    <div className="panel rounded-2xl p-6">
      <h3 className="text-white font-semibold mb-2">Send Transmission</h3>
      <p className="text-sm text-gray-300 mb-4">Open for internships, part-time roles, and cool collaborations.</p>
      <div className="text-sm">
        <div>Email: <a className="underline hover:text-lab-accent" href="mailto:cesar@example.com">cesar@example.com</a></div>
        <div>GitHub: <a className="underline hover:text-lab-accent" href="https://github.com/yourusername" target="_blank" rel="noreferrer">@yourusername</a></div>
        <div>LinkedIn: <a className="underline hover:text-lab-accent" href="https://www.linkedin.com/in/yourusername" target="_blank" rel="noreferrer">/in/yourusername</a></div>
      </div>
    </div>
  )
}

'@

Write-File -Path ".\src\components\CommandConsole.tsx" -Content @'
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
    else if (c === 'clear') setLines(['> Interactive console ready. Type 'help’.'])
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

'@

Write-File -Path ".\src\pages\Home.tsx" -Content @'
import TerminalIntro from '../components/TerminalIntro'
import ProjectsGrid from '../components/ProjectsGrid'
import SkillsPanel from '../components/SkillsPanel'
import ContactPanel from '../components/ContactPanel'

export default function Home() {
  return (
    <div className="mx-auto max-w-6xl px-4">
      <div className="mt-10 grid gap-6 lg:grid-cols-3">
        <div className="lg:col-span-2 space-y-6">
          <TerminalIntro />
          <ProjectsGrid />
        </div>
        <div className="space-y-6">
          <SkillsPanel />
          <ContactPanel />
        </div>
      </div>
    </div>
  )
}

'@

Write-File -Path ".\src\pages\Projects.tsx" -Content @'
import ProjectsGrid from '../components/ProjectsGrid'

export default function Projects() {
  return (
    <div className="mx-auto max-w-6xl px-4 mt-10">
      <h2 className="text-white text-xl font-semibold mb-4">Specimens</h2>
      <ProjectsGrid />
    </div>
  )
}

'@

Write-File -Path ".\src\pages\About.tsx" -Content @'
export default function About() {
  return (
    <div className="mx-auto max-w-3xl px-4 mt-10">
      <div className="panel rounded-2xl p-6">
        <h2 className="text-white text-xl font-semibold mb-2">User Profile</h2>
        <p className="text-sm text-gray-300 leading-7">
          I’m Cesar Francis, a first-year CS student at the Lebanese University. I like building
          things that feel fast, minimal, and a bit nerdy — with small details that make engineers
          nod and recruiters smile. My favorite toys: React, TypeScript, Tailwind, and physics-inspired
          visualizations.
        </p>
        <ul className="text-sm text-gray-300 mt-4 list-disc pl-5 space-y-1">
          <li>Focus areas: front-end engineering, UI motion, algorithms.</li>
          <li>Values: clarity, performance, and accessible design.</li>
          <li>Fun: I turn course topics into interactive demos.</li>
        </ul>
      </div>
    </div>
  )
}

'@

# 4) Install deps
function Require-Cmd($name) {
    try { $null = Get-Command $name -ErrorAction Stop; return $true } catch { return $false }
}

if (!(Require-Cmd "node") -or !(Require-Cmd "npm")) {
    Write-Host "Node.js and npm are required. Install from https://nodejs.org/ then re-run."
    exit 1
}

Write-Host "Installing npm dependencies..."
npm install
if ($LASTEXITCODE -ne 0) { Write-Host "npm install failed."; exit 1 }

Write-Host "Installing dev/build deps..."
npm install -D tailwindcss postcss autoprefixer @vitejs/plugin-react typescript vite
if ($LASTEXITCODE -ne 0) { Write-Host "dev deps install failed."; exit 1 }

# 5) Optional Git
if ($Git) {
    if (Require-Cmd "git") {
        git init
        git add .
        git commit -m "chore: bootstrap Digital Laboratory portfolio"
        git branch -M main
        if ($Remote -ne "") { git remote add origin $Remote; git push -u origin main }
    } else {
        Write-Host "git not found; skipping git init."
    }
}

Write-Host "All set. Start dev server: npm run dev"
