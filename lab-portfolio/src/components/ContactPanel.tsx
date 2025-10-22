export default function ContactPanel() {
  return (
    <div className="panel rounded-2xl p-6">
      <h3 className="text-white font-semibold mb-2">Send Transmission</h3>
      <p className="text-sm text-gray-300 mb-4">Open for internships, part-time roles, and cool collaborations.</p>
      <div className="text-sm">
        <div>Email: <a className="underline hover:text-lab-accent" href="mailto:cesar@example.com">cesarfrancis.work@gmail.com</a></div>
        <div>GitHub: <a className="underline hover:text-lab-accent" href="https://github.com/yourusername" target="_blank" rel="noreferrer">@Cesar-Work</a></div>
        <div>LinkedIn: <a className="underline hover:text-lab-accent" href="https://www.linkedin.com/in/yourusername" target="_blank" rel="noreferrer">/in/cesar-francis-358626327</a></div>
      </div>
    </div>
  )
}

