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

