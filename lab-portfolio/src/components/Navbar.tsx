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

