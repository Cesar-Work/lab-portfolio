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

