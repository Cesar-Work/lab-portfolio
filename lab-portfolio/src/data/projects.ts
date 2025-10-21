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

