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

