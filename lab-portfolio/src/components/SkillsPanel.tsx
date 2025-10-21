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

