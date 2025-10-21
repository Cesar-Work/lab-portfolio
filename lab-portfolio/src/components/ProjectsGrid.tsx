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

