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

